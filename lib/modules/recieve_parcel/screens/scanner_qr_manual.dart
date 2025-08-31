/*
import 'package:flutter/material.dart';
import 'package:zony/views/widgets/template_app_scaffold.widget.dart';

import '../../../views/widgets/secondary_appbar.dart';
import '../widgets/custom_menu_recieve.widget.dart';

class ScannerQrManualScreen extends StatelessWidget {
  const ScannerQrManualScreen({super.key});

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
                  onTap: () {
                    // navigation or logic
                    debugPrint("Scan Barcode tapped");
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
*/