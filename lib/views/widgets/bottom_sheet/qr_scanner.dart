import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../scanner_line.dart';

class QRScannerBottomSheet extends StatelessWidget {

  final double sheetHeight;
  final MobileScannerController controller;

  const QRScannerBottomSheet({super.key, required this.sheetHeight, required this.controller});



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
              top: 24,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 100,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Color(0xFF929292),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),

            // Cornersا
            Center(
              child: SizedBox(
                width: 260,
                height: 260,
                child: CustomPaint(painter: _CornersPainter()),
              ),
            ),

            Center (
              child: ScannerLine(
                width: 260,
                height: 260,
                color: Color(0xFF49159B),
                lineHeight: 6,
                duration: Duration(seconds: 2),
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(top: 420,right: 18,left: 18,),
              child: Center(
                child: Text(
                  "Scan QR code in front of the camera",
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
    const double radius = 12.0;       // the radius of the bend
    final Paint p = Paint()
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
        Offset(size.width - radius * 2, size.height - radius * 2), 0); // right → up

    // Bottom-left
    drawCorner(
        Offset(0, size.height - radius * 2), pi / 2); // bottom → right
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


/*
class _CornersPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const corner = 28.0;
    final p =
        Paint()
          ..color = Color(0xFF49159B)
          ..strokeWidth = 4
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;

    // top-left
    canvas.drawLine(const Offset(0, 0), Offset(corner, 0), p);
    canvas.drawLine(const Offset(0, 0), Offset(0, corner), p);

    // top-right
    canvas.drawLine(Offset(size.width, 0), Offset(size.width - corner, 0), p);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, corner), p);

    // bottom-left
    canvas.drawLine(Offset(0, size.height), Offset(0, size.height - corner), p);
    canvas.drawLine(Offset(0, size.height), Offset(corner, size.height), p);

    // bottom-right
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width - corner, size.height),
      p,
    );
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width, size.height - corner),
      p,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
*/
