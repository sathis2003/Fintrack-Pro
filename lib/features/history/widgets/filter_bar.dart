import 'package:flutter/material.dart';
import '../../../core/constants/categories.dart';
import '../bloc/history_state.dart';
import 'package:intl/intl.dart';

class FilterBar extends StatelessWidget {
  final HistoryFilter filter;
  final Function(HistoryFilter) onFilterChanged;

  const FilterBar({
    super.key,
    required this.filter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Month Selector
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {
                final prev =
                    DateTime(filter.month.year, filter.month.month - 1);
                onFilterChanged(filter.copyWith(month: prev));
              },
            ),
            Text(
              DateFormat('MMMM yyyy').format(filter.month),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () {
                final next =
                    DateTime(filter.month.year, filter.month.month + 1);
                onFilterChanged(filter.copyWith(month: next));
              },
            ),
          ],
        ),

        // Search Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search description...',
              prefixIcon: const Icon(Icons.search, size: 20),
              filled: true,
              fillColor: Colors.black.withValues(alpha: 0.05),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            onChanged: (val) =>
                onFilterChanged(filter.copyWith(searchQuery: val)),
          ),
        ),

        // Category Chips
        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _CategoryChip(
                label: 'All',
                isSelected: filter.category == null,
                onSelected: () =>
                    onFilterChanged(filter.copyWith(category: null)),
              ),
              ...AppCategories.list.map((c) => _CategoryChip(
                    label: c,
                    isSelected: filter.category == c,
                    onSelected: () {
                      if (filter.category == c) {
                        onFilterChanged(filter.copyWith(clearCategory: true));
                      } else {
                        onFilterChanged(filter.copyWith(category: c));
                      }
                    },
                  )),
            ],
          ),
        ),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onSelected(),
        selectedColor: const Color(0xFF0F3460).withValues(alpha: 0.2),
        checkmarkColor: const Color(0xFF0F3460),
        labelStyle: TextStyle(
          color: isSelected ? const Color(0xFF0F3460) : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

