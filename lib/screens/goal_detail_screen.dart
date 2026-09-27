// lib/screens/goal_detail_screen.dart
// Screen 3: Detail Goal, disesuaikan persis dengan desain Figma.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/finance_provider.dart';
import '../widgets/celengance_app_bar.dart';
import '../widgets/app_drawer.dart';
import '../widgets/ai_recommendation_card.dart';
import '../widgets/mini_line_chart.dart';

class GoalDetailScreen extends StatelessWidget {
  final String goalId;
  const GoalDetailScreen({super.key, required this.goalId});

  String _formatRupiah(int value) {
    final s = value.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final posFromRight = s.length - i;
      buffer.write(s[i]);
      if (posFromRight > 1 && posFromRight % 3 == 1) buffer.write('.');
    }
    return 'Rp$buffer';
  }

  void _showAddFundsSheet(BuildContext context) {
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Tambah Dana ke Goal',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  prefixText: 'Rp ',
                  border: OutlineInputBorder(),
                  hintText: 'Nominal',
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0B3D2E)),
                  onPressed: () {
                    final amount = int.tryParse(controller.text) ?? 0;
                    context.read<FinanceProvider>().addFundsToGoal(goalId, amount);
                    Navigator.pop(ctx);
                  },
                  child: const Text('Simpan', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final finance = context.watch<FinanceProvider>();
    final goal = finance.getGoalById(goalId);
    final percent = (goal.progressPercent * 100).toStringAsFixed(0);

    return Scaffold(
      appBar: const CelenganceAppBar(),
      drawer: const AppDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFDF3F5), Color(0xFFF7F8FA)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Sunday, 20 September 2026',
                  style: TextStyle(fontSize: 12, color: Colors.black45)),
              const SizedBox(height: 6),
              Text('Hello, ${finance.userName}!',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              // Pill "My Goal" (bukan "add transaction" di screen ini)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF0B3D2E),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('My Goal',
                    style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
              const SizedBox(height: 12),

              const Text("Here's your financial overview today",
                  style: TextStyle(fontSize: 12, color: Colors.black45)),
              const SizedBox(height: 16),

              // ---- Total Balance ----
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE9F7EE), Color(0xFFFDF3F5)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.credit_card, size: 18, color: Colors.black54),
                        const SizedBox(width: 10),
                        Text('${_formatRupiah(finance.totalBalance)},00',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Icon(Icons.visibility_outlined, size: 20),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              const AiRecommendationCard(),
              const SizedBox(height: 20),

              const Center(
                child: Text('~ Turn dreams into balance ~',
                    style: TextStyle(fontSize: 12.5, color: Colors.black45)),
              ),
              const SizedBox(height: 20),

              // Section header sebelum kartu goal spesifik
              Text('Hello, ${finance.userName}!',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 14),

              // ---- Kartu Goal: gambar, nama, harga, badge persen lingkaran ----
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 3)),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(goal.imageUrl, width: 70, height: 70, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(goal.name,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          const SizedBox(height: 4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(_formatRupiah(goal.savedAmount),
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              const SizedBox(width: 4),
                              Text('/${_formatRupiah(goal.targetAmount)}',
                                  style: const TextStyle(fontSize: 10.5, color: Colors.black38)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Badge lingkaran pink persen, sesuai desain
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.pinkAccent.withOpacity(0.4), width: 4),
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(percent,
                              style: const TextStyle(
                                  color: Colors.pinkAccent, fontWeight: FontWeight.bold, fontSize: 13)),
                          const Text('%', style: TextStyle(color: Colors.pinkAccent, fontSize: 8)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // ---- Savings Progress: garis tipis + persen ----
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Savings Progress',
                      style: TextStyle(fontSize: 12, color: Colors.black54)),
                  Text('$percent %',
                      style: const TextStyle(fontSize: 11, color: Colors.black45)),
                ],
              ),
              const SizedBox(height: 6),
              Container(height: 1, color: Colors.black12),
              const SizedBox(height: 20),

              // ---- Kartu Balance Chart ----
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFFAF3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.show_chart, size: 16, color: Colors.black54),
                            SizedBox(width: 6),
                            Text('Balance', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('This Year', style: TextStyle(fontSize: 10.5)),
                              Icon(Icons.keyboard_arrow_down, size: 14),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    MiniLineChart(data: goal.history),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0B3D2E)),
                  onPressed: () => _showAddFundsSheet(context),
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text('Tambah Dana', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}