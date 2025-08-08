import 'package:flutter/material.dart';

class CustomLoginButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget? child;
  const CustomLoginButton({super.key, required this.onTap, this.child});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      /* (_selectedIndex == 0 || _selectedIndex == 1)
                            ? () {
                              //
                            }
                            : null, */
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: child ?? const Text(
        'Confirm',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }
}
