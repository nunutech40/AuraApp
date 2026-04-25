# Product Requirements Document (PRD): BidadariMeter (iOS App Edition)

## 1. Pendahuluan
### 1.1 Tujuan Produk
Menciptakan aplikasi penilai "Aura" dan "Karisma" dari foto wajah, yang didesain secara khusus untuk **pembuatan konten teknologi (Tiktok/Reels) dan portofolio profesional**. Aplikasi akan berbentuk *Mobile App* (iOS) yang menonjolkan integrasi Flutter dengan *Native iOS Frameworks*. Tujuan utamanya adalah menciptakan *wow factor* visual bagi penonton dan membuktikan kemampuan *decoupled architecture* menggunakan Platform Channels.

### 1.2 Target Pengguna
*   *Tech Content Creators* / Developer yang butuh *showcase* aplikasi langsung dari layar iPhone.
*   Perekrut (sebagai portofolio *Flutter - Native bridging*).

## 2. Fitur Utama (Fokus Konten & Mobile Experience)
### 2.1 Multi-Image Gallery Picker
*   Pengguna mengetuk tombol *futuristik* di layar utama iPhone.
*   Sistem membuka galeri bawaan iOS (Photos) dan memungkinkan pengguna memilih banyak foto sekaligus (*Batch Selection*).

### 2.2 Native Processing via MethodChannel
*   Secara kasat mata, aplikasi berjalan di Flutter, namun pengolahan wajah berat dilakukan secara *native* dan instan tanpa internet (*100% offline*) menggunakan mesin bawaan Apple.

### 2.3 Cinematic Scanning Animation (Gimmick)
*   Sembari menunggu hasil pemrosesan iOS, antarmuka Flutter akan menampilkan animasi yang *eye-catching*.
*   *Efek Visual:* Garis laser yang memindai *thumbnail* foto, partikel *glow* yang berdenyut (*pulsating*), dan teks gaya mesin tik (*Typewriter Effect*) seperti: *"Mengalibrasi frekuensi aura..."*, *"Membaca simetri cakra..."*.

### 2.4 Visual Leaderboard Output
*   Setelah selesai, UI berpindah ke layar *Leaderboard*.
*   Menampilkan UI *Card* elegan bergaya *Glassmorphism* dengan urutan peringkat.
*   Peringkat 1 mendapatkan animasi *Glow* emas khusus dan *progress bar* persentase yang memukau.

## 3. Minimum Viable Product (MVP)
*   **Platform Eksklusif:** Hanya difokuskan untuk di-*build* dan berjalan di perangkat iOS (iPhone/Simulator) karena *engine* mengandalkan *Vision Framework* milik Apple.
*   **Input Terbatas:** Murni mengambil gambar dari *Image Picker* (Galeri). Belum mendukung input *live camera* (kamera langsung).
*   **Logika Tertutup:** Perhitungan matematika disembunyikan sepenuhnya di *layer native* Swift. Flutter hanya menerima data nama file dan angka skor akhirnya saja.
*   **Validasi Standar:** Jika *Vision* Apple tidak mengenali wajah di foto, skor dikembalikan sebagai 0 dan UI Flutter akan melabelinya sebagai *"Aura tak terbaca"*.
