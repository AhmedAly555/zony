import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../services/size_config.dart';
import 'bottom_sheet/language_sheet.dart';


class CustomContainerIcon extends StatefulWidget {
  final String svgPath;
  //final VoidCallback? onTap;
  const CustomContainerIcon({super.key, required this.svgPath, /*this.onTap*/});

  @override
  State<CustomContainerIcon> createState() => _CustomContainerIconState();
}

class _CustomContainerIconState extends State<CustomContainerIcon> {

  String currentLanguage = 'English';

  // Language bottom sheet
  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        SizeConfig.init(context);
        return Container(
          constraints: BoxConstraints(
            maxHeight: SizeConfig.heightPercent(0.90),
            minHeight: SizeConfig.heightPercent(0.80),
          ),
          child: const IntrinsicHeight(child: LanguageBottomSheet()),
        );
      },
    ).then((selectedLang) {
      // selectedLang contains the selected language
      if (selectedLang != null) {
        setState(() {
          currentLanguage = selectedLang;
        });
        //print('Selected Language: $selectedLang');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () => showLanguageBottomSheet(context),
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
