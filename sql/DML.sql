-- =================================================================
-- FASE 4: DATA MANIPULATION LANGUAGE (DML) - SYSTEM TIKET TRAVEL
-- =================================================================

-- -----------------------------------------------------------------
-- 1. KONDISI AWAL BASIS DATA (INSERT AWAL - 3 DATA)
-- -----------------------------------------------------------------

-- Memasukkan 3 Data Master Pelanggan Awal
INSERT INTO customers (name, phone, email, address) VALUES
('Septi', '081234567890', 'septi@tedc.ac.id', 'Cimahi, Bandung'),
('Rizky', '082198765432', 'rizky@tedc.ac.id', 'Dago, Bandung'),
('Rafael', '085711223344', 'rafael@tedc.ac.id', 'Lembang, Bandung');

-- Memasukkan 3 Data Master Armada Awal
INSERT INTO armadas (plate_number, model, capacity, status) VALUES
('D 1125 TED', 'Toyota Hiace', 14, 'active'),
('D 2025 CC', 'Isuzu Elf', 19, 'active'),
('D 9999 WT', 'Toyota Hiace Premio', 11, 'maintenance');

-- Memasukkan 3 Data Master Rute Awal
INSERT INTO routes (departure_city, arrival_city, duration, base_price) VALUES
('Bandung', 'Jakarta', '02:30:00', 150000.00),
('Bandung', 'Yogyakarta', '08:00:00', 350000.00),
('Bandung', 'Semarang', '06:30:00', 280000.00);

-- Memasukkan 3 Data Jadwal Awal
INSERT INTO schedules (route_id, armada_id, departure_date, departure_time, price) VALUES
(1, 1, '2026-07-20', '07:00:00', 160000.00),
(1, 2, '2026-07-20', '14:00:00', 160000.00),
(2, 2, '2026-07-21', '08:00:00', 365000.00);

-- Memasukkan 3 Data Booking Awal
INSERT INTO bookings (booking_code, customer_id, total_amount, payment_status, payment_method) VALUES
('TRX-20260001', 1, 320000.00, 'pending', 'QRIS'),
('TRX-20260002', 2, 365000.00, 'paid', 'Transfer Bank'),
('TRX-20260003', 3, 290000.00, 'pending', 'Cash');

-- Memasukkan 3 Data Tiket Awal
INSERT INTO tickets (booking_id, schedule_id, passenger_name, passenger_id_card, seat_number) VALUES
(1, 1, 'Septi', '3204123456780001', 5),
(1, 1, 'Teman Septi', '3204123456780002', 6),
(2, 3, 'Rizky', '3204987654320001', 3);


-- -----------------------------------------------------------------
-- 2. TAHAP PEMBARUAN & PENAMBAHAN DATA (MEMENUHI SYARAT MINIMAL 5 DATA)
-- -----------------------------------------------------------------

-- Menambahkan data pelanggan ke-4 dan ke-5
INSERT INTO customers (name, phone, email, address) VALUES
('Fauzan', '089988776655', 'fauzan@tedc.ac.id', 'Kopo, Bandung'),
('Dani', '081322446688', 'dani@tedc.ac.id', 'Cileunyi, Bandung');

-- Menambahkan data armada ke-4 dan ke-5
INSERT INTO armadas (plate_number, model, capacity, status) VALUES
('D 4455 AB', 'Toyota Hiace Premio', 11, 'active'),
('D 7788 XYZ', 'Isuzu Elf', 19, 'inactive');

-- Menambahkan data rute ke-4 dan ke-5
INSERT INTO routes (departure_city, arrival_city, duration, base_price) VALUES
('Bandung', 'Surabaya', '10:00:00', 450000.00),
('Bandung', 'Sukabumi', '03:00:00', 100000.00);

-- Menambahkan data jadwal ke-4 dan ke-5
INSERT INTO schedules (route_id, armada_id, departure_date, departure_time, price) VALUES
(3, 4, '2026-07-21', '20:00:00', 290000.00),
(5, 1, '2026-07-22', '10:00:00', 110000.00);

-- Menambahkan data booking ke-4 dan ke-5
INSERT INTO bookings (booking_code, customer_id, total_amount, payment_status, payment_method) VALUES
('TRX-20260004', 4, 110000.00, 'paid', 'QRIS'),
('TRX-20260005', 5, 160000.00, 'cancelled', 'Transfer Bank');

-- Menambahkan data tiket ke-4 dan ke-5
INSERT INTO tickets (booking_id, schedule_id, passenger_name, passenger_id_card, seat_number) VALUES
(3, 4, 'Rafael', '3204112233440001', 1),
(4, 5, 'Fauzan', '3204998877660001', 2);


-- -----------------------------------------------------------------
-- 3. TAHAP MANIPULASI INTERAKTIF (UPDATE & DELETE OPERASIONAL)
-- -----------------------------------------------------------------

-- [UPDATE - Skenario 1]: Konfirmasi pembayaran kasir untuk booking awal
UPDATE bookings 
SET payment_status = 'paid' 
WHERE booking_code = 'TRX-20260001';

-- [UPDATE - Skenario 2]: Penyesuaian tarif musiman/BBM naik Rp15.000 untuk Rute Yogyakarta (ID: 2)
UPDATE schedules 
SET price = price + 15000.00 
WHERE route_id = 2;

-- [UPDATE - Skenario 3]: Perubahan status armada pasca-maintenance berkala selesai
UPDATE armadas 
SET status = 'active' 
WHERE plate_number = 'D 9999 WT';

-- [UPDATE - Skenario 4]: Pelanggan melakukan update nomor HP baru di sistem
UPDATE customers 
SET phone = '081399998888' 
WHERE name = 'Dani';

-- [DELETE - Skenario 1]: Uji coba ON DELETE CASCADE (Batal booking otomatis hapus manifest tiket)
DELETE FROM bookings 
WHERE booking_code = 'TRX-20260001';

-- [DELETE - Skenario 2]: Uji coba ON DELETE RESTRICT (Proteksi rute agar tidak bisa dihapus jika jadwal aktif)
DELETE FROM routes 
WHERE id = 5;

-- =======================================================
-- 4. READ DATA / REPORT (Simulasi JOIN & AS Alias)
-- =======================================================

-- 1. JOIN Tiket dengan Booking (2 Tabel)
SELECT 
    t.passenger_name AS 'Nama Penumpang',
    b.booking_code AS 'Kode Booking',
    b.payment_status AS 'Status Pembayaran'
FROM tickets AS t
JOIN bookings AS b ON t.booking_id = b.id;

-- 2. JOIN Tiket, Booking, dan Jadwal (3 Tabel)
SELECT 
    t.passenger_name AS 'Nama Penumpang',
    b.booking_code AS 'Kode Booking',
    s.departure_date AS 'Tanggal Pergi',
    s.departure_time AS 'Jam Keberangkatan'
FROM tickets AS t
JOIN bookings AS b ON t.booking_id = b.id
JOIN schedules AS s ON t.schedule_id = s.id;

-- 3. JOIN Lengkap Semua Tabel Berelasi (5 Tabel)
SELECT 
    t.passenger_name AS 'Nama Penumpang',
    t.seat_number AS 'Nomor Kursi',
    b.booking_code AS 'Kode Booking',
    r.departure_city AS 'Kota Asal',
    r.arrival_city AS 'Kota Tujuan',
    s.departure_date AS 'Tanggal Keberangkatan',
    a.model AS 'Armada Kendaraan'
FROM tickets AS t
JOIN bookings AS b ON t.booking_id = b.id
JOIN schedules AS s ON t.schedule_id = s.id
JOIN routes AS r ON s.route_id = r.id
JOIN armadas AS a ON s.armada_id = a.id;