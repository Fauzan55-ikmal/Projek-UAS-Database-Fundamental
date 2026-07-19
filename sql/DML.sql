-- =================================================================
-- DATA MANIPULATION LANGUAGE (DML) - SYSTEM TIKET TRAVEL
-- =================================================================

-- -----------------------------------------------------------------
-- 1. KONDISI AWAL BASIS DATA 
-- -----------------------------------------------------------------

-- Memasukkan 3 Data Master Pelanggan Awal
INSERT INTO customers (name, phone, email) VALUES
('Angga Saputra', '081234567890', 'angga_saputra@gmail.com'),
('Fauzan Fauzia Fauzi', '082198765432', 'fauzanfauziafauzi@gmail.com'),
('Udin Berlin', '085711223344', 'asepberlin12@tedc.ac.id');

-- Memasukkan 3 Data Master Armada Awal
INSERT INTO armadas (plate_number, model, capacity, status) VALUES
('D 1125 TED', 'Toyota Hiace', 14, 'active'),
('D 2025 CC', 'Isuzu Elf', 19, 'active'),
('D 9999 WT', 'Toyota Hiace Premio', 12, 'maintenance');

-- Memasukkan 3 Data Master Rute Awal
INSERT INTO routes (departure_city, arrival_city, duration, base_price) VALUES
('Bandung', 'Jakarta', '02:30:00', 200000.00),
('Bandung', 'Yogyakarta', '08:00:00', 350000.00),
('Bandung', 'Semarang', '06:30:00', 280000.00);

-- Memasukkan 3 Data Jadwal Awal
INSERT INTO schedules (route_id, armada_id, departure_date, departure_time, price) VALUES
(1, 1, '2026-07-20', '07:00:00', 160000.00),
(1, 2, '2026-07-20', '14:00:00', 325000.00),
(2, 2, '2026-07-21', '08:00:00', 250000.00);

-- Memasukkan 3 Data Booking Awal
INSERT INTO bookings (booking_code, customer_id, total_amount, payment_status, payment_method) VALUES
('TRX-20260001', 1, 160000.00, 'pending', 'QRIS'),
('TRX-20260002', 2, 325000.00, 'paid', 'Transfer Bank'),
('TRX-20260003', 3, 250000.00, 'paid', 'Cash');

-- Memasukkan 3 Data Tiket Awal
INSERT INTO tickets (booking_id, schedule_id, passenger_name, passenger_id_card, seat_number) VALUES
(1, 1, 'Angga Saputra', '3204123456780001', 5),
(1, 1, 'Fauzan Fauzia Fauzi', '3204123456780002', 6),
(2, 3, 'Udin Berlin', '3204987654320001', 3);

-- -----------------------------------------------------------------
-- 2. TAHAP PEMBARUAN & PENAMBAHAN DATA 
-- -----------------------------------------------------------------

-- Menambahkan data pelanggan ke-4 dan ke-5
INSERT INTO customers (name, phone, email, address) VALUES
('Juni', '089988776655', 'juniatun@tbk.ac.id', 'Kopo, Bandung'),
('Ranti', '081322446688', 'ranti@tbk.ac.id', 'Cileunyi, Bandung');


-- Menambahkan data armada ke-4 dan ke-5
INSERT INTO armadas (plate_number, model, capacity, status) VALUES
('D 4455 AB', 'Toyota Hiace Premio', 12, 'active'),
('D 7788 XYZ', 'Isuzu Elf', 19, 'inactive');

-- Menambahkan data rute ke-4 dan ke-5
INSERT INTO routes (departure_city, arrival_city, duration, base_price) VALUES
('Bandung', 'Surabaya', '10:00:00', 450000.00),
('Bandung', 'Sukabumi', '01:30:00', 85000.00);

-- Menambahkan data jadwal ke-4 dan ke-5
INSERT INTO schedules (route_id, armada_id, departure_date, departure_time, price) VALUES
(3, 4, '2026-07-21', '20:00:00', 290000.00),
(5, 1, '2026-07-22', '10:00:00', 85000.00);

-- Menambahkan data booking ke-4 dan ke-5
INSERT INTO bookings (booking_code, customer_id, total_amount, payment_status, payment_method) VALUES
('TRX-20260004', 4, 290000.00, 'paid', 'QRIS'),
('TRX-20260005', 5, 85000.00, 'cancelled', 'Transfer Bank');

-- Menambahkan data tiket ke-4 dan ke-5
INSERT INTO tickets (booking_id, schedule_id, passenger_name, passenger_id_card, seat_number) VALUES
(6, 1, 'Juni', '3204112233440001', 1),
(7, 2, 'Ranti', '3204998877660001', 2);

-- -----------------------------------------------------------------
-- 3. TAHAP MANIPULASI INTERAKTIF 
-- -----------------------------------------------------------------

-- Konfirmasi pembayaran kasir untuk booking awal
UPDATE bookings 
SET payment_status = 'paid' 
WHERE booking_code = 'TRX-20260001';

-- Penyesuaian tarif musiman/BBM naik Rp15.000 untuk Rute Yogyakarta (ID: 2)
UPDATE schedules 
SET price = price + 15000.00 
WHERE route_id = 2;

-- Perubahan status armada pasca-maintenance berkala selesai
UPDATE armadas 
SET status = 'active' 
WHERE plate_number = 'D 9999 WT';

-- Pelanggan melakukan update nomor HP baru di sistem
UPDATE customers 
SET phone = '081399998888' 
WHERE name = 'Ranti';

-- Uji coba ON DELETE CASCADE (Batal booking otomatis hapus manifest tiket)
DELETE FROM bookings 
WHERE booking_code = 'TRX-20260003';

-- Uji coba ON DELETE RESTRICT (Proteksi rute agar tidak bisa dihapus jika jadwal aktif)
DELETE FROM routes 
WHERE id = 4;