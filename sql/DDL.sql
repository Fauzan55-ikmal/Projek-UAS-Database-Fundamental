-- ========================================================
-- DATABASE: SYSTEM TIKET TRAVEL
-- ========================================================

-- 1. Membuat Database (Opsional, sesuaikan dengan skema lo)
CREATE DATABASE IF NOT EXISTS db_travel_kel2;
USE db_travel_kel2;

-- 2. Membuat Tabel-Tabel Awal (Sederhana)
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE armadas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    model VARCHAR(50) NOT NULL,
    capacity INT NOT NULL,
    status ENUM('active', 'maintenance', 'inactive') DEFAULT 'active'
);

CREATE TABLE routes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    departure_city VARCHAR(50) NOT NULL,
    arrival_city VARCHAR(50) NOT NULL,
    duration TIME NOT NULL
);

CREATE TABLE schedules (
    id INT AUTO_INCREMENT PRIMARY KEY,
    departure_date DATE NOT NULL,
    departure_time TIME NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_code VARCHAR(12) UNIQUE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    payment_status ENUM('pending', 'paid', 'cancelled') DEFAULT 'pending'
);

-- 3. Mengubah Struktur & Menambahkan Kolom Baru (ALTER TABLE)[cite: 1]
ALTER TABLE customers 
ADD COLUMN address TEXT NULL AFTER email, 
ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP AFTER address;

ALTER TABLE armadas 
ADD COLUMN plate_number VARCHAR(15) UNIQUE NOT NULL AFTER id,
ADD COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER status;

ALTER TABLE routes 
ADD COLUMN base_price DECIMAL(10, 2) NOT NULL AFTER duration;

ALTER TABLE bookings 
ADD COLUMN customer_id INT NOT NULL AFTER booking_code,
ADD COLUMN payment_method VARCHAR(30) NULL AFTER payment_status,
ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP AFTER payment_method;

ALTER TABLE schedules 
ADD COLUMN route_id INT NOT NULL AFTER id,
ADD COLUMN armada_id INT NOT NULL AFTER route_id;

-- 4. Menghubungkan Constraint Foreign Key[cite: 1]
ALTER TABLE schedules
ADD CONSTRAINT fk_schedules_routes FOREIGN KEY (route_id) REFERENCES routes(id) ON DELETE RESTRICT ON UPDATE CASCADE,
ADD CONSTRAINT fk_schedules_armadas FOREIGN KEY (armada_id) REFERENCES armadas(id) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE bookings
ADD CONSTRAINT fk_bookings_customers FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE RESTRICT ON UPDATE CASCADE;

-- 5. Membuat Tabel Transaksi Akhir (tickets)[cite: 1]
CREATE TABLE tickets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    schedule_id INT NOT NULL,
    passenger_name VARCHAR(100) NOT NULL,
    passenger_id_card VARCHAR(20) NOT NULL,
    seat_number INT NOT NULL,
    CONSTRAINT fk_tickets_bookings FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_tickets_schedules FOREIGN KEY (schedule_id) REFERENCES schedules(id) ON DELETE RESTRICT ON UPDATE CASCADE
);