# Projek UAS Database Fundamental - Kelompok 2

Repositori ini dibuat untuk memenuhi tugas besar sekaligus ujian akhir semester (UAS) pada mata kuliah **Database Fundamental** di **Politeknik TEDC Bandung**, Program Studi **Teknik Informatika** (Angkatan 2025).

Projek ini berfokus pada perancangan, normalisasi, hingga implementasi database relasional yang bersih, optimal, dan bebas dari anomali data.

---

## 👥 Anggota Kelompok 2

Berikut adalah anggota tim yang berkontribusi dalam pengerjaan projek ini:

- **Angga Saputra** (NIM: D112521001)
- **Fauzan Fauzia Fauzi** (NIM: D112521003)

---

## 📂 Struktur Repositori

Repositori ini disusun secara modular agar memudahkan proses pemeriksaan kode dan dokumentasi:

- `sql/` : Berisi kumpulan berkas query SQL yang terbagi berdasarkan fungsinya.
  - `DDL.sql` : Skema pembuatan database, tabel, primary key, dan foreign key.
  - `DML.sql` : Query manipulasi data seperti insert data sampel, update, delete, query select, filtering, dan join.
  - `DCL.sql` : Pengaturan hak akses (Privileges) database.
  - `metadata.sql` : Query untuk menampilkan struktur tabel dan informasi skema.
- `drawio/` : Berisi file mentah (_source file_) diagram hubungan antar tabel (ERD/Skema Relasi) menggunakan aplikasi Draw.io.
- `assets/` : Berisi aset pendukung seperti dokumen pedoman UAS, draf topik kelompok, serta aset gambar (PNG/JPEG) dari diagram database yang siap dilampirkan ke laporan.
- `Laporan-Kelompok-2.docx` : Berkas laporan utama berbentuk dokumen Word yang berisi analisis mendalam, tahapan normalisasi (1NF hingga 3NF/BCNF), serta penjelasan jalannya query.

---

## 🚀 Cara Penggunaan & Eksekusi Query

Untuk menjalankan atau menguji coba query SQL yang ada di repositori ini, lo bisa mengikuti langkah-langkah berikut:

1.  **Clone Repositori ini:**
    ```bash
    git clone [https://github.com/USERNAME_LO/PROJEK-UAS-DATABASE.git](https://github.com/USERNAME_LO/PROJEK-UAS-DATABASE.git)
    cd PROJEK-UAS-DATABASE
    ```
2.  **Import Skema Database (DDL):**
    Buka DBMS pilihan lo (MySQL/MariaDB via CLI atau GUI seperti MySQL Workbench / DBeaver), lalu eksekusi file `sql/DDL.sql` terlebih dahulu untuk membuat database dan tabel-tabelnya.
3.  **Isi & Manipulasi Data (DML):**
    Eksekusi file `sql/DML.sql` untuk memasukkan data sampel (_mock data_) dan menjalankan berbagai skenario query penarikan data (termasuk JOIN antar tabel).

---

## 🛠️ Teknologi yang Digunakan

- **DBMS:** MySQL / MariaDB
- **Database Tooling:** VS Code (dengan ekstensi SQL tools) / MySQL Workbench
- **Modeling Tool:** Draw.io (untuk perancangan ERD)
- **Version Control:** Git & GitHub
