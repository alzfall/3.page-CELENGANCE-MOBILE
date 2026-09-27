// lib/providers/finance_provider.dart
//
// INI FILE STATE MANAGEMENT (Global State).
// File ini TIDAK BOLEH berisi widget (Text, Container, dll),
// hanya data + fungsi pengubah data + notifyListeners().

import 'package:flutter/foundation.dart';
import '../models/goal.dart';

class FinanceProvider extends ChangeNotifier {
  final String userName = 'Amril';

  int _totalBalance = 4200000;

  final int monthlyIncome = 12500000;
  final int monthlyIncomeChangePercent = 8;

  final int monthlyExpenses = 8300000;
  final int monthlyExpensesChangePercent = 8;

  final int monthlySavings = 4200000;
  final int monthlySavingsChangePercent = 20;

  final int investments = 6100000;
  final int investmentsChangePercent = 15;

  final int financialHealthScore = 82;
  final int financialHealthChangePercent = 5;

  // Ringkasan agregat goals untuk kartu "Total Goals Progress" di Dashboard
  final int goalsSummarySaved = 120000000;
  final int goalsSummaryTarget = 200000000;
  final String goalsTargetDateLabel = 'Dec 2028';
  final String goalsTimeLeftLabel = '1y 3m left';

  final List<Goal> _goals = [
    Goal(
      id: 'g1',
      name: 'Erok',
      category: 'Vehicle',
      imageUrl: 'https://picsum.photos/seed/motor/200/200',
      targetAmount: 24000000,
      savedAmount: 24000000 * 35 ~/ 100,
      history: [10, 12, 14, 13, 16, 18, 20, 19, 22, 24, 26, 28],
    ),
    Goal(
      id: 'g2',
      name: 'Kuku Funky',
      category: 'Footwear',
      imageUrl: 'https://picsum.photos/seed/sepatu/200/200',
      targetAmount: 1800000,
      savedAmount: 0,
      history: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    ),
    Goal(
      id: 'g3',
      name: 'Dust La Stella',
      category: 'Clothing',
      imageUrl: 'https://picsum.photos/seed/sweater/200/200',
      targetAmount: 899000,
      savedAmount: 138000,
      history: [2, 4, 3, 6, 8, 7, 9, 11, 10, 13, 14, 14],
    ),
  ];

  // ---- Getter (read-only dari sisi UI) ----
  int get totalBalance => _totalBalance;
  List<Goal> get goals => _goals;

  int get totalGoalsTarget => _goals.fold(0, (sum, g) => sum + g.targetAmount);
  int get totalGoalsSaved => _goals.fold(0, (sum, g) => sum + g.savedAmount);
  double get totalGoalsProgress =>
      totalGoalsTarget == 0 ? 0 : totalGoalsSaved / totalGoalsTarget;

  // Progress untuk kartu ringkasan di Dashboard (pakai angka ringkasan, bukan
  // penjumlahan goals individual, supaya cocok dengan desain).
  double get goalsSummaryProgress =>
      goalsSummaryTarget == 0 ? 0 : goalsSummarySaved / goalsSummaryTarget;

  Goal getGoalById(String id) => _goals.firstWhere((g) => g.id == id);

  // ---- Fungsi pengubah state ----
  void addFundsToGoal(String goalId, int amount) {
    if (amount <= 0 || amount > _totalBalance) return;
    final goal = getGoalById(goalId);
    goal.savedAmount += amount;
    _totalBalance -= amount;
    notifyListeners();
  }
}