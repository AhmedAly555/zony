import 'package:flutter/material.dart';

import '../../../modules/auth/screens/login_screen.dart';
import '../default_button.widget.dart';
import '../../../services/navigator.services/app_navigator.services.dart';
import '../custom_outline_button.widget.dart';
import 'componants_bottom_sheet.widgets.dart';

class DeliveryConfirmationBottomSheet extends StatelessWidget {
  const DeliveryConfirmationBottomSheet({super.key});

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
            BottomSheetIcon(svgPath: 'assets/svgs/check_icon.svg'),

            const SizedBox(height: 16),

            // Title
            const Text(
              'Delivery Confirmation',
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
                  child: DefaultButton(
                    onTap:
                        () => AppNavigator.navigateAndRemoveUntil(
                      context,
                          () => const LoginScreen(),
                    ),
                    child: Text(
                      'Yes, I\'m Confirm.',
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
                      'TRY AGAIN',
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

//callback function to show bottom sheet
/*
void showDeliveryConfirmationBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        SizeConfig.init(context);
        return Container(
          constraints: BoxConstraints(
            maxHeight: SizeConfig.heightPercent(0.75),
            minHeight: SizeConfig.heightPercent(0.45),
          ),
          child: IntrinsicHeight(
            child: DeliveryConfirmationBottomSheet(),
          ),
        );
      },

    );
  }
*/
