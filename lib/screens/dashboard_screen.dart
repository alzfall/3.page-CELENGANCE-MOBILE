// lib/screens/dashboard_screen.dart
// Screen 1: Dashboard, dibuat presisi mengikuti desain Figma.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/finance_provider.dart';
import '../widgets/celengance_app_bar.dart';
import '../widgets/app_drawer.dart';
import '../widgets/ai_recommendation_card.dart';
import '../widgets/stat_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // LOCAL STATE: cuma dipakai untuk sembunyikan/tampilkan saldo di screen ini.
  bool _hideBalance = false;

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
              Text('Good morning, ${finance.userName}!',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 12),

              // Tombol "+ add transaction"
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

              // ---- Total Balance Card ----
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
                        const Icon(Icons.credit_card, size: 20, color: Colors.black54),
                        const SizedBox(width: 10),
                        Text(
                          _hideBalance
                              ? 'Rp••••••••••'
                              : _formatRupiah(finance.totalBalance),
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(
                        _hideBalance ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        size: 20,
                      ),
                      onPressed: () => setState(() => _hideBalance = !_hideBalance),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // ---- Financial Health Score ----
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 3)),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.favorite_border, size: 15, color: Colors.black54),
                            SizedBox(width: 6),
                            Text('Financial Health Score', style: TextStyle(fontSize: 12.5)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.arrow_upward, size: 11, color: Colors.green),
                            Text('${finance.financialHealthChangePercent}% from last month',
                                style: const TextStyle(fontSize: 10.5, color: Colors.green)),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE9F7EE),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text('Excellent',
                              style: TextStyle(fontSize: 10.5, color: Colors.green, fontWeight: FontWeight.w600)),
                        ),
                        const SizedBox(width: 10),
                        Text('${finance.financialHealthScore}',
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              const AiRecommendationCard(),
              const SizedBox(height: 16),

              // ---- GridView 2x2 statistik ----
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.55,
                children: [
                  StatCard(
                    label: 'Monthly Income',
                    amount: finance.monthlyIncome,
                    changePercent: finance.monthlyIncomeChangePercent,
                    accentColor: Colors.green,
                  ),
                  StatCard(
                    label: 'Monthly Expenses',
                    amount: finance.monthlyExpenses,
                    changePercent: finance.monthlyExpensesChangePercent,
                    accentColor: Colors.redAccent,
                  ),
                  StatCard(
                    label: 'Monthly Savings',
                    amount: finance.monthlySavings,
                    changePercent: finance.monthlySavingsChangePercent,
                    accentColor: const Color(0xFF0B3D2E),
                  ),
                  StatCard(
                    label: 'Investments',
                    amount: finance.investments,
                    changePercent: finance.investmentsChangePercent,
                    accentColor: Colors.teal,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // ---- Total Goals Progress ----
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 3)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.track_changes_outlined, size: 16, color: Colors.black54),
                        SizedBox(width: 6),
                        Text('Total Goals Progress',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(_formatRupiah(finance.goalsSummarySaved).replaceAll(',00', ''),
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('of ${_formatRupiah(finance.goalsSummaryTarget).replaceAll(',00', '')}',
                        style: const TextStyle(fontSize: 12, color: Colors.black45)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: finance.goalsSummaryProgress,
                              minHeight: 8,
                              backgroundColor: const Color(0xFFFCE4EA),
                              valueColor: const AlwaysStoppedAnimation(Color(0xFF0B3D2E)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text('${(finance.goalsSummaryProgress * 100).toStringAsFixed(0)}%',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Target: ${finance.goalsTargetDateLabel}',
                            style: const TextStyle(fontSize: 11, color: Colors.black45)),
                        Text(finance.goalsTimeLeftLabel,
                            style: const TextStyle(fontSize: 11, color: Colors.black45)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}