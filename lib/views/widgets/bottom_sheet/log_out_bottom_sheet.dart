import 'package:flutter/material.dart';

import '../../../modules/auth/screens/login_screen.dart';
import '../../../modules/auth/widgets/custom_login_button.widget.dart';
import '../../../core/services/navigator.services/app_navigator.services.dart';
import '../custome_outline_button.widget.dart';
import 'componants_bottom_sheet.widgets.dart';

class LogOutBottomSheet extends StatelessWidget {
  const LogOutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar line
            HederBottomSheetLine(),

            Spacer(),
            // Language icon
            BottomSheetIcon(svgPath: 'assets/svgs/logout.svg'),

            const SizedBox(height: 16),

            // Title
            const Text(
              'Are you sure you want to log out?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 8),

            // Description
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.4),
            ),

            Spacer(),

            Row(
              children: [
                Expanded(
                  child: CustomLoginButton(
                    onTap: () => AppNavigator.navigateAndRemoveUntil(context, () => const LoginScreen()),
                    child: Text(
                      'Yes, I\'m sure.',
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: CustomeOutlineButton(
                    title: Text(
                      'No, cancel',
                      style: TextStyle(
                        color: Color(0xFF49159B),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(padding: const EdgeInsets.only(bottom: 16)),
          ],
        ),
      ),
    );
  }
}
