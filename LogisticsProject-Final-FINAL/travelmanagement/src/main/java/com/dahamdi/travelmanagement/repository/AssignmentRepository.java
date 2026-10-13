package com.dahamdi.travelmanagement.repository;

import com.dahamdi.travelmanagement.entity.Assignment;
import org.springframework.data.jpa.repository.JpaRepository;
import java.time.LocalDate;
import java.util.List;

public interface AssignmentRepository extends JpaRepository<Assignment, Integer> {
    boolean existsByGuide_IdAndStartDateLessThanEqualAndEndDateGreaterThanEqual(Integer guideId, LocalDate end, LocalDate start);
    List<Assignment> findByDeparture_Id(Integer departureId);
    List<Assignment> findAllByOrderByStartDateDesc();
}
