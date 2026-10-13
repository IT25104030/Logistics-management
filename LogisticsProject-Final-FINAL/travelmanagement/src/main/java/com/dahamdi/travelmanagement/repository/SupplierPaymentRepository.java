package com.dahamdi.travelmanagement.repository;

import com.dahamdi.travelmanagement.entity.SupplierPayment;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface SupplierPaymentRepository extends JpaRepository<SupplierPayment, Integer> {
    List<SupplierPayment> findByDeparture_Id(Integer departureId);
    List<SupplierPayment> findAllByOrderByPaymentDateDesc();
}
