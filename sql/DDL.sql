-- ========================================================
-- DATABASE: SYSTEM TIKET TRAVEL
-- ========================================================

-- Membuat Tabel Customers
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
) 

-- Membuat Tabel Armadas
CREATE TABLE armadas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    model VARCHAR(50) NOT NULL, -- Contoh: Toyota Hiace, Isuzu Elf
    capacity INT NOT NULL,
    status ENUM('active', 'maintenance', 'inactive') DEFAULT 'active'
) 

-- Membuat Tabel Routes
CREATE TABLE routes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    departure_city VARCHAR(50) NOT NULL,
    arrival_city VARCHAR(50) NOT NULL,
    duration TIME NOT NULL, -- Contoh: '02:30:00' artinya 2 jam 30 menit
) 

-- Membuat Tabel Schedules
CREATE TABLE schedules (
    id INT AUTO_INCREMENT PRIMARY KEY,
    departure_date DATE NOT NULL,
    departure_time TIME NOT NULL,
    price DECIMAL(10, 2) NOT NULL -- Harga dinamis menyesuaikan waktu operasional
) 

