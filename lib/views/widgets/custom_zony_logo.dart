import 'package:flutter/material.dart';

class CustomZonyLogo extends StatelessWidget {
  const CustomZonyLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/image 13.png',
      width: 102,
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
