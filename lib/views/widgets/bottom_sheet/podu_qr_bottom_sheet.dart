import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'componants_bottom_sheet.widgets.dart';

class PoduQRBottomSheet extends StatelessWidget {
  const PoduQRBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar line
            HederBottomSheetLine(),
            Text(
              'PODU [Name]',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            Spacer(),
            SvgPicture.asset(
              'assets/svgs/QR.svg',
              width: 232,
              height: 232,
              //color: Color(0xFF49159B),

            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
