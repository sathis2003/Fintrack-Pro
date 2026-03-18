import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class FinTrackTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onMenuTap;
  final Widget? action;

  const FinTrackTopBar(
      {super.key, required this.title, required this.onMenuTap, this.action});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 8),
        child: Row(children: [
          // ── Hamburger ──
          GestureDetector(
            onTap: onMenuTap,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: AppColors.card,
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(14)),
              child: const Center(
                child: Icon(Icons.menu_rounded, size: 20, color: AppColors.ink),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // ── Title ──
          Expanded(
              child: RichText(
                  text: TextSpan(
                      style: GoogleFonts.sora(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.ink),
                      children: _titleSpans(title)))),
          // ── Action ──
          if (action != null) action!,
        ]),
      ),
    );
  }

  List<TextSpan> _titleSpans(String t) {
    if (t == 'FinTrack AI') {
      return const [
        TextSpan(text: 'FinTrack '),
        TextSpan(text: 'AI', style: TextStyle(color: AppColors.accent)),
      ];
    }
    return [TextSpan(text: t)];
  }
}
