import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../services/size_config.dart';
import 'bottom_sheet/language_sheet.dart';

class CustomContainerIcon extends StatefulWidget {
  final String svgPath;
  final VoidCallback? onTap;

  const CustomContainerIcon({
    super.key,
    required this.svgPath,
    required this.onTap,
  });

  @override
  State<CustomContainerIcon> createState() => _CustomContainerIconState();
}

class _CustomContainerIconState extends State<CustomContainerIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap!(),
      child: Container(
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: const Color(0xFFFFFFFF),
        ),
        child: SvgPicture.asset(
          widget.svgPath,
          color: Theme.of(context).primaryColor,
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
