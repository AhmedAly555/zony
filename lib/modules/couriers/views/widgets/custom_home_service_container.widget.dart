import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomHomeServiceContainer extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String svgIconPath;
  final Color? color;

  const CustomHomeServiceContainer({
    super.key,
    required this.title,
    required this.svgIconPath,
    required this.onTap, this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          color: color ?? const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: const Color(0xFFdbd0eb),
              ),
              child: SvgPicture.asset(
                svgIconPath,
                width: 24,
                height: 26,
                color: const Color(0xFF49159B),
              ),
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xFF1E1E1E),
              ),
            ),
            const Spacer(),
            const SizedBox(width: 20),
            const Icon(Icons.arrow_forward_ios, size: 16, ),

            /*SvgPicture.asset(
              'assets/svgs/right_arrow_ios.svg',
              width: 7,
              height: 12,
              color: Color(0xFF1E1E1E),
            ),*/
          ],
        ),
      ),
    );
  }
}
