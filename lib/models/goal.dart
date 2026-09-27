// lib/models/goal.dart
// Model murni: struktur data goal (tabungan/vehicle/shoes/dsb).
// TIDAK ADA kode widget di sini.

class Goal {
  final String id;
  final String name;
  final String category; // contoh: Vehicle, Footwear, Clothing
  final String imageUrl;
  final int targetAmount;
  int savedAmount;
  final List<double> history; // dipakai untuk grafik sederhana di Detail Screen

  Goal({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.targetAmount,
    required this.savedAmount,
    required this.history,
  });

  double get progressPercent =>
      targetAmount == 0 ? 0 : (savedAmount / targetAmount).clamp(0, 1);
}
