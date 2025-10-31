import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomZonyLogo extends StatelessWidget {
  const CustomZonyLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/svgs/zony-logo.svg',
      //color: Theme.of(context).primaryColor,
      width: 50,
      height: 50,
    );
      /*SvgPicture.asset(
                  'assets/svgs/image 13.svg',
                  color: Theme.of(context).primaryColor,
                  width: 24,
                  height: 24,
                ),*/

  }
}
