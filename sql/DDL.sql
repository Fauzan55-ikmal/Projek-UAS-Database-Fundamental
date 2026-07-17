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