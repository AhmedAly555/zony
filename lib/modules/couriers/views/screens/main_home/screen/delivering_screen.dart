import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:zony/views/widgets/template_app_scaffold.widget.dart';

import '../../../../../../services/size_config.dart';
import '../../../../../../views/widgets/bottom_sheet/manually_username_bottom_sheet.dart';
import '../../../../../../views/widgets/bottom_sheet/qr_scanner.dart';
import '../../../../../../views/widgets/bottom_sheet/wrong_location_bottom_sheet.dart';
import '../../../../../../views/widgets/secondary_appbar.dart';
import '../../../../../recieve_parcel/widgets/custom_menu_recieve.widget.dart';


class DeliveringScreen extends StatelessWidget {
  const DeliveringScreen({super.key});

  //Open the scanner bottom sheet
  Future<String?> openScannerBottomSheet(BuildContext context) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        //bool popped = false;
        final sheetHeight = MediaQuery.of(context).size.height * 0.9;

        final controller = MobileScannerController(
          facing: CameraFacing.back,
          detectionSpeed: DetectionSpeed.noDuplicates,
          // formats: const [BarcodeFormat.qrCode],
        );

        return QRScannerBottomSheet(sheetHeight: sheetHeight, controller: controller,);
      },
    );
  }

  //Show wrong location bottom sheet
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

  //Show manually username bottom sheet
  void showManuallyUsernameBottomSheet(BuildContext context) {
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
            maxHeight: SizeConfig.heightPercent(0.75),
            minHeight: SizeConfig.heightPercent(0.45),
          ),
          child: IntrinsicHeight(child: ManuallyUsernameBottomSheet()),
        );
      },

    );
  }
  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Column(
          children: [
            const SecondaryAppBar(title: 'Pickup Point'),
            const Spacer(),
            CustomMenuRecieve(
              items: [
                MenuItemData(
                  svgPath: 'assets/svgs/small_qr.svg',
                  title: "QR Scanner",
                  onTap: () async {
                    final code = await openScannerBottomSheet(context);
                    if (code != null) {
                      //function to handle the code
                      debugPrint('Scanned::::::::::::: $code');
                    }
                  },
                ),
                MenuItemData(
                  svgPath: 'assets/svgs/small_qr.svg',
                  title: "Enter Username",
                  onTap: () {
                    showManuallyUsernameBottomSheet(context);
                  },
                ),
                MenuItemData(
                  svgPath: 'assets/svgs/small_qr.svg',
                  title: "test wrong",
                  onTap: () {
                    showWrongLocationBottomSheet(context);
                  },
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
