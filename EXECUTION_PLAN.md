# Execution Plan: AuraApp (Clean Architecture Edition)

Rencana eksekusi ini menggunakan pendekatan **Clean Architecture**, **Dependency Injection**, dan **MethodChannel** untuk memastikan kualitas *codebase* level *Enterprise/Senior*.

---

## 🛠️ Fase 1: Proyek Setup & Izin Akses (Scaffolding)
*   **Tujuan:** Inisialisasi struktur Flutter dan konfigurasi awal.
*   **Tugas AI:**
    1.  Menjalankan perintah `flutter create --org com.nunu aura_app`.
    2.  Menambahkan dependensi utama di `pubspec.yaml`: `get_it` (untuk DI), `flutter_bloc` (untuk State Management), `equatable`, dan `image_picker`.
    3.  Membuat kerangka folder Clean Architecture (`data/`, `domain/`, `presentation/`) di dalam `lib/`.
    4.  Menambahkan kode izin akses Galeri (`NSPhotoLibraryUsageDescription`) di `ios/Runner/Info.plist`.

## 🏛️ Fase 2: Membangun Domain Layer (Pusat Logika)
*   **Tujuan:** Mendefinisikan entitas, aturan, dan *Use Case*.
*   **Tugas AI:**
    1.  Membuat kelas `AuraEntity` (menyimpan *path* dan *skor*).
    2.  Membuat antarmuka/kontrak `IAuraRepository` yang memiliki *method* `calculateAuraScores(List<String> paths)`.
    3.  Membuat kelas `CalculateAuraUseCase` yang bergantung pada `IAuraRepository`.

## 🔌 Fase 3: Membangun Data Layer & MethodChannel
*   **Tujuan:** Menyiapkan jembatan penghubung (Data Source) ke ekosistem Native iOS.
*   **Tugas AI:**
    1.  Membuat `AuraModel` yang memiliki fungsi *parsing* dari JSON/Map Native ke *Entity* Dart.
    2.  Membuat kelas `NativeAuraDataSource` yang bertugas menjalankan fungsi eksekusi `MethodChannel('com.nunu.auraapp/engine').invokeMethod()`.
    3.  Membuat kelas `AuraRepositoryImpl` (mengimplementasikan `IAuraRepository` dari Phase 2) yang memanggil *Data Source* dan mengubah *Model* ke *Entity*.

## 💉 Fase 4: Dependency Injection (DI) & State Management
*   **Tujuan:** Menyuntikkan dependensi agar UI dan Logika bekerja secara independen.
*   **Tugas AI:**
    1.  Membuat file `injection.dart` dan mengonfigurasi `get_it`.
    2.  Mendaftarkan *Data Source*, *Repository*, *UseCase*, dan *Cubit/BLoC* di `get_it`.
    3.  Membuat `AuraCubit` di lapisan *Presentation* untuk menangani *State* (`Initial`, `Scanning`, `Success`, `Error`).

## 🧠 Fase 5: Membangun Otak Native iOS (Swift & Vision)
*   **Tujuan:** Menulis mesin utama kalkulator "Rasio Emas" (*Processor*).
*   **Tugas AI:**
    1.  Membuka `ios/Runner/AppDelegate.swift`.
    2.  Meng- *import* `Vision` *framework* dan menyambungkan respon *MethodChannel*.
    3.  Menulis logika iterasi *UIImage*, mengekstrak titik koordinat wajah (`VNDetectFaceLandmarksRequest`), melakukan hitungan matematis dengan Rasio Emas (1.618), dan mengekspor hasilnya sebagai rentetan Dictionary/JSON ke Flutter.

## 🎨 Fase 6: UI Presentation & WOW Factor Animations
*   **Tujuan:** Membuat Tampilan yang memukau untuk konten.
*   **Tugas AI:**
    1.  Menyiapkan UI Utama (Home Page) dengan gaya *Dark Mode* & *Glassmorphism* lengkap dengan tombol Image Picker.
    2.  Menyambungkan tombol dengan eksekusi `AuraCubit`.
    3.  Membuat animasi *Laser Scanner* (CustomPaint) dan efek mesin tik (*Typewriter*) yang dipicu secara khusus saat state *Cubit* sedang memancarkan state `Scanning`.

## 🏆 Fase 7: Visual Leaderboard & Transisi
*   **Tujuan:** Mengelola hasil akhir (*Success State*) dengan UI Card dramatis.
*   **Tugas AI:**
    1.  Menulis fungsi Dart untuk men-*sort* entitas berdasarkan skor aura tertinggi.
    2.  Me- *render* layar transisi *Leaderboard*.
    3.  Memoles UI daftar pemenang menggunakan bingkai warna emas/neon untuk Juara Ke-1, disertai transisi *sliding* dan *glow effect*.

---
**Instruksi Eksekusi:** Setiap fase harus berjalan satu demi satu tanpa melompati tahap. Pastikan *injection.dart* berjalan sempurna di Fase 4 sebelum masuk ke *styling* UI di Fase 6.
