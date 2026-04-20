import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/profile_setup_bloc.dart';
import '../bloc/profile_setup_event.dart';
import '../bloc/profile_setup_state.dart';
import '../../auth/widgets/auth_text_field.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart';
import '../../../core/utils/haptic_helper.dart';
import '../../../core/utils/validators.dart';

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _OnboardingWizardStep extends StatelessWidget {
  final String icon;
  final String headline;
  final String subtitle;
  final Widget content;
  final VoidCallback onContinue;
  final VoidCallback onBack;
  final VoidCallback onSkip;
  final bool isFirst;
  final bool isLast;
  final bool isLoading;
  final int stepIndex;

  const _OnboardingWizardStep({
    super.key,
    required this.icon,
    required this.headline,
    required this.subtitle,
    required this.content,
    required this.onContinue,
    required this.onBack,
    required this.onSkip,
    this.isFirst = false,
    this.isLast = false,
    this.isLoading = false,
    required this.stepIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              final isActive = index == stepIndex;
              return Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      isActive ? const Color(0xFF0F3460) : Colors.grey.shade300,
                ),
              );
            }),
          ),
          const Spacer(flex: 1),
          Text(icon, style: const TextStyle(fontSize: 64)),
          const SizedBox(height: 24),
          Text(
            headline,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F3460)),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 48),
          content,
          const Spacer(flex: 2),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: isLoading ? null : onContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F3460),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(isLast ? "Finish Setup 🎉" : "Continue →",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 16),
          if (!isFirst)
            TextButton(
              onPressed: onBack,
              child:
                  const Text("Go Back", style: TextStyle(color: Colors.grey)),
            ),
          TextButton(
            onPressed: onSkip,
            child: const Text("Skip for now",
                style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final _incomeController = TextEditingController();

  @override
  void dispose() {
    _incomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<ProfileSetupBloc, ProfileSetupState>(
        listener: (context, state) {
          if (state.isDone) {
            context.read<AuthBloc>().add(ProfileSetupCompleted());
            context.go('/main');
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _buildStep(state),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStep(ProfileSetupState state) {
    switch (state.step) {
      case ProfileSetupStep.income:
        return _OnboardingWizardStep(
          key: const ValueKey('income'),
          stepIndex: 0,
          isFirst: true,
          icon: "💰",
          headline: "What's your monthly income?",
          subtitle: "Used to calculate your savings rate and risk score",
          content: AuthTextField(
            label: "Monthly Income",
            hint: "e.g. 75000",
            controller: _incomeController,
            keyboardType: TextInputType.number,
            prefixIcon: Icons.currency_rupee,
            validator: (v) => Validators.required(v, "Income"),
          ),
          onContinue: () {
            final income = double.tryParse(_incomeController.text) ?? 0;
            context.read<ProfileSetupBloc>().add(IncomeSet(income));
            context.read<ProfileSetupBloc>().add(StepAdvanced());
            HapticHelper.light();
          },
          onBack: () {},
          onSkip: () => _skip(),
        );

      case ProfileSetupStep.date:
        return _OnboardingWizardStep(
          key: const ValueKey('date'),
          stepIndex: 1,
          icon: "📅",
          headline: "When do you get paid?",
          subtitle: "Helps us reset your budgets at the right time",
          content: Column(
            children: [
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 31,
                  itemBuilder: (context, index) {
                    final day = index + 1;
                    final isSelected = state.incomeDay == day;
                    return GestureDetector(
                      onTap: () {
                        context
                            .read<ProfileSetupBloc>()
                            .add(IncomeDateSet(day));
                        HapticHelper.light();
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF0F3460)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF0F3460)
                                  : Colors.grey.shade300),
                        ),
                        child: Center(
                          child: Text(
                            "$day",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              const Text("Scroll to select a day",
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          onContinue: () {
            context.read<ProfileSetupBloc>().add(StepAdvanced());
            HapticHelper.light();
          },
          onBack: () => context.read<ProfileSetupBloc>().add(StepRetracted()),
          onSkip: () => _skip(),
        );

      case ProfileSetupStep.currency:
        return _OnboardingWizardStep(
          key: const ValueKey('currency'),
          stepIndex: 2,
          isLast: true,
          icon: "🌍",
          headline: "Your currency",
          subtitle: "Currently we support INR. More coming soon.",
          content: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F3460),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("₹",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    SizedBox(width: 12),
                    Text("Indian Rupee",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "USD, EUR, GBP (Coming Soon)",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade400,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
          onContinue: () {
            HapticHelper.success();
            context.read<ProfileSetupBloc>().add(SetupCompleted());
          },
          onBack: () => context.read<ProfileSetupBloc>().add(StepRetracted()),
          onSkip: () => _skip(),
          isLoading: state.isSaving,
        );
    }
  }

  void _skip() {
    HapticHelper.medium();
    context.read<ProfileSetupBloc>().add(SetupSkipped());
  }
}
