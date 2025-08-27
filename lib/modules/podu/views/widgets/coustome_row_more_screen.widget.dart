import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoustomeRowMoreScreen extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback onTap;

  const CoustomeRowMoreScreen({
    super.key,
    required this.iconPath,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              height: 24,
              width: 24,
              color: Color(0xFF49159B),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF1E1E1E),
                ),
              ),
            ),
            SvgPicture.asset(
              'assets/svgs/right_arrow_ios.svg',
               width: 7,
            height: 12,
              color: Color(0xFF1E1E1E),

            ),
          ],
        ),
      ),
    );
  }
}