import 'package:flutter/material.dart';
import 'package:zony/generated/l10n.dart';

import '../../../modules/auth/screens/login_screen.dart';
import '../../../theme/app_text_styles.dart';
import '../bottom_sheet_container.dart';
import '../default_button.widget.dart';
import '../../../services/navigator.services/app_navigator.services.dart';
import '../custom_outline_button.widget.dart';
import 'componants_bottom_sheet.widgets.dart';

class DeliveryConfirmationBottomSheet extends StatelessWidget {
  final VoidCallback onConfirm;

  const DeliveryConfirmationBottomSheet({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {

    return BottomSheetContainer(
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
          Text(
            S.of(context).deliveryConfirmation,
            textAlign: TextAlign.center,
            style: AppTextStyles.bottomSheetTitle,
          ),

          const SizedBox(height: 8),

          // Description
          Text(
            S.of(context).deliveryConfirmationDescription,
            textAlign: TextAlign.center,
            style: AppTextStyles.bottomSheetDescription,
          ),

          Spacer(),

          Row(
            children: [
              Expanded(
                child: DefaultButton(
                  onTap:
                      () {
                        onConfirm();

                      },
                  child: Text(
                    S.of(context).confirm,
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
                    S.of(context).tryAgain,
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
