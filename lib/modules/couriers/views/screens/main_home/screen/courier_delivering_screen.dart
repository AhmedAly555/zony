import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:zony/views/widgets/template_app_scaffold.widget.dart';

import '../../../../../../services/size_config.dart';
import '../../../../../../views/widgets/bottom_sheet/manually_username_bottom_sheet.dart';
import '../../../../../../views/widgets/bottom_sheet/qr_scanner.dart';
import '../../../../../../views/widgets/bottom_sheet/wrong_location_bottom_sheet.dart';
import '../../../../../../views/widgets/secondary_appbar.dart';
import '../../../../../recieve_parcel/widgets/custom_menu_recieve.widget.dart';
import '../../../../delivering/screens/podu_parcels.screen.dart';


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

  Future<void> _handleQRScan(BuildContext context) async {
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
      //print('✅ Scanned Pudo ID: $pudoId');
      Fluttertoast.showToast(
        msg: 'PUDO parcels retrieved successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PudoParcelsScreen(pudoId: pudoId),
        ),
      );
    } else {
      Fluttertoast.showToast(
        msg: '⚠️ No QR code detected',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
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
                      //print('✅ Scanned Pudo ID: $pudoId');
                      Fluttertoast.showToast(
                        msg: 'PUDO parcels retrieved successfully',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PudoParcelsScreen(pudoId: pudoId),
                        ),
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: '⚠️ No QR code detected',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.redAccent,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
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
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
