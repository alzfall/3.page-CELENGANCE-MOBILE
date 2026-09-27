// lib/main.dart
// FinanceProvider dipasang di atas widget tree, supaya diakses dari
// DashboardScreen, FinancialGoalsScreen, dan GoalDetailScreen (Global State).

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/finance_provider.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const CelenganceApp());
}

class CelenganceApp extends StatelessWidget {
  const CelenganceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FinanceProvider(),
      child: MaterialApp(
        title: 'Celengance',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Roboto',
          scaffoldBackgroundColor: const Color(0xFFF7F8FA),
        ),
        home: const DashboardScreen(),
      ),
    );
  }
}
