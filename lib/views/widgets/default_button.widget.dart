import 'package:flutter/material.dart';
import 'package:zony/generated/l10n.dart';
import 'package:zony/theme/app_colors.theme.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget? child;
  final Color? buttonColor;

  const DefaultButton({
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

                              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),: null, */
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? AppColors.zonyPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child:
              child ??
              Text(
                S.of(context).confirm,
                style: const TextStyle(
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
