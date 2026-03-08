import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../../../services/gemma_model_service.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_state.dart';
import '../../premium/bloc/premium_bloc.dart';
import '../../premium/bloc/premium_state.dart';
import '../../../core/utils/haptic_helper.dart';
import '../../../core/theme/theme_notifier.dart';
import '../../../core/widgets/gradient_card.dart';
import '../../../core/constants/app_gradients.dart';
import '../../../core/di/injection.dart';
import '../../../data/local/daos/financial_profile_dao.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(ProfileLoaded());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            context.go('/login');
          }
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProfileError) {
              return Center(child: Text(state.message));
            }

            if (state is ProfileData) {
              return BlocBuilder<PremiumBloc, PremiumState>(
                builder: (context, premiumState) {
                  final isPro = premiumState is PremiumStatusLoaded
                      ? premiumState.isPro
                      : false;
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildHeader(state, isPro, context),
                        const SizedBox(height: 24),
                        _buildSection(
                          "App Settings",
                          [
                            ListenableBuilder(
                              listenable: getIt<ThemeNotifier>(),
                              builder: (context, _) {
                                final notifier = getIt<ThemeNotifier>();
                                return SwitchListTile(
                                  value: notifier.isDark,
                                  onChanged: (v) {
                                    HapticHelper.light();
                                    notifier.toggle();
                                  },
                                  title: const Text("Dark Mode"),
                                  secondary: Icon(
                                    notifier.isDark
                                        ? Icons.dark_mode
                                        : Icons.light_mode,
                                    color: theme.colorScheme.primary,
                                  ),
                                  activeColor: theme.colorScheme.primary,
                                );
                              },
                            ),
                          ],
                          context,
                        ),
                        const SizedBox(height: 24),
                        _buildSection(
                          "Financial Profile",
                          [
                            _buildTile(
                                "Monthly Income",
                                state.profile.monthlyIncome > 0
                                    ? "₹${state.profile.monthlyIncome.toInt()}"
                                    : "Not set — tap to add",
                                Icons.payments_outlined,
                                context,
                                onTap: () => _showIncomeSheet(
                                    context,
                                    state.profile.userId,
                                    state.profile.monthlyIncome)),
                            _buildTile(
                                "Income Date",
                                "${state.profile.incomeDay}st of month",
                                Icons.calendar_today_outlined,
                                context),
                            _buildTile("Currency", "INR ₹",
                                Icons.language_outlined, context),
                          ],
                          context,
                        ),
                        const SizedBox(height: 24),
                        _buildSection(
                          "AI Engine",
                          [
                            _buildGemmaStatusTile(context),
                          ],
                          context,
                        ),
                        const SizedBox(height: 24),
                        _buildSection(
                          "Security",
                          [
                            SwitchListTile(
                              value: state.isBiometricEnabled,
                              onChanged: state.isBiometricAvailable
                                  ? (v) => context
                                      .read<ProfileBloc>()
                                      .add(BiometricToggled(v))
                                  : null,
                              title: const Text("Biometric Lock"),
                              secondary: Icon(Icons.fingerprint,
                                  color: theme.colorScheme.primary),
                              activeColor: theme.colorScheme.primary,
                            ),
                            _buildTile("Change Password", "••••••••",
                                Icons.lock_outline, context,
                                onTap: () => context.push('/forgot-password')),
                          ],
                          context,
                        ),
                        const SizedBox(height: 24),
                        _buildSection(
                          "Danger Zone",
                          [
                            ListTile(
                              onTap: () {
                                HapticHelper.medium();
                                context
                                    .read<ProfileBloc>()
                                    .add(SignOutRequested());
                              },
                              leading:
                                  const Icon(Icons.logout, color: Colors.red),
                              title: const Text("Sign Out",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                            ),
                            ListTile(
                              onTap: () => _showDeleteDialog(context),
                              leading: const Icon(Icons.delete_forever,
                                  color: Colors.red),
                              title: const Text("Delete Account",
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ],
                          context,
                        ),
                        const SizedBox(height: 48),
                      ],
                    ),
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildHeader(ProfileData state, bool isPro, BuildContext context) {
    return GradientCard(
      gradient: AppGradients.heroCard,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            child: Text(
              state.email.isNotEmpty ? state.email[0].toUpperCase() : "?",
              style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            state.email,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => context.push('/premium'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color:
                    (isPro ? const Color(0xFFFFD700) : const Color(0xFF10B981))
                        .withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: (isPro
                          ? const Color(0xFFFFD700)
                          : const Color(0xFF10B981))
                      .withValues(alpha: 0.5),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(isPro ? Icons.workspace_premium : Icons.stars,
                      color: isPro
                          ? const Color(0xFFFFD700)
                          : const Color(0xFF6EE7B7),
                      size: 16),
                  const SizedBox(width: 8),
                  Text(
                    isPro ? "PRO PLAN" : "FREE PLAN - UPGRADE",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isPro
                            ? const Color(0xFFFFD700)
                            : const Color(0xFF6EE7B7)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
      String title, List<Widget> children, BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          child: Text(title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              )),
        ),
        Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E2E) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark ? const Color(0xFF2D1B69) : const Color(0xFFF4F0FF),
              width: 1,
            ),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildTile(
      String title, String value, IconData icon, BuildContext context,
      {VoidCallback? onTap}) {
    final theme = Theme.of(context);
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value,
              style: TextStyle(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5))),
          if (onTap != null)
            Icon(Icons.chevron_right,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.3)),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Account?"),
        content: const Text(
            "This action is permanent and will delete all your data. Are you sure?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              context.read<ProfileBloc>().add(DeleteAccountRequested());
              Navigator.pop(context);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildGemmaStatusTile(BuildContext context) {
    final theme = Theme.of(context);
    return ValueListenableBuilder<bool>(
      valueListenable: GemmaModelService.isReady,
      builder: (context, ready, _) {
        return Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.memory,
                color: ready
                    ? const Color(0xFF10B981)
                    : theme.colorScheme.onSurface.withValues(alpha: 0.4),
              ),
              title: const Text('Local Gemini Engine',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text(ready ? 'Model loaded (1.5GB)' : 'Not downloaded'),
              trailing: ready
                  ? IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => GemmaModelService.deleteModel(),
                    )
                  : Text('WiFi Only',
                      style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.5))),
            ),
            // Removed Download Model Button to /.agent/archive/unused/2026-03-08/download_model_button.dart
          ],
        );
      },
    );
  }

  void _showIncomeSheet(
      BuildContext context, String userId, double currentIncome) {
    final controller = TextEditingController(
      text: currentIncome > 0 ? currentIncome.toInt().toString() : '',
    );
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (bottomSheetContext) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Update Monthly Income',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Monthly Income',
                prefixText: '₹ ',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final amount = double.tryParse(controller.text) ?? 0;
                  final dao = getIt<FinancialProfileDao>();
                  await dao.updateIncome(userId, amount);
                  if (context.mounted) {
                    context.read<ProfileBloc>().add(ProfileLoaded());
                    Navigator.pop(bottomSheetContext);
                  }
                },
                child: const Text('Save'),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
