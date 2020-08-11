package org.example.testtask.Service;

import org.example.testtask.Model.Vacansy;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface VacansyService {
    public List<Vacansy> add(List<Vacansy> vacansyList);
    public List<Vacansy> search(String keyword);
    public List<Vacansy> getAllVacansyBySpecIdAndAreaId(Pageable pageable, int specId, int areaId);
    public int countBySpecIdAndAreaId(int specId, int areaId);

}
