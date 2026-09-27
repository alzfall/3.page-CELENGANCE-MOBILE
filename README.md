# Tugas #6 - Mobile Developer Documentation

## Informasi Proyek
- **Nama:** Alza Aulya Falista
- **NIM:** 253140700111004
- **Judul Proyek PBL UAS:** Celengance - Aplikasi Financial Goal Tracker
- **Tautan Desain Figma:** (https://www.figma.com/design/7WvUgNFCu4ZjtvRzDF19HF/CELENGAN?node-id=31-2&p=f&t=j1R2u2IEAG3zJM8C-0)

## Deskripsi Aplikasi
Celengance adalah aplikasi finansial yang membantu pengguna memantau saldo, kesehatan finansial,
dan progress tabungan menuju goal tertentu (kendaraan, sepatu, pakaian, dsb). Dibangun dari hasil
slicing desain Figma menggunakan Flutter dengan **Global State Management (Provider)**.

## Alur Navigasi & Screen
1. **Dashboard Screen** — ringkasan saldo, financial health score, rekomendasi AI, statistik
   bulanan (income/expenses/savings/investment) dalam `GridView`, dan total progress semua goals.
2. **Drawer Menu ** — dibuka dari ikon garis tiga di Dashboard, berisi navigasi
   ke Dashboard, Financial Goals, Transactions, Analytics, AI Insight, Reports, Settings.
3. **Financial Goals Screen** — dibuka dari Drawer > "Financial Goals". Menampilkan saldo, current
   balance, dan daftar goal (`ListView`) yang bisa ditekan.
4. **Goal Detail Screen** — dibuka dengan menekan salah satu item goal. Menampilkan detail goal,
   progress bar, dan tombol **Tambah Dana**.

## Local State vs Global State
- **Local State (`setState`)**: toggle sembunyikan/tampilkan saldo di Dashboard Screen
  (`_hideBalanceLocally` di `dashboard_screen.dart`) — hanya memengaruhi tampilan screen itu sendiri.
- **Global State (`Provider`)**: saldo, daftar goals, dan progress — dipakai lintas 3 screen sekaligus.

## Advanced UI yang Diimplementasikan
- `GridView` — grid 2x2 statistik bulanan di Dashboard.
- `Stack` — badge persentase di atas gambar goal (Detail Screen), badge notifikasi, drawer overlay.
- `CustomPainter` — grafik tren balance di Goal Detail Screen.
- `Drawer` — overlay menu translucent dari hamburger icon.


## Cara Menjalankan
```bash
flutter pub get
flutter run
```
