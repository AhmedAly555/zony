import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/svgs/dropdown_arrow.svg",
          width: 7.18,
          height: 4.59,
          //color: ,
        ),
        const SizedBox(width: 14.0),
        Text(
          'EN',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: Color(0xFF49159B),
          ),
        ),
        const SizedBox(width: 14.0),
        SvgPicture.asset(
          "assets/svgs/svg_language.svg",
          width: 18.7,
          height: 19.9,
          //color: ,
        ),
      ],
    );
  }
}
