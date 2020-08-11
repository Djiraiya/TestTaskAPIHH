package org.example.testtask.Service;

import org.example.testtask.Model.Vacansy;
import org.example.testtask.Repository.VacansyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.function.Supplier;

import java.util.List;

@Service
public class VacansyServiceImpl implements VacansyService {

    @Autowired
    private VacansyRepository vacansyRepository;

    @Override
    public List<Vacansy> add(List<Vacansy> vacansyList) {
        return vacansyRepository.saveAll(vacansyList);
    }

    @Override
    public List<Vacansy> search(String keyword) {
        return vacansyRepository.search(keyword);
    }

    @Override
    public List<Vacansy> getAllVacansyBySpecIdAndAreaId(Pageable pageable, int specId, int areaId) {
        return vacansyRepository.findAllBySpecializationIdAndAreaId(pageable, specId, areaId);
    }

    @Override
    public int countBySpecIdAndAreaId(int specId, int areaId) {
        return vacansyRepository.countBySpecializationIdAndAreaId(specId, areaId);
    }


}
