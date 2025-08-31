import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:zony/views/widgets/template_app_scaffold.widget.dart';

import '../../../../../../views/widgets/bottom_sheet/qr_scanner.dart';
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
                    debugPrint("Enter Code tapped");
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
