import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:zony/generated/l10n.dart';

import '../../../../../../services/size_config.dart';
import '../../../../../../views/widgets/bottom_sheet/choose_way_bottom_sheet.dart';
import '../../../../../../views/widgets/bottom_sheet/qr_scanner.dart';
import '../../../../../../views/widgets/default_appbar.dart';
import '../../../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../../../../../views/widgets/toasts.dart';
import '../../../../../recieve_parcel/widgets/custom_menu_recieve.widget.dart';
import '../../../../recieve/screens/parcel_details.screen.dart';

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
      showCorrectToast(message: S.of(context).pudoParcelsRetrievedSuccessfully);
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
            HomeAppBar(title: S.of(context).enterParcel),
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
                  title: S.of(context).individualParcel,
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
