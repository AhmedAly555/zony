import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
            'assets/svgs/not_found_icon.svg',
            height: 400,
            width: 400,
        ),
        const SizedBox(height: 32),
        const Text(
          'No Data Found',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF929292),
          ),
        ),
      ],
    );
  }
}
