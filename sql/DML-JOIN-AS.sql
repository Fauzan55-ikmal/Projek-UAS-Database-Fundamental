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