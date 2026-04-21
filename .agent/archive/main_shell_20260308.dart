// Archived: Removed old main_shell.dart to use new Drawer MainShell — 2026-03-08
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/gemma_download_banner.dart';
import '../../../core/widgets/app_nav_bar.dart';

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const GemmaDownloadBanner(),
            AppNavBar(
              currentIndex: navigationShell.currentIndex,
              onTap: (index) => navigationShell.goBranch(index),
            ),
          ],
        ),
      ),
    );
  }
}
