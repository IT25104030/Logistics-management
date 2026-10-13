-- Fresh standalone logistics database. Does not change travel_management_db.
CREATE DATABASE IF NOT EXISTS travel_logistics_db;
USE travel_logistics_db;
CREATE TABLE IF NOT EXISTS departure (
    departure_id INT AUTO_INCREMENT PRIMARY KEY,
    reference VARCHAR(20) NOT NULL UNIQUE,
    package_name VARCHAR(100) NOT NULL,
    destination VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    CONSTRAINT chk_departure_dates CHECK (end_date >= start_date)
);
CREATE TABLE IF NOT EXISTS supplier (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(20) NOT NULL,
    contact_phone VARCHAR(30),
    contract_start DATE NOT NULL,
    contract_end DATE NOT NULL,
    room_capacity INT,
    CONSTRAINT chk_supplier_dates CHECK (contract_end >= contract_start),
    CONSTRAINT chk_room_capacity CHECK (room_capacity IS NULL OR room_capacity > 0)
);

CREATE TABLE IF NOT EXISTS hotel_booking (
    hotel_booking_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_id INT NOT NULL,
    departure_id INT NOT NULL,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    rooms INT NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id),
    FOREIGN KEY (departure_id) REFERENCES departure(departure_id),
    CONSTRAINT chk_hotel_dates CHECK (check_out > check_in),
    CONSTRAINT chk_hotel_rooms CHECK (rooms > 0),
    CONSTRAINT chk_hotel_cost CHECK (cost >= 0)
);

CREATE TABLE IF NOT EXISTS transport (
    transport_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_id INT NOT NULL,
    departure_id INT NOT NULL,
    mode VARCHAR(20) NOT NULL,
    vehicle_reference VARCHAR(60) NOT NULL,
    service_date DATE NOT NULL,
    seats INT NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id),
    FOREIGN KEY (departure_id) REFERENCES departure(departure_id),
    CONSTRAINT chk_transport_seats CHECK (seats > 0),
    CONSTRAINT chk_transport_cost CHECK (cost >= 0)
);

CREATE TABLE IF NOT EXISTS guide (
    guide_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL,
    phone VARCHAR(30),
    daily_rate DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id),
    CONSTRAINT chk_guide_rate CHECK (daily_rate >= 0)
);

CREATE TABLE IF NOT EXISTS assignment (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    departure_id INT NOT NULL,
    guide_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (departure_id) REFERENCES departure(departure_id),
    FOREIGN KEY (guide_id) REFERENCES guide(guide_id),
    CONSTRAINT chk_assignment_dates CHECK (end_date >= start_date),
    CONSTRAINT chk_assignment_cost CHECK (cost >= 0)
);

CREATE TABLE IF NOT EXISTS supplier_payment (
    supplier_payment_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_id INT NOT NULL,
    departure_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    reference VARCHAR(60),
    FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id),
    FOREIGN KEY (departure_id) REFERENCES departure(departure_id),
    CONSTRAINT chk_supplier_payment_amount CHECK (amount > 0)
);

-- Example: total supplier cost for each departure.
SELECT f.reference,
       COALESCE(h.hotel_cost, 0) + COALESCE(t.transport_cost, 0) + COALESCE(a.staff_cost, 0) AS supplier_cost
FROM departure f
LEFT JOIN (SELECT departure_id, SUM(cost) hotel_cost FROM hotel_booking GROUP BY departure_id) h ON h.departure_id = f.departure_id
LEFT JOIN (SELECT departure_id, SUM(cost) transport_cost FROM transport GROUP BY departure_id) t ON t.departure_id = f.departure_id
LEFT JOIN (SELECT departure_id, SUM(cost) staff_cost FROM assignment GROUP BY departure_id) a ON a.departure_id = f.departure_id;
