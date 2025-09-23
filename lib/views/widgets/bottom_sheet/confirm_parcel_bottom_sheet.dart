import 'package:flutter/material.dart';

import '../../../modules/auth/screens/login_screen.dart';
import '../../../theme/app_text_styles.dart';
import '../bottom_sheet_container.dart';
import '../default_button.widget.dart';
import '../../../services/navigator.services/app_navigator.services.dart';
import '../custom_outline_button.widget.dart';
import 'componants_bottom_sheet.widgets.dart';

class ConfirmParcelBottomSheet extends StatelessWidget {
  const ConfirmParcelBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar line
          HederBottomSheetLine(),

          const Spacer(),

          // Title
          const Text(
            'Parcel Approve Confirmation',
            textAlign: TextAlign.center,
            style: AppTextStyles.bottomSheetTitle,
          ),

          const SizedBox(height: 18),

          // Description
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod',
            textAlign: TextAlign.center,
            style: AppTextStyles.bottomSheetDescription,
          ),

          const Spacer(),

          Row(
            children: [
              Expanded(
                child: DefaultButton(
                  onTap: () => AppNavigator.navigateAndRemoveUntil(context, () => const LoginScreen()),
                  child: Text(
                    'Yes, I confirm',
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
                child: CustomOutlineButton(
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
    );
  }
}
