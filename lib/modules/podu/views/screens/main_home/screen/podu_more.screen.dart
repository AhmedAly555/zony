import 'package:flutter/material.dart';
import 'package:zony/services/navigator.services/app_navigator.services.dart';

import '../../../../../../services/size_config.dart';
import '../../../../../../theme/app_text_styles.dart';
import '../../../../../../views/widgets/bottom_sheet/language_sheet.dart';
import '../../../../../../views/widgets/bottom_sheet/log_out_bottom_sheet.dart';
import '../../../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../../../../couriers/views/widgets/coustome_row_more_screen.widget.dart';
import '../../account_settings.screen.dart';

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
          child: IntrinsicHeight(
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
        print('Selected Language: $selectedLang');
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
          child: IntrinsicHeight(
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
          const Center(
            child: Text(
              'More Settings',
              style: AppTextStyles.textStyle24black,
            ),
          ),
          //const SizedBox(height: 50),
          Spacer(),
          CoustomeRowMoreScreen(
            iconPath: 'assets/svgs/account.svg',
            title: 'Account Settings',
            onTap: () {
              AppNavigator.navigateTo(context, () =>  AccountSettingsScreen());
            },
          ),
          const SizedBox(height: 16),
          CoustomeRowMoreScreen(
            iconPath: 'assets/svgs/svg_language.svg',
            title: 'Language',
            onTap: () {
              showLanguageBottomSheet();
            },
          ),
          const SizedBox(height: 16),
          CoustomeRowMoreScreen(
            iconPath: 'assets/svgs/revenue.svg',
            title: 'Revenue',
            onTap: () {},
          ),
          const SizedBox(height: 16),
          CoustomeRowMoreScreen(
            iconPath: 'assets/svgs/logout.svg',
            title: 'Logout',
            onTap: () {
              showLogoutBottomSheet();
            },
          ),
          Spacer(),
        ],
      ),
    );
  }
}

