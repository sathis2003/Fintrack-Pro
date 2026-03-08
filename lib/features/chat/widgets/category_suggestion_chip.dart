import 'package:flutter/material.dart';

class CategorySuggestionChip extends StatelessWidget {
  final String category;
  final VoidCallback onTap;

  const CategorySuggestionChip({
    super.key,
    required this.category,
    required this.onTap,
  });

  static const _categoryEmojis = {
    'Food': '🍔',
    'Transport': '🚗',
    'Shopping': '🛍️',
    'Bills': '📄',
    'Health': '💊',
    'Entertainment': '🎬',
    'Education': '📚',
    'Investment': '📈',
    'Other': '📌',
  };

  @override
  Widget build(BuildContext context) {
    final emoji = _categoryEmojis[category] ?? '📌';
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F0FF),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF7C3AED).withValues(alpha: 0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 6),
            Text('Looks like $category — tap to confirm',
                style: const TextStyle(fontSize: 12, color: Color(0xFF7C3AED))),
          ],
        ),
      ),
    );
  }
}

