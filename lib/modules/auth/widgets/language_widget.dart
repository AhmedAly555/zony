import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../services/size_config.dart';
import '../../../views/widgets/bottom_sheet/language_sheet.dart';

class LanguageWidget extends StatefulWidget {
   LanguageWidget({super.key});

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
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
          child: IntrinsicHeight(child: LanguageBottomSheet()),
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
    return GestureDetector(
      onTap: () {
        showLanguageBottomSheet(context);
      },
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/svgs/dropdown_arrow.svg",
            width: 7.18,
            height: 4.59,
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
          ),
        ],
      ),
    );
  }
}
