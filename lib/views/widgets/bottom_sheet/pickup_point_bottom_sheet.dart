import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../modules/auth/screens/login_screen.dart';
import '../../../modules/auth/widgets/custom_login_button.widget.dart';
import '../../../modules/couriers/views/delivering/widgets/parcel_row.widget.dart';
import '../../../services/navigator.services/app_navigator.services.dart';
import '../../../services/size_config.dart';
import '../custome_outline_button.widget.dart';
import 'componants_bottom_sheet.widgets.dart';

class PickupPointBottomSheet extends StatelessWidget {
  const PickupPointBottomSheet({super.key});

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
            SizedBox(height: 12),
            // Language icon
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    shape: BoxShape.circle,
                    //borderRadius: BorderRadius.circular(8),
                  ),
                  child: SvgPicture.asset(
                    'assets/svgs/bag_icon.svg',
                    color: Theme.of(context).primaryColor,
                    width: 19.5,
                    height: 22,

                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PODU PUH-C-23',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF49159B),
                        ),
                      ),
                      Text(
                        '# 568589',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF929292),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
            
            Divider(
              color: Color(0xFFF4F4F4),
              thickness: 1,
            ),

          InfoItem(
            svgPath: 'assets/svgs/location_icon_with_background.svg',
            text: '4140 Parker Rd. Allentown, New Mexico',
          ),
            const SizedBox(height: 18),

            InfoItem(
              svgPath: 'assets/svgs/delivery_time.svg',
              text: 'The expected delivery time is 2 to 4 days.',
            ),
            const SizedBox(height: 18),
            InfoItem(
              svgPath: 'assets/svgs/call_icon_with_background.svg',
              text: '(205) 555-0100',
            ),
            const SizedBox(height: 18),
            InfoItem(
              svgPath: 'assets/svgs/time_icon_with_background.svg',
              text: 'Closed - open all days from 9:00AM to 10PM',
            ),
            const SizedBox(height: 24),
            CustomLoginButton(
              onTap: () => AppNavigator.navigateAndRemoveUntil(context, () => const LoginScreen()),
              child: Text(
                'Show Details',
                textAlign: TextAlign.center,

                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height:13),
            CustomeOutlineButton(
              title: Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xFF49159B),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.only(bottom: 22)),
          ],
        ),
      ),
    );
  }
}

//Show wrong location bottom sheet
void showPickupPointBottomSheet(BuildContext context) {
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
          maxHeight: SizeConfig.heightPercent(0.95),
          minHeight: SizeConfig.heightPercent(0.45),
        ),
        child: PickupPointBottomSheet(),
      );
    },

  );
}
