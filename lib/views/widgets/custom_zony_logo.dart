import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomZonyLogo extends StatelessWidget {
  const CustomZonyLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return /*SvgPicture.asset(
      'assets/svgs/zony-logo.svg',
      //color: Theme.of(context).primaryColor,
      width: 50,
      height: 50,
    );*/
      Image.asset(
        'assets/images/image 13.png',
        width: 100,
        //height: 50,
      );

  }
}
