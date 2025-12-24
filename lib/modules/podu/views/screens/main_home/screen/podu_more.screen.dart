import 'package:flutter/material.dart';
import 'package:zony/generated/l10n.dart';
import 'package:zony/services/navigator.services/app_navigator.services.dart';

import '../../../../../../services/size_config.dart';
import '../../../../../../views/widgets/bottom_sheet/language_sheet.dart';
import '../../../../../../views/widgets/bottom_sheet/log_out_bottom_sheet.dart';
import '../../../../../../views/widgets/default_appbar.dart';
import '../../../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../../../../couriers/views/screens/account_settings.screen.dart';
import '../../../../../couriers/views/widgets/coustome_row_more_screen.widget.dart';
import '../../revenue.dart';

class PoduMoreScreen extends StatefulWidget {
  const PoduMoreScreen({super.key});

  @override
  State<PoduMoreScreen> createState() => _PoduMoreScreenState();
}

class _PoduMoreScreenState extends State<PoduMoreScreen> {
  String currentLanguage = 'English';

  void showLanguageBottomSheet() {
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
          child: const IntrinsicHeight(
            child: LanguageBottomSheet(),
          ),
        );
      },
      /*=> DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.7,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => LanguageBottomSheet(),
      ),*/
    ).then((selectedLang) {
      // selectedLang contains the selected language
      if (selectedLang != null) {
        setState(() {
          currentLanguage = selectedLang;
        });
        print(S.of(context).selectedLanguage + '$selectedLang');
      }
    });
  }

  void showLogoutBottomSheet() {
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
            maxHeight: SizeConfig.heightPercent(0.75),
            minHeight: SizeConfig.heightPercent(0.45),
          ),
          child: const IntrinsicHeight(
            child: LogOutBottomSheet(),
          ),
        );
      },

    );
  }

  @override
  Widget build(BuildContext context) {

    return TemplateAppScaffold(
      body: Column(
        children: [
          const SizedBox(height: 24),
          HomeAppBar(title: S.of(context).moreSettings),
          //const SizedBox(height: 50),
          const Spacer(),
          CoustomeRowMoreScreen(
            iconPath: 'assets/svgs/account.svg',
            title: S.of(context).accountSettings,
            onTap: () {
              AppNavigator.navigateTo(context, () =>  AccountSettingsScreen());
            },
          ),
          const SizedBox(height: 16),
          CoustomeRowMoreScreen(
            iconPath: 'assets/svgs/svg_language.svg',
            title: S.of(context).language,
            onTap: () {
              showLanguageBottomSheet();
            },
          ),
          const SizedBox(height: 16),
          CoustomeRowMoreScreen(
            iconPath: 'assets/svgs/revenue.svg',
            title: 'Revenue',
            onTap: () {
              AppNavigator.navigateTo(context, () =>  const Revenue());
            },
          ),
          const SizedBox(height: 16),
          CoustomeRowMoreScreen(
            iconPath: 'assets/svgs/logout.svg',
            title: S.of(context).logout,
            onTap: () {
              showLogoutBottomSheet();
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
