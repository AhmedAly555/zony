import 'package:flutter/material.dart';
import 'package:zony/generated/l10n.dart';

import '../../../modules/auth/screens/login_screen.dart';
import '../../../theme/app_text_styles.dart';
import '../bottom_sheet_container.dart';
import '../default_button.widget.dart';
import '../../../services/navigator.services/app_navigator.services.dart';
import '../../../services/size_config.dart';
import '../custom_outline_button.widget.dart';
import 'componants_bottom_sheet.widgets.dart';

class WrongLocationBottomSheet extends StatelessWidget {
  const WrongLocationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
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
          Text(
            S.of(context).youAreAtWrongLocation,
            textAlign: TextAlign.center,
            style: AppTextStyles.bottomSheetTitle,
          ),
          Spacer(
            flex: 2,
          ),
          DefaultButton(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              S.of(context).myPickupPoints,
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
