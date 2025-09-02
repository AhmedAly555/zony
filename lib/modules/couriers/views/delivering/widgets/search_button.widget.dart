import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchButton extends StatelessWidget {
  final String svgPath;
  final String text;
  final VoidCallback onTap;

  const SearchButton({
    super.key,
    required this.svgPath,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F4F4),
          borderRadius: BorderRadius.circular(24),

        ),
        child: Column(
          children: [
            SvgPicture.asset(
              svgPath,
              color: Theme.of(context).primaryColor,
              width: 30,
              height: 30,

            ),
            const SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}