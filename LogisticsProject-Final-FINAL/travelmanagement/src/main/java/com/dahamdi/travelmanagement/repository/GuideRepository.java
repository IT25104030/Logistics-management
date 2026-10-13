package com.dahamdi.travelmanagement.repository;

import com.dahamdi.travelmanagement.entity.Guide;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface GuideRepository extends JpaRepository<Guide, Integer> {
    List<Guide> findAllByOrderByNameAsc();
}
