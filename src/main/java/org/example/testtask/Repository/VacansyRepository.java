package org.example.testtask.Repository;

import org.example.testtask.Model.Vacansy;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("vacansyRepository")
public interface VacansyRepository extends JpaRepository<Vacansy, Integer> {

    @Query(value = "SELECT v FROM Vacansy v WHERE v.name LIKE '%' || :keyword || '%'"
            + " OR v.employer.name LIKE '%' || :keyword || '%'"
            )
    public List<Vacansy> search(@Param("keyword") String keyword);

    public List<Vacansy> findAllBySpecializationIdAndAreaId(Pageable pageable, int specId, int areaId);

    public int countBySpecializationIdAndAreaId(int specId, int areaId);
}
