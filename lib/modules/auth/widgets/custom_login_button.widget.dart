import 'package:flutter/material.dart';

class CustomLoginButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget? child;
  final Color? buttonColor;

  const CustomLoginButton({
    super.key,
    required this.onTap,
    this.child,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        /* (_selectedIndex == 0 || _selectedIndex == 1)
                              ? () {
                                //
                              }
                              : null, */
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? Color(0xFF49159B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child:
              child ??
              const Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
        ),
      ),
    );
  }
}
