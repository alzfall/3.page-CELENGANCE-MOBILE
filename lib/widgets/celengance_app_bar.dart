// lib/widgets/celengance_app_bar.dart
// AppBar custom yang dipakai berulang di 3 screen: logo, hamburger (buka drawer),
// bell notifikasi, dan avatar inisial user.

import 'package:flutter/material.dart';

class CelenganceAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CelenganceAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          // Membuka Drawer (overlay translucent) yang isinya menu navigasi
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.add_circle, color: Colors.teal, size: 20),
          SizedBox(width: 6),
          Text(
            'Celengance',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.black87),
          onPressed: () {},
        ),
        const Padding(
          padding: EdgeInsets.only(right: 12),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: Colors.black87,
            child: Text(
              'JD',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
