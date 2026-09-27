# Tugas #6 - Mobile Developer Documentation

## Informasi Proyek
- **Nama:** (isi nama kamu)
- **NIM:** (isi NIM kamu)
- **Judul Proyek PBL UAS:** Celengance - Aplikasi Financial Goal Tracker
- **Tautan Desain Figma:** (tempel link Figma PBL UAS kamu di sini)

## Deskripsi Aplikasi
Celengance adalah aplikasi finansial yang membantu pengguna memantau saldo, kesehatan finansial,
dan progress tabungan menuju goal tertentu (kendaraan, sepatu, pakaian, dsb). Dibangun dari hasil
slicing desain Figma menggunakan Flutter dengan **Global State Management (Provider)**.

## Alur Navigasi & Screen
1. **Dashboard Screen** — ringkasan saldo, financial health score, rekomendasi AI, statistik
   bulanan (income/expenses/savings/investment) dalam `GridView`, dan total progress semua goals.
2. **Drawer Menu (overlay translucent)** — dibuka dari ikon hamburger di Dashboard, berisi navigasi
   ke Dashboard, Financial Goals, Transactions, Analytics, AI Insight, Reports, Settings.
3. **Financial Goals Screen** — dibuka dari Drawer > "Financial Goals". Menampilkan saldo, current
   balance, dan daftar goal (`ListView`) yang bisa ditekan.
4. **Goal Detail Screen** — dibuka dengan menekan salah satu item goal. Menampilkan detail goal,
   progress bar, grafik tren balance (`CustomPainter`), dan tombol **Tambah Dana**.

## Fitur Interaktif (Global State Management)
Fitur **Tambah Dana ke Goal**: saat pengguna menambah dana di Goal Detail Screen,
`FinanceProvider` memperbarui saldo goal tersebut sekaligus mengurangi Total Balance.
Perubahan ini **langsung terlihat** di:
- Goal Detail Screen (progress bar & badge persen naik)
- Financial Goals Screen (nominal di list item ikut berubah)
- Dashboard Screen (Total Balance & Total Goals Progress ikut berubah)

Semua ini terjadi tanpa passing data manual antar screen — murni lewat `ChangeNotifierProvider`.

## Arsitektur / Struktur Folder
```
lib/
├── main.dart                        # Entry point, mendaftarkan FinanceProvider
├── models/
│   └── goal.dart                    # Model data goal (murni data)
├── providers/
│   └── finance_provider.dart        # Global State Management (ChangeNotifier)
├── screens/
│   ├── dashboard_screen.dart        # Screen 1
│   ├── financial_goals_screen.dart  # Screen 2
│   └── goal_detail_screen.dart      # Screen 3
└── widgets/
    ├── celengance_app_bar.dart      # AppBar custom reusable
    ├── app_drawer.dart              # Drawer overlay translucent
    ├── ai_recommendation_card.dart  # Kartu AI reusable
    ├── stat_card.dart               # Kartu statistik (dipakai di GridView)
    ├── goal_list_item.dart          # Item list goal
    └── mini_line_chart.dart         # Grafik custom painter
```

File UI (`screens/`, `widgets/`) dipisah total dari file state (`providers/`) — memenuhi
requirement Clean Code / pemisahan logika.

## Local State vs Global State
- **Local State (`setState`)**: toggle sembunyikan/tampilkan saldo di Dashboard Screen
  (`_hideBalanceLocally` di `dashboard_screen.dart`) — hanya memengaruhi tampilan screen itu sendiri.
- **Global State (`Provider`)**: saldo, daftar goals, dan progress — dipakai lintas 3 screen sekaligus.

## Advanced UI yang Diimplementasikan
- `GridView` — grid 2x2 statistik bulanan di Dashboard.
- `Stack` — badge persentase di atas gambar goal (Detail Screen), badge notifikasi, drawer overlay.
- `CustomPainter` — grafik tren balance di Goal Detail Screen.
- `Drawer` — overlay menu translucent dari hamburger icon.

## Teknologi & State Management
- Flutter (Dart)
- State Management: **Provider** (`ChangeNotifierProvider`, `context.watch`, `context.read`)

## Cara Menjalankan
```bash
flutter pub get
flutter run
```

## Screenshot Hasil Slicing
(Tempel screenshot Dashboard, Financial Goals, dan Goal Detail Screen di sini,
lalu bandingkan dengan desain Figma untuk menunjukkan tingkat kemiripan.)
