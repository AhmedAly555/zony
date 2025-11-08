import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:zony/generated/l10n.dart';

import '../../../models/pudo_model.dart';
import '../../../services/shered_preferences/pudos_storage.dart';
import '../bottom_sheet_container.dart';
import 'componants_bottom_sheet.widgets.dart';

class PudoQRBottomSheet extends StatelessWidget {
  const PudoQRBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
      child: FutureBuilder<List<Pudo>>(
        future: PudosStorage.loadPudos(),
        builder: (context, snapshot) {
          // Loading state while fetching data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              height: 350,
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final pudosList = snapshot.data;
          // Error handling and empty data check
          if (snapshot.hasError || pudosList == null || pudosList.isEmpty) {
            final String message = snapshot.hasError
                ? S.of(context).errorFetchingData + '${snapshot.error}'
                : S.of(context).noPudoDataStored;
            return SizedBox(
              height: 200,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(message, textAlign: TextAlign.center),
                ),
              ),
            );
          }

          final pudo = pudosList.first;
          final qrData = pudo.id.toString() ?? '';

          // Main UI structure for the bottom sheet
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const HederBottomSheetLine(),
              const SizedBox(height: 12),
              Text(
                pudo.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const Spacer(),

              // QR code generation and display section
              SizedBox(
                width: 360,
                height: 360,
                child: qrData.isEmpty
                    ? Center(child: Text(S.of(context).noQrData))
                    : QrImageView(
                  data: qrData,
                  version: QrVersions.auto,
                  size: 220,
                  backgroundColor: Colors.white,
                  errorStateBuilder: (context, error) {
                    // QR code error handling
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          S.of(context).couldNotGenerateQr + '${error.toString()}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Spacer(),
            ],
          );
        },
      ),
    );
  }
}
