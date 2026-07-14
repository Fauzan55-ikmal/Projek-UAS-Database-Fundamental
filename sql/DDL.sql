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
