import 'package:flutter/material.dart';

import '../../../modules/couriers/views/screens/main_home/screen/courier_delivering_screen.dart';
import '../../../modules/couriers/views/widgets/custom_home_service_container.widget.dart';
import '../../../theme/app_text_styles.dart';
import '../bottom_sheet_container.dart';
import '../../../services/navigator.services/app_navigator.services.dart';
import 'componants_bottom_sheet.widgets.dart';

class ChooseWayBottomSheet extends StatefulWidget {
  final VoidCallback onBarcodeScannerTap;
  const ChooseWayBottomSheet({super.key, required this.onBarcodeScannerTap});

  @override
  State<ChooseWayBottomSheet> createState() => _ChooseWayBottomSheetState();
}

class _ChooseWayBottomSheetState extends State<ChooseWayBottomSheet> {

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar line
          HederBottomSheetLine(),


          //const SizedBox(height: 16),


          // Title
          Expanded(
            child: const Text(
              'Choose Way Of Searching',
              textAlign: TextAlign.center,
              style: AppTextStyles.bottomSheetTitle,
            ),
          ),

          //const SizedBox(height: 8),
          //const Spacer(),


          CustomHomeServiceContainer(
            color: const Color(0xFFF4F4F4),
            title: 'Barcode Scanner',
            svgIconPath: 'assets/svgs/qr_icon.svg',
            onTap: () {
              widget.onBarcodeScannerTap();
            },
          ),
          const SizedBox(height: 8),
          CustomHomeServiceContainer(
            color: const Color(0xFFF4F4F4),
            title: 'Delivering',
            svgIconPath: 'assets/svgs/manual_icone.svg',
            onTap: () {
              AppNavigator.navigateTo(
                context,
                    () => CourierDeliveringScreen(),
              );
            },
          ),
          Padding(padding: const EdgeInsets.only(bottom: 24)),
        ],
      ),
    );
  }
}
