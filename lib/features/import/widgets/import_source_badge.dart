import 'package:flutter/material.dart';

class ImportSourceBadge extends StatelessWidget {
  final String sender;
  const ImportSourceBadge({super.key, required this.sender});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFF0F3460).withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        sender.toUpperCase(),
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Color(0xFF0F3460),
        ),
      ),
    );
  }
}
