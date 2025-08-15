import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../auth/widgets/custom_login_button.widget.dart';

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
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar line
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 12),
            width: 80,
            height: 4,
            decoration: BoxDecoration(
              color: Color(0xFF929292),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Language icon
          Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFFFF59D),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/svgs/svg_language.svg',
              width: 24,
              height: 24,
              color: Color(0xFF49159B),

            ),
          ),

          const SizedBox(height: 16),

          // Title
          const Text(
            'Choose your language',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 8),

          // Description
          const Text(
            'Lorem ipsum dolor sit amet, consectetur\nadipiscing elit, sed do eiusmod',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 60),

          // Language options
          ...languages.map((language) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
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
                  color: selectedLanguage == language
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
                          color: selectedLanguage == language
                              ? const Color(0xFF6366F1)
                              : Colors.grey[400]!,
                          width: 2,
                        ),
                        color: selectedLanguage == language
                            ? const Color(0xFF6366F1)
                            : Colors.transparent,
                      ),
                      child: selectedLanguage == language
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
                        fontWeight: selectedLanguage == language
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: selectedLanguage == language
                            ? const Color(0xFF6366F1)
                            : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )).toList(),

          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: CustomLoginButton(onTap: () {}),
          ),
        ],
      ),
    );
  }
}

