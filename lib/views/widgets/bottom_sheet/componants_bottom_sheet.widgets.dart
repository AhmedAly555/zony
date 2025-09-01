import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

 // Handle bar line
class HederBottomSheetLine extends StatelessWidget {
  const HederBottomSheetLine({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.only(top: 12, bottom: 12),
      width: 80,
      height: 4,
      decoration: BoxDecoration(
        color: Color(0xFF929292),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

// Bottom Sheet Icon
class BottomSheetIcon extends StatelessWidget {
  final String svgPath;
  const BottomSheetIcon({super.key, required this.svgPath});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 60,
      height: 60,
      padding: const EdgeInsets.all(18),
      decoration: const BoxDecoration(
        color: Color(0xFFFFEB66),
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        svgPath,
        width: 24,
        height: 24,
        //color: Color(0xFF49159B),

      ),
    );
  }
}
