package com.dahamdi.travelmanagement.repository;

import com.dahamdi.travelmanagement.entity.HotelBooking;
import org.springframework.data.jpa.repository.JpaRepository;
import java.time.LocalDate;
import java.util.List;

public interface HotelBookingRepository extends JpaRepository<HotelBooking, Integer> {
    List<HotelBooking> findBySupplier_IdAndCheckInLessThanAndCheckOutGreaterThan(Integer supplierId, LocalDate end, LocalDate start);
    List<HotelBooking> findByDeparture_Id(Integer departureId);
    List<HotelBooking> findAllByOrderByCheckInDesc();
}
