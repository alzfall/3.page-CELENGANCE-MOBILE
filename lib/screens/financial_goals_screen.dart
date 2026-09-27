// lib/screens/financial_goals_screen.dart
// Screen 2: Financial Goals List, disesuaikan persis dengan desain Figma.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/finance_provider.dart';
import '../widgets/celengance_app_bar.dart';
import '../widgets/app_drawer.dart';
import '../widgets/ai_recommendation_card.dart';
import '../widgets/goal_list_item.dart';
import 'goal_detail_screen.dart';

class FinancialGoalsScreen extends StatelessWidget {
  const FinancialGoalsScreen({super.key});

  String _formatRupiah(int value) {
    final s = value.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final posFromRight = s.length - i;
      buffer.write(s[i]);
      if (posFromRight > 1 && posFromRight % 3 == 1) buffer.write('.');
    }
    return 'Rp$buffer,00';
  }

  @override
  Widget build(BuildContext context) {
    final finance = context.watch<FinanceProvider>();

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

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF0B3D2E),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('+ add transaction',
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.credit_card, size: 16, color: Colors.black54),
                        SizedBox(width: 6),
                        Text('Total Balance',
                            style: TextStyle(fontSize: 12, color: Colors.black54)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_formatRupiah(finance.totalBalance),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const Icon(Icons.visibility_outlined, size: 20),
                      ],
                    ),
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

              // ---- Current Balance ----
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Current Balance',
                            style: TextStyle(fontSize: 12, color: Colors.black54)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text('+ New Goal',
                              style: TextStyle(fontSize: 11, color: Colors.pinkAccent)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_formatRupiah(finance.totalBalance),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const Icon(Icons.visibility_outlined, size: 20),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // ---- Chip "My Goals" ----
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0EAF7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('My Goals',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 14),

              ...finance.goals.map(
                (goal) => GoalListItem(
                  goal: goal,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GoalDetailScreen(goalId: goal.id),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}