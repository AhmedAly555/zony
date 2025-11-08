import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:zony/generated/l10n.dart';
import 'package:zony/views/widgets/template_app_scaffold.widget.dart';

import '../../../../../../views/widgets/bottom_sheet/qr_scanner.dart';
import '../../../../../../views/widgets/default_appbar.dart';
import '../../../../../../views/widgets/toasts.dart';
import '../../../../../recieve_parcel/widgets/custom_menu_recieve.widget.dart';
import '../../../../delivering/screens/pudo_parcels.screen.dart';


class CourierDeliveringScreen extends StatelessWidget {
  const CourierDeliveringScreen({super.key});

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

  //Handle Pudo QR Scanning
  Future<void> _handlePudoQrScanning({
    required BuildContext context,
    required Function showCorrectToast,
    required Function showErrorToast,
  }) async {
    final controller = MobileScannerController();

    final pudoId = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => QRScannerBottomSheet(
        sheetHeight: MediaQuery.of(context).size.height * 0.9,
        controller: controller,
      ),
    );

    // after returning stop the camera
    await controller.stop();

    if (pudoId != null && pudoId.isNotEmpty) {
      showCorrectToast(message: S.of(context).pudoParcelsRetrievedSuccessfully);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PudoParcelsScreen(pudoId: pudoId),
        ),
      );
    } else {
      showErrorToast(message: S.of(context).noQrCodeDetected);
    }
  }


  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Column(
          children: [
            HomeAppBar(title: S.of(context).pickupPoint),
            const Spacer(),
            CustomMenuRecieve(
              items: [
                MenuItemData(
                  svgPath: 'assets/svgs/small_qr.svg',
                  title: S.of(context).qrScanner,
                  onTap: () async {
                    await _handlePudoQrScanning(
                      context: context,
                      showCorrectToast: showCorrectToast ,
                      showErrorToast: showErrorToast,
                    );
                  },
                ),
                /*MenuItemData(
                  svgPath: 'assets/svgs/small_qr.svg',
                  title: S.of(context).enterUsername,
                  onTap: () {
                    showManuallyUsernameBottomSheet(context);
                  },
                ),*/
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
