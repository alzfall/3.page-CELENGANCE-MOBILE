// lib/widgets/goal_list_item.dart
// Item goal sesuai desain: gambar besar, kategori, nama, kebab menu,
// lalu baris persen + progress bar + nominal saved/target.

import 'package:flutter/material.dart';
import '../models/goal.dart';

class GoalListItem extends StatelessWidget {
  final Goal goal;
  final VoidCallback onTap;

  const GoalListItem({super.key, required this.goal, required this.onTap});

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

  @override
  Widget build(BuildContext context) {
    final percent = (goal.progressPercent * 100).toStringAsFixed(0);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                goal.imageUrl,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(goal.category,
                                style: const TextStyle(
                                    fontSize: 10.5, color: Colors.black45)),
                            Text(goal.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        ),
                      ),
                      const Icon(Icons.more_vert, size: 18, color: Colors.black38),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('$percent%',
                      style: const TextStyle(fontSize: 10.5, color: Colors.black45)),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: goal.progressPercent,
                      minHeight: 6,
                      backgroundColor: const Color(0xFFF0F0F0),
                      valueColor: const AlwaysStoppedAnimation(Color(0xFF0B3D2E)),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(_formatRupiah(goal.savedAmount),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13)),
                      const SizedBox(width: 4),
                      Text('/${_formatRupiah(goal.targetAmount)}',
                          style: const TextStyle(
                              fontSize: 10.5, color: Colors.black38)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}