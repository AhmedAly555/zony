import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../modules/auth/widgets/custom_login_button.widget.dart';
import 'componants_bottom_sheet.widgets.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  String selectedLanguage = 'English';

  final List<String> languages = ['Arabic', 'English', 'Chinese', 'Arduo'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        //mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Handle bar line
          HandleBarLine(),

          //const SizedBox(height: 60),
          Spacer(),
          // Language icon
          LanguageIcon(svgPath: 'assets/svgs/svg_language.svg'),

          const SizedBox(height: 16),

          // Title
          const Text(
            'Choose your language',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 8),

          // Description
          const Text(
            'Lorem ipsum dolor sit amet, consectetur nadipiscing elit, sed do eiusmod',
            textAlign: TextAlign.center,

            style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.4),
          ),

          Spacer(),

          // Language options
          ...languages
              .map(
                (language) => Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 4,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedLanguage = language;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              selectedLanguage == language
                                  ? const Color(0xFFE8EAF6)
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row( 
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color:
                                      selectedLanguage == language
                                          ? const Color(0xFF6366F1)
                                          : Colors.grey[400]!,
                                  width: 2,
                                ),
                                color:
                                    selectedLanguage == language
                                        ? const Color(0xFF6366F1)
                                        : Colors.transparent,
                              ),
                              child:
                                  selectedLanguage == language
                                      ? const Icon(
                                        Icons.check,
                                        size: 12,
                                        color: Colors.white,
                                      )
                                      : null,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              language,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight:
                                    selectedLanguage == language
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                color:
                                    selectedLanguage == language
                                        ? const Color(0xFF6366F1)
                                        : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),

          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: CustomLoginButton(onTap: () {}),
          ),
        ],
      ),
    );
  }
}
