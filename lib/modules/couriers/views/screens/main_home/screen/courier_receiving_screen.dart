import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../../../services/size_config.dart';
import '../../../../../../views/widgets/bottom_sheet/choose_way_bottom_sheet.dart';
import '../../../../../../views/widgets/bottom_sheet/qr_scanner.dart';
import '../../../../../../views/widgets/secondary_appbar.dart';
import '../../../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../../../../../views/widgets/toasts.dart';
import '../../../../../recieve_parcel/widgets/custom_menu_recieve.widget.dart';
import '../../../../recieve_expired/screens/parcel_details.screen.dart';

class CourierReceivingScreen extends StatelessWidget {
  const CourierReceivingScreen({super.key});

  void showChooseWayBottomSheet(BuildContext context) {
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
            child: ChooseWayBottomSheet(
              onBarcodeScannerTap: () {
                _handleParcelQrScanning(
                  context: context,
                  showCorrectToast: showCorrectToast,
                  showErrorToast: showErrorToast,
                );
              },
            ),
          ),
        );
      },
    );
  }

  //Handle Parcel QR Scanning
  Future<void> _handleParcelQrScanning({
    required BuildContext context,
    required Function showCorrectToast,
    required Function showErrorToast,
  }) async {
    //Navigator.pop(context);

    final controller = MobileScannerController();

    final barcode = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (_) => QRScannerBottomSheet(
            sheetHeight: MediaQuery.of(context).size.height * 0.9,
            controller: controller,
          ),
    );

    // after returning stop the camera
    await controller.stop();

    if (barcode != null && barcode.isNotEmpty) {


      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ParcelDetailsScreen(barcode: barcode),
        ),
      );
      showCorrectToast(message: 'PUDO parcels retrieved successfully');
    } else {
      showErrorToast(message: '⚠️ No QR code detected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Column(
          children: [
            const SecondaryAppBar(title: 'Enter Parcel'),
            const Spacer(),
            CustomMenuRecieve(
              items: [
                /*MenuItemData(
                    //svgPath: 'assets/svgs/small_qr.svg',
                    title: "Parcel List",
                    onTap: () {},
                  ),*/
                MenuItemData(
                  svgPath: 'assets/svgs/small_qr.svg',
                  title: "Individual Parcel",
                  onTap: () {
                    showChooseWayBottomSheet(context);
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
