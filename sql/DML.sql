-- =======================================================
-- KELOMPOK 2 - DATABASE FUNDAMENTAL
-- FILE: DML.sql (Manipulasi Data: Insert, Update, Delete)[cite: 1]
-- =======================================================

-- 1. INSERT DATA (Memasukkan Data Sampel)[cite: 1]
INSERT INTO customers (name, phone, email, address) VALUES
('Septi', '081234567890', 'septi@tedc.ac.id', 'Cimahi, Bandung'),
('Rizky', '082198765432', 'rizky@tedc.ac.id', 'Dago, Bandung'),
('Rafael', '085711223344', 'rafael@tedc.ac.id', 'Lembang, Bandung');

INSERT INTO armadas (plate_number, model, capacity, status) VALUES
('D 1125 TED', 'Toyota Hiace', 14, 'active'),
('D 2025 CC', 'Isuzu Elf', 19, 'active'),
('D 9999 WT', 'Toyota Hiace Premio', 11, 'maintenance');

INSERT INTO routes (departure_city, arrival_city, duration, base_price) VALUES
('Bandung', 'Jakarta', '02:30:00', 150000.00),
('Bandung', 'Yogyakarta', '08:00:00', 350000.00);

INSERT INTO schedules (route_id, armada_id, departure_date, departure_time, price) VALUES
(1, 1, '2026-07-20', '07:00:00', 160000.00),
(1, 2, '2026-07-20', '14:00:00', 150000.00);

INSERT INTO bookings (booking_code, customer_id, total_amount, payment_status, payment_method) VALUES
('TRX-20260001', 1, 320000.00, 'pending', 'QRIS');

INSERT INTO tickets (booking_id, schedule_id, passenger_name, passenger_id_card, seat_number) VALUES
(1, 1, 'Septi', '3204123456780001', 5),
(1, 1, 'Teman Septi', '3204123456780002', 6);