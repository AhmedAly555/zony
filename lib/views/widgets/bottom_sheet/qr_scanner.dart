import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:zony/generated/l10n.dart';

import '../scanner_line.dart';
import 'componants_bottom_sheet.widgets.dart';

class QRScannerBottomSheet extends StatelessWidget {
  final double sheetHeight;
  final MobileScannerController controller;

  const QRScannerBottomSheet({
    super.key,
    required this.sheetHeight,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    bool popped = false;

    return SizedBox(
      height: sheetHeight,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Stack(
          children: [
            // Camera scanner
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              child: MobileScanner(
                controller: controller,
                onDetect: (BarcodeCapture capture) {
                  if (popped) return;
                  final barcodes = capture.barcodes;
                  if (barcodes.isEmpty) return;
                  final raw = barcodes.first.rawValue;
                  if (raw == null) return;
                  popped = true;
                  Navigator.of(context).pop(raw);
                },
              ),
            ),

            // dash
            Positioned(
              top: 10,
              left: 0,
              right: 0,
              child: Center(child: const HederBottomSheetLine()),
            ),

            // Corners
            Center(
              child: SizedBox(
                width: 260,
                height: 260,
                child: CustomPaint(painter: _CornersPainter()),
              ),
            ),

            Center(
              child: ScannerLine(
                width: 260,
                height: 260,
                color: Color(0xFF49159B),
                lineHeight: 6,
                duration: Duration(seconds: 2),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 420, right: 18, left: 18),
              child: Center(
                child: Text(
                  S.of(context).scanQrCodeInFrontOfCamera,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF49159B),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CornersPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double cornerLength = 28.0; // how far each corner goes
    const double radius = 12.0; // the radius of the bend
    final Paint p =
        Paint()
          ..color = const Color(0xFF49159B)
          ..strokeWidth = 4
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    // helper: draw an arc corner at a given rect and start angle
    void drawCorner(Offset origin, double startAngle) {
      final Rect arcRect = Rect.fromLTWH(
        origin.dx,
        origin.dy,
        radius * 2,
        radius * 2,
      );
      canvas.drawArc(arcRect, startAngle, pi / 2, false, p);
    }

    // Top-left
    drawCorner(const Offset(0, 0), pi); // starts from left → down

    // Top-right
    drawCorner(Offset(size.width - radius * 2, 0), 3 * pi / 2); // top → left

    // Bottom-right
    drawCorner(
      Offset(size.width - radius * 2, size.height - radius * 2),
      0,
    ); // right → up

    // Bottom-left
    drawCorner(Offset(0, size.height - radius * 2), pi / 2); // bottom → right
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
