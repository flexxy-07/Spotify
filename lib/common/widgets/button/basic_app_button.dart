import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double ? height;
  const BasicAppButton({super.key,required this.onPressed, required this.label, this.height});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(height ?? 80),
        foregroundColor: Colors.white.withOpacity(0.9)
      ),
      child: Text(label),
    );
  }
}