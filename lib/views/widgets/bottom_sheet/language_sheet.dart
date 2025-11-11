import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zony/generated/l10n.dart';
import 'package:zony/services/locale_language_service.dart';

import '../../../theme/app_text_styles.dart';
import '../bottom_sheet_container.dart';
import '../default_button.widget.dart';
import 'componants_bottom_sheet.widgets.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  late Locale _selectedLocale;

  @override
  void initState() {
    super.initState();
    _selectedLocale = LocaleLanguageService.instance.localeNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Locale> _supportedLanguages = {
      S.of(context).english: const Locale('en'),
      S.of(context).arabic: const Locale('ar'),
      S.of(context).hindi: const Locale('hi'),
      S.of(context).bengali: const Locale('bn'),
      S.of(context).urdu: const Locale('ur'),
    };

    return BottomSheetContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Handle bar line
          const HederBottomSheetLine(),

          const Spacer(),
          // Language icon
          const BottomSheetIcon(svgPath: 'assets/svgs/svg_language.svg'),

          const SizedBox(height: 16),

          // Title
          Text(
            S.of(context).chooseYourLanguage,
            style: AppTextStyles.bottomSheetTitle,
          ),

          const SizedBox(height: 8),

          // Description
          Text(
            S.of(context).languageSelectionDescription,
            textAlign: TextAlign.center,
            style: AppTextStyles.bottomSheetDescription,
          ),

          const Spacer(),

          // Language options
          ..._supportedLanguages.entries.map((entry) {
            final languageName = entry.key;
            final locale = entry.value;
            final isSelected = _selectedLocale == locale;

            return Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 4,
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedLocale = locale;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFFE8EAF6) : Colors.transparent,
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
                              color: isSelected ? const Color(0xFF6366F1) : Colors.grey[400]!,
                              width: 2,
                            ),
                            color: isSelected ? const Color(0xFF6366F1) : Colors.transparent,
                          ),
                          child: isSelected
                              ? const Icon(
                                  Icons.check,
                                  size: 12,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          languageName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                            color: isSelected ? const Color(0xFF6366F1) : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),

          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: DefaultButton(onTap: () {
              LocaleLanguageService.instance.setLocale(_selectedLocale);
              Navigator.pop(context);
            }),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 16)),
        ],
      ),
    );
  }
}
