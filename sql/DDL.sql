-- ============================================================================
-- KELOMPOK 2 - DATABASE FUNDAMENTAL
-- STASIUN SIMULASI: SKRIP DDL UTUH (FULL STRUCTURE & CONSTRAINTS)
-- ============================================================================

-- 1. PEMBUATAN DATABASE
CREATE DATABASE IF NOT EXISTS db_travel_kel2;
USE db_travel_kel2;

-- ============================================================================
-- 2. PEMBUATAN TABEL AWAL (STRUKTUR INTI / MASTER)
-- ============================================================================

-- Tabel Customers (Master Pelanggan)
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Tabel Armadas (Master Armada Kendaraan)
CREATE TABLE armadas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    model VARCHAR(50) NOT NULL,
    capacity INT NOT NULL,
    status ENUM('active', 'maintenance', 'inactive') DEFAULT 'active'
);

-- Tabel Routes (Master Rute Perjalanan)
CREATE TABLE routes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    departure_city VARCHAR(50) NOT NULL,
    arrival_city VARCHAR(50) NOT NULL,
    duration TIME NOT NULL
);

-- Tabel Schedules (Jadwal Keberangkatan - Awal Sederhana)
CREATE TABLE schedules (
    id INT AUTO_INCREMENT PRIMARY KEY,
    departure_date DATE NOT NULL,
    departure_time TIME NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- Tabel Bookings (Transaksi Booking Induk - Awal Sederhana)
CREATE TABLE bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_code VARCHAR(12) UNIQUE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    payment_status ENUM('pending', 'paid', 'cancelled') DEFAULT 'pending'
);


-- ============================================================================
-- 3. MODIFIKASI STRUKTUR & PENAMBAHAN KOLOM BARU (MIGRASI SKEMA - ALTER)
-- ============================================================================

-- Menambahkan kolom alamat dan waktu daftar pada tabel Customers
ALTER TABLE customers 
ADD COLUMN address TEXT NULL AFTER email, 
ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP AFTER address;

-- Menambahkan kolom nomor plat unik dan log pembaruan otomatis pada tabel Armadas
ALTER TABLE armadas 
ADD COLUMN plate_number VARCHAR(15) UNIQUE NOT NULL AFTER id,
ADD COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER status;

-- Menambahkan kolom harga dasar perjalanan pada tabel Routes
ALTER TABLE routes 
ADD COLUMN base_price DECIMAL(10, 2) NOT NULL AFTER duration;

-- Menambahkan kolom relasi customer, metode bayar, dan log transaksi pada tabel Bookings
ALTER TABLE bookings 
ADD COLUMN customer_id INT NOT NULL AFTER booking_code,
ADD COLUMN payment_method VARCHAR(30) NULL AFTER payment_status,
ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP AFTER payment_method;

-- Menambahkan kolom relasi rute dan armada pada tabel Schedules
ALTER TABLE schedules 
ADD COLUMN route_id INT NOT NULL AFTER id,
ADD COLUMN armada_id INT NOT NULL AFTER route_id;


-- ============================================================================
-- 4. PENGUNCIAN CONSTRAINT RELASI (FOREIGN KEY INTEGRITY)
-- ============================================================================

-- Menghubungkan Relasi Kunci Tamu pada Tabel Schedules (Jadwal)
ALTER TABLE schedules
ADD CONSTRAINT fk_schedules_routes FOREIGN KEY (route_id) REFERENCES routes(id) ON DELETE RESTRICT ON UPDATE CASCADE,
ADD CONSTRAINT fk_schedules_armadas FOREIGN KEY (armada_id) REFERENCES armadas(id) ON DELETE RESTRICT ON UPDATE CASCADE;

-- Menghubungkan Relasi Kunci Tamu pada Tabel Bookings (Transaksi Induk)
ALTER TABLE bookings
ADD CONSTRAINT fk_bookings_customers FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE RESTRICT ON UPDATE CASCADE;


-- ============================================================================
-- 5. PEMBUATAN TABEL TRANSAKSI ANAK / AKHIR (DEPENDENT MANIFEST)
-- ============================================================================

-- Tabel Tickets (Manifes Penumpang Akhir)
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