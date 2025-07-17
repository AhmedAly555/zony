import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CostumeContainerIcon extends StatelessWidget {
  final String svgPath;
  const CostumeContainerIcon({super.key, required this.svgPath});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Color(0xFFFFFFFF),
      ),
      child: SvgPicture.asset(
        svgPath,
        color: Theme.of(context).primaryColor,
        width: 24,
        height: 24,

      ),
    );
  }
}
