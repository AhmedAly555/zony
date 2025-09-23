import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CirclerIcon extends StatelessWidget {
  final String svgPath;
  const CirclerIcon({super.key, required this.svgPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        shape: BoxShape.circle,
        //borderRadius: BorderRadius.circular(8),
      ),
      child: SvgPicture.asset(
        svgPath,
        color: const Color(0xFF49159B),
        width: 19.5,
        height: 22,

      ),
    );
  }
}
