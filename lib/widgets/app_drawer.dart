// lib/widgets/app_drawer.dart
// Ini yang bikin efek "muncul gambar rada transparan" saat hamburger dipencet.
// Flutter Drawer bawaan otomatis menampilkan scrim/overlay gelap-transparan
// di belakangnya (Advanced UI: layout drawer + Stack di dalamnya untuk AI card).

import 'package:flutter/material.dart';
import '../screens/dashboard_screen.dart';
import '../screens/financial_goals_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white.withOpacity(0.97),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Row(
                children: [
                  Icon(Icons.add_circle, color: Colors.teal),
                  SizedBox(width: 8),
                  Text(
                    'Celengance',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
            _DrawerItem(
              icon: Icons.dashboard_outlined,
              label: 'Dashboard',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const DashboardScreen()),
                );
              },
            ),
            _DrawerItem(
              icon: Icons.track_changes_outlined,
              label: 'Financial Goals',
              onTap: () {
                Navigator.pop(context);
                // Sesuai flow desain: klik menu ini pindah ke halaman Financial Goals
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const FinancialGoalsScreen()),
                );
              },
            ),
            _DrawerItem(
              icon: Icons.receipt_long_outlined,
              label: 'Transactions',
              onTap: () => Navigator.pop(context),
            ),
            _DrawerItem(
              icon: Icons.bar_chart_outlined,
              label: 'Analytics',
              onTap: () => Navigator.pop(context),
            ),
            _DrawerItem(
              icon: Icons.auto_awesome_outlined,
              label: 'AI Insight',
              onTap: () => Navigator.pop(context),
            ),
            _DrawerItem(
              icon: Icons.description_outlined,
              label: 'Reports',
              onTap: () => Navigator.pop(context),
            ),
            _DrawerItem(
              icon: Icons.settings_outlined,
              label: 'Settings',
              onTap: () => Navigator.pop(context),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFD9E0), Color(0xFFFFC1CC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white70,
                      child: Icon(Icons.bolt, color: Colors.pinkAccent),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'AI Assistant',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Need help reaching your financial goals?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11, color: Colors.black54),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Ask AI →',
                          style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87, size: 20),
      title: Text(label, style: const TextStyle(fontSize: 14)),
      onTap: onTap,
    );
  }
}
