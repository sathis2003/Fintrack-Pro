import 'package:flutter/material.dart';

class AppleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AppleSignInButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) => OutlinedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.apple, color: Colors.black, size: 22),
        label: const Text('Continue with Apple',
            style: TextStyle(fontSize: 15, color: Colors.black87)),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 52),
          side: const BorderSide(color: Color(0xFFE0E0E0)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: Colors.white,
        ),
      );
}
