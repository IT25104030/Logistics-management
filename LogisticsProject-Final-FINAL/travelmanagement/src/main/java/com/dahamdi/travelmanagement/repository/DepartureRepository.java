package com.dahamdi.travelmanagement.repository;
import com.dahamdi.travelmanagement.entity.Departure;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
public interface DepartureRepository extends JpaRepository<Departure, Integer> {
    boolean existsByReferenceIgnoreCase(String reference);
    List<Departure> findAllByOrderByStartDateAsc();
}
