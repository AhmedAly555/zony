import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../controllers/courier_main_home_controller.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../models/profile_model.dart';
import '../../../../../../services/navigator.services/app_navigator.services.dart';
import '../../../../../../services/shered_preferences/profile_storage.dart';
import '../../../../../../services/size_config.dart';
import '../../../../../../theme/app_text_styles.dart';
import '../../../../../../views/widgets/bottom_sheet/language_sheet.dart';
import '../../../../../../views/widgets/custom_container_icon.widget.dart';
import '../../../../../../views/widgets/custom_zony_logo.dart';
import '../../../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../../../../../views/widgets/toasts.dart';
import '../../../../podus&parcels/all_podus.dart';
import '../../../../podus&parcels/my_parcels.dart';
import '../../../../podus&parcels/podu_details_and_parcels/podu_details_and_parcels.screen.dart';
import '../../../../recieve_expired/screens/expired_receiving.screen.dart';
import '../../../widgets/custom_home_service_container.widget.dart';
import '../../notification.screen.dart';

class CourierHomeScreen extends StatefulWidget {
  const CourierHomeScreen({super.key});

  @override
  State<CourierHomeScreen> createState() => _CourierHomeScreenState();
}

class _CourierHomeScreenState extends State<CourierHomeScreen> {
  // Copy to clipboard function
  void _copyToClipboard(BuildContext context, String username) async {
    await Clipboard.setData(ClipboardData(text: username));

    if (context.mounted) {
      showCorrectToast(message: 'Username copied to clipboard');
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0, right: 18, left: 18),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomZonyLogo(),
                  Spacer(),
                  CustomContainerIcon(
                    svgPath: 'assets/svgs/svg_language.svg',
                    onTap: () {
                      showLanguageBottomSheet(context);
                    },
                  ),
                  SizedBox(width: 10),
                  /*CustomContainerIcon(
                    svgPath: 'assets/svgs/technical_support.svg',
                  ),*/
                  SizedBox(width: 10),
                  CustomContainerIcon(
                    svgPath: 'assets/svgs/notification.svg',
                    onTap: () {
                      AppNavigator.navigateTo(
                        context,
                        () => NotificationScreen(),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              //Account
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Text(S.of(context).account, style: AppTextStyles.textStyle14),
              ),
              Container(
                //margin: EdgeInsets.all(16.0),
                padding: EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: FutureBuilder<Profile?>(
                  future: ProfileStorage.getProfile(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data == null) {
                      return Center(child: Text("No Data"));
                    }

                    final profile = snapshot.data!;
                    return Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 14.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Color(0xFFF4F4F4),
                          ),
                          child: Text(
                            'A',
                            style: TextStyle(
                              color: Color(0xFF929292),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${profile.firstName} ${profile.lastName}',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Color(0xFF49159B),
                              ),
                            ),
                            Text(
                              profile.username,
                              style: TextStyle(
                                color: Color(0xFF929292),
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            _copyToClipboard(context, profile.username);
                          },
                          child: SvgPicture.asset(
                            'assets/svgs/copy.svg',
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              // Services
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Text('Services', style: AppTextStyles.textStyle14),
              ),
              Column(
                children: [
                  CustomHomeServiceContainer(
                    title: 'Receiving',
                    svgIconPath: 'assets/svgs/receiving.svg',
                    onTap: () {
                      //AppNavigator.navigateTo(context, () => CourierMainHomeScreen(initialIndex: 1));
                      CourierMainHomeController.instance.changeTab(1);
                    },
                  ),
                  CustomHomeServiceContainer(
                    title: 'Delivering',
                    svgIconPath: 'assets/svgs/delivering.svg',
                    onTap: () {
                      //AppNavigator.navigateTo(context, () => CourierMainHomeScreen(initialIndex: 2));
                      CourierMainHomeController.instance.changeTab(2);


                    },
                  ),
                  CustomHomeServiceContainer(
                    title: 'Expired',
                    svgIconPath: 'assets/svgs/delivering.svg',
                    onTap: () {
                      AppNavigator.navigateTo(
                        context,
                            () => ExpiredReceivingScreen(),
                      );
                    },
                  ),
                  CustomHomeServiceContainer(
                    title: 'My Parcels',
                    svgIconPath: 'assets/svgs/my_parcels.svg',
                    onTap: () {
                      AppNavigator.navigateTo(context, () => MyParcelsScreen());
                    },
                  ),
                  CustomHomeServiceContainer(
                    title: 'PODUs',
                    svgIconPath: 'assets/svgs/my_parcels.svg',
                    onTap: () {
                      AppNavigator.navigateTo(context, () => AllPODUsScreen());
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
