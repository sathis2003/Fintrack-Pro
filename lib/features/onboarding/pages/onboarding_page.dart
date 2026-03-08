import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';
import '../widgets/onboarding_slide.dart';
import '../widgets/slide_indicator.dart';
import '../../../core/utils/haptic_helper.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingComplete) {
            context.go('/login');
          }
        },
        builder: (context, state) {
          final isLastPage = state.currentIndex == 2;

          return Stack(
            children: [
              PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  context.read<OnboardingBloc>().add(PageChanged(index));
                },
                children: [
                  const OnboardingSlide(
                    headline: "Stop guessing where your money went",
                    subtitle:
                        "Most people don't track expenses because it's too much work. FinTrack fixes that.",
                    lottieAsset: 'assets/lottie/onboarding_1.json',
                    gradientColors: [Color(0xFF0F3460), Color(0xFF1A1A2E)],
                  ),
                  const OnboardingSlide(
                    headline: "Just type it. We handle the rest.",
                    subtitle:
                        "No forms. No categories to pick. Just tell us in plain English and AI extracts everything.",
                    lottieAsset: 'assets/lottie/onboarding_2.json',
                    gradientColors: [Color(0xFF16213E), Color(0xFF0F3460)],
                  ),
                  const OnboardingSlide(
                    headline: "Your money, your data, always offline-first",
                    subtitle:
                        "Everything works without internet. Your data syncs securely when you're online.",
                    lottieAsset: 'assets/lottie/onboarding_3.json',
                    gradientColors: [Color(0xFF1A1A2E), Color(0xFF0CAF60)],
                  ),
                ],
              ),
              Positioned(
                top: 60,
                right: 20,
                child: isLastPage
                    ? const SizedBox.shrink()
                    : TextButton(
                        onPressed: () {
                          HapticHelper.light();
                          _pageController.animateToPage(
                            2,
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: const Text(
                          "Skip",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
              ),
              Positioned(
                bottom: 60,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      SlideIndicator(
                          count: 3, currentIndex: state.currentIndex),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            HapticHelper.medium();
                            if (isLastPage) {
                              context
                                  .read<OnboardingBloc>()
                                  .add(FinishOnboarding());
                            } else {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isLastPage
                                ? const Color(0xFF0CAF60)
                                : Colors.white,
                            foregroundColor: isLastPage
                                ? Colors.white
                                : const Color(0xFF0F3460),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            isLastPage ? "Get Started" : "Next",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
