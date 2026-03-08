import 'package:flutter/material.dart';

class CameraCaptureButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isDisabled;
  const CameraCaptureButton(
      {super.key, required this.onTap, this.isDisabled = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isDisabled ? Colors.grey.shade300 : const Color(0xFF0CAF60),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.camera_alt, color: Colors.white, size: 22),
      ),
    );
  }
}
