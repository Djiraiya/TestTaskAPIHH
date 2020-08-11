package org.example.testtask.Controller;

import org.example.testtask.Model.Items;
import org.example.testtask.Model.Vacansy;
import org.example.testtask.Service.VacansyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping
public class VacansyController {

    @Autowired
    private VacansyService vacansyService;

    private double pages = 0;

    @GetMapping("/")
    public String listCustomers(Model theModel) {
        return "index";
    }

    @GetMapping(path = "/", params = {"page", "specialization", "area"})
    public String pageWithSpecAndArea (Model theModel, @RequestParam int page, @RequestParam int specialization, @RequestParam int area) {

        Pageable pageable = PageRequest.of(page, 20);
        List<Vacansy> vacansyList = vacansyService.getAllVacansyBySpecIdAndAreaId(pageable, specialization, area);
        theModel.addAttribute("pageCount", Math.ceil(pages));
        theModel.addAttribute("vacansyList", vacansyList);
        return "index";
    }

    @GetMapping(path = "/", params = {"specialization", "area"})
    public String specializationWithArea (Model theModel, @RequestParam int specialization, @RequestParam int area) {

        pages = vacansyService.countBySpecIdAndAreaId(specialization, area) / 20.0;
        Pageable pageable = PageRequest.of(0, 20);
        List<Vacansy> vacansyList = vacansyService.getAllVacansyBySpecIdAndAreaId(pageable, specialization, area);
        theModel.addAttribute("pageCount", Math.ceil(pages));
        theModel.addAttribute("vacansyList", vacansyList);
        return "index";
    }

    @GetMapping("/search")
    public String search(Model theModel, @RequestParam String keyword) {
        List<Vacansy> result = vacansyService.search(keyword);
        theModel.addAttribute("result", result);
        return "search";
    }

    @GetMapping("/export")
    public String export (Model theModel, @RequestParam int specialization, @RequestParam int area) {

        RestTemplate restTemplate = new RestTemplate();

        String hhapi = String.format("https://api.hh.ru/vacancies?area=%d&specialization=%d&per_page=20&page=%d", area, specialization, 0);
        Items response = restTemplate.getForObject(
                hhapi,
                Items.class);
        pages = response.getPages();
        List<Vacansy> rawVacansy = response.getItems();

        for (int i = 1; i < pages; i++) {
            hhapi = String.format("https://api.hh.ru/vacancies?area=%d&specialization=%d&per_page=20&page=%d", area, specialization, i);
            response = restTemplate.getForObject(
                    hhapi,
                    Items.class);
            rawVacansy.addAll(response.getItems());
        }
        rawVacansy.forEach(x -> x.setSpecializationId(specialization));
        rawVacansy.forEach(y -> y.setAreaId(area));
        vacansyService.add(rawVacansy);
        theModel.addAttribute("pageCount", pages);
        return "test";
    }

}
