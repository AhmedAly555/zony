import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessfulImage extends StatelessWidget {
  const SuccessfulImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SvgPicture.asset(
        'assets/svgs/successful-1.svg',
        /*width: 200,
              height: 200,*/
      ),
    );
  }
}
