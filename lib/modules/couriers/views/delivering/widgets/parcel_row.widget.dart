import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoItem extends StatelessWidget {
  final String svgPath;
  final String text;

  const InfoItem({
    super.key,
    required this.svgPath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          svgPath,
          //color: Theme.of(context).primaryColor,
          width: 32,
          height: 32,

        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF374151),
            ),
          ),
        ),
      ],
    );
  }
}