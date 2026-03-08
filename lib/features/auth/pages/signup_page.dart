import '../../../core/utils/validators.dart';
import '../../../core/utils/haptic_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/password_strength_bar.dart';
import '../widgets/google_sign_in_button.dart';
import '../widgets/apple_sign_in_button.dart';
import 'dart:io';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            HapticHelper.error();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.message), backgroundColor: Colors.red),
            );
          } else if (state is AuthNeedsProfileSetup) {
            context.go('/profile-setup');
          } else if (state is AuthAuthenticated) {
            context.go('/main/chat');
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F3460),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Start your journey to financial freedom",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 40),
                  AuthTextField(
                    label: "Full Name",
                    hint: "Enter your name",
                    controller: _nameController,
                    prefixIcon: Icons.person_outline,
                    validator: (v) => Validators.required(v, "Name"),
                  ),
                  const SizedBox(height: 20),
                  AuthTextField(
                    label: "Email",
                    hint: "Enter your email",
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email_outlined,
                    validator: Validators.email,
                  ),
                  const SizedBox(height: 20),
                  AuthTextField(
                    label: "Password",
                    hint: "Create a password",
                    controller: _passwordController,
                    obscureText: true,
                    prefixIcon: Icons.lock_outline,
                    validator: Validators.password,
                  ),
                  ValueListenableBuilder(
                    valueListenable: _passwordController,
                    builder: (context, value, child) {
                      return PasswordStrengthBar(password: value.text);
                    },
                  ),
                  const SizedBox(height: 20),
                  AuthTextField(
                    label: "Confirm Password",
                    hint: "Repeat your password",
                    controller: _confirmPasswordController,
                    obscureText: true,
                    prefixIcon: Icons.lock_reset,
                    validator: (v) =>
                        Validators.confirmPassword(v, _passwordController.text),
                  ),
                  const SizedBox(height: 40),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final isLoading = state is AuthLoading;
                      return SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    HapticHelper.medium();
                                    context.read<AuthBloc>().add(
                                          SignUpRequested(
                                            email: _emailController.text.trim(),
                                            password: _passwordController.text,
                                            name: _nameController.text.trim(),
                                          ),
                                        );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0F3460),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text(
                                  "Create Account",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: const [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text("OR",
                            style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 24),
                  GoogleSignInButton(
                    onPressed: () {
                      HapticHelper.medium();
                      context.read<AuthBloc>().add(GoogleSignInRequested());
                    },
                  ),
                  if (Platform.isIOS) ...[
                    const SizedBox(height: 16),
                    AppleSignInButton(
                      onPressed: () {
                        HapticHelper.medium();
                        context.read<AuthBloc>().add(AppleSignInRequested());
                      },
                    ),
                  ],
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () => context.go('/login'),
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                            color: Color(0xFF0F3460),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
