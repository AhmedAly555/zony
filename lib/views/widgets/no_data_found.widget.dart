import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignmen t.center,
      children: [
        //const Spacer(),
        SvgPicture.asset(
            'assets/svgs/not_found_icon.svg',
            height: 205,
            width: 185,
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
        //const Spacer(),

      ],
    );
  }
}
