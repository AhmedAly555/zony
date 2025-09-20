import 'package:flutter/material.dart';

import '../../../core/services/size_config.dart';
import '../../../modules/auth/widgets/custom_login_button.widget.dart';

import 'componants_bottom_sheet.widgets.dart';

class WrongLocationBottomSheet extends StatelessWidget {
  const WrongLocationBottomSheet({super.key});

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
          //mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Handle bar line
            HederBottomSheetLine(),

            Spacer(),
            // Language icon
            BottomSheetIcon(svgPath: 'assets/svgs/wrong_location.svg'),

            const SizedBox(height: 24),

            // Title
            const Text(
              'YOU ARE AT A WRONG LOCATION  ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            Spacer(
              flex: 2,
            ),
            CustomLoginButton(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                "My Pickup Points",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.only(bottom: 16)),
          ],
        ),
      ),
    );
  }
}

//Show wrong location bottom sheet(callback)
void showWrongLocationBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      SizeConfig.init(context);
      return Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxHeight: SizeConfig.heightPercent(0.45),
          minHeight: SizeConfig.heightPercent(0.35),
        ),
        child: WrongLocationBottomSheet(),
      );
    },

  );
}
