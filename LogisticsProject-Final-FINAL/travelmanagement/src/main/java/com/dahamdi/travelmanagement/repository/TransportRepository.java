package com.dahamdi.travelmanagement.repository;

import com.dahamdi.travelmanagement.entity.Transport;
import org.springframework.data.jpa.repository.JpaRepository;
import java.time.LocalDate;
import java.util.List;

public interface TransportRepository extends JpaRepository<Transport, Integer> {
    boolean existsBySupplier_IdAndVehicleReferenceIgnoreCaseAndServiceDate(Integer supplierId, String reference, LocalDate date);
    List<Transport> findByDeparture_Id(Integer departureId);
    List<Transport> findAllByOrderByServiceDateDesc();
}
