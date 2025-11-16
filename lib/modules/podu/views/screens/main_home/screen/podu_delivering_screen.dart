import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:zony/generated/l10n.dart';
import 'package:zony/views/widgets/template_app_scaffold.widget.dart';

import '../../../../../../views/widgets/bottom_sheet/manually_input_bottom_sheet.dart';
import '../../../../../../views/widgets/bottom_sheet/qr_scanner.dart';
import '../../../../../../views/widgets/default_appbar.dart';
import '../../../../../../views/widgets/toasts.dart';
import '../../../../../recieve_parcel/widgets/custom_menu_recieve.widget.dart';
import '../../../../deliver_customer/screens/parcel_details.screen.dart';


class PoduDeliveringScreen extends StatelessWidget {
  const PoduDeliveringScreen({super.key});

  Future<void> _handleQrScanning(BuildContext context) async {
    final controller = MobileScannerController();

    final receivingCode = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => QRScannerBottomSheet(
        sheetHeight: MediaQuery.of(context).size.height * 0.9,
        controller: controller,
      ),
    );

    await controller.stop();
    controller.dispose();

    if (receivingCode != null && receivingCode.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ParcelDetailsScreen(receivingCode: receivingCode),
        ),
      );
    } else {
      showErrorToast(message: S.of(context).noQrCodeDetected);
    }
  }

  Future<void> _handleManualInput(BuildContext context) async {
    final receivingCode = await showManuallyInputBottomSheet(context);

    if (receivingCode != null && receivingCode.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ParcelDetailsScreen(receivingCode: receivingCode),
        ),
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
            HomeAppBar(title: S.of(context).pickupPoint),
            const Spacer(),
            CustomMenuRecieve(
              items: [
                MenuItemData(
                  svgPath: 'assets/svgs/small_qr.svg',
                  title: S.of(context).qrScanner,
                  onTap: () => _handleQrScanning(context),
                ),
                MenuItemData(
                  svgPath: 'assets/svgs/small_qr.svg',
                  title: S.of(context).enterUsername, // You might want to change this key to something like 'enterCode'
                  onTap: () => _handleManualInput(context),
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
