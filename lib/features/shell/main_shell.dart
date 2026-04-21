import 'package:flutter/material.dart';
import '../../core/widgets/app_drawer.dart';
import '../chat/pages/chat_page.dart';
import '../dashboard/pages/dashboard_page.dart';
import '../history/pages/history_page.dart';
import '../achievements/pages/achievements_page.dart';
import '../../core/theme/app_colors.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell>
    with SingleTickerProviderStateMixin {
  int _index = 0;
  bool _drawerOpen = false;
  late AnimationController _drawerCtrl;
  late Animation<double> _drawerAnim;

  @override
  void initState() {
    super.initState();
    _drawerCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 340));
    _drawerAnim = CurvedAnimation(
        parent: _drawerCtrl,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic);
  }

  @override
  void dispose() {
    _drawerCtrl.dispose();
    super.dispose();
  }

  void openDrawer() {
    _drawerCtrl.forward();
    setState(() => _drawerOpen = true);
  }

  void closeDrawer() {
    _drawerCtrl.reverse();
    setState(() => _drawerOpen = false);
  }

  void goTab(int i) {
    setState(() => _index = i);
    closeDrawer();
  }

  // Passing openDrawer to each page dynamically so we don't need const
  List<Widget> get _pages => [
        ChatPage(onMenuTap: openDrawer),
        DashboardPage(onMenuTap: openDrawer),
        HistoryPage(onMenuTap: openDrawer),
        AchievementsPage(onMenuTap: openDrawer),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      // NO bottomNavigationBar
      body: Stack(children: [
        // ── Pages ──
        IndexedStack(index: _index, children: _pages),
        // ── Overlay ──
        AnimatedBuilder(
          animation: _drawerAnim,
          builder: (_, __) => _drawerOpen
              ? GestureDetector(
                  onTap: closeDrawer,
                  child: Container(
                      color: Colors.black
                          .withValues(alpha: 0.55 * _drawerAnim.value)),
                )
              : const SizedBox.shrink(),
        ),
        // ── Drawer ──
        AnimatedBuilder(
          animation: _drawerAnim,
          builder: (_, child) => Transform.translate(
            offset: Offset(-280 * (1 - _drawerAnim.value), 0),
            child: child,
          ),
          child: AppDrawer(
            currentIndex: _index,
            onTap: goTab,
            onClose: closeDrawer,
          ),
        ),
      ]),
    );
  }
}
