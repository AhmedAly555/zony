import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:zony/generated/l10n.dart';
import 'package:zony/services/get_courier_pudos_service.dart';
import 'package:zony/views/widgets/template_app_scaffold.widget.dart';

import '../../../../../../views/widgets/bottom_sheet/manually_input_bottom_sheet.dart';
import '../../../../../../views/widgets/bottom_sheet/qr_scanner.dart';
import '../../../../../../views/widgets/default_appbar.dart';
import '../../../../../../views/widgets/toasts.dart';
import '../../../../../recieve_parcel/widgets/custom_menu_recieve.widget.dart';
import '../../../../delivering/screens/pudo_parcels.screen.dart';

class CourierDeliveringScreen extends StatelessWidget {
  const CourierDeliveringScreen({super.key});

  //Handle Pudo QR Scanning
  Future<void> _handlePudoQrScanning(BuildContext context) async {
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

  //Handle Pudo Username Input
  Future<void> _handlePudoUsernameInput(BuildContext context) async {
    final username = await showManuallyInputBottomSheet(context);

    if (username != null && username.isNotEmpty) {
      try {
        final response = await GetCourierPudosService.instance.getPudosByUsername(username);
        if (response.pudos.isNotEmpty) {
          final pudoId = response.pudos.first.id.toString();
          showCorrectToast(message: S.of(context).pudoParcelsRetrievedSuccessfully);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PudoParcelsScreen(pudoId: pudoId),
            ),
          );
        } else {
          showErrorToast(message: S.of(context).noPodusFound);
        }
      } catch (e) {
        showErrorToast(message: e.toString());
      }
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
                  onTap: () => _handlePudoQrScanning(context),
                ),
                MenuItemData(
                  svgPath: 'assets/svgs/small_qr.svg',
                  title: S.of(context).enterUsername,
                  onTap: () => _handlePudoUsernameInput(context),
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
