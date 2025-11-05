import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zony/modules/podu/views/screens/main_home/screen/podu_delivering_screen.dart';

import '../../../../../../controllers/pudu_main_home_controller.dart';
import '../../../../../../models/pudo_model.dart';
import '../../../../../../services/get_pudos_service.dart';
import '../../../../../../services/navigator.services/app_navigator.services.dart';
import '../../../../../../services/shered_preferences/pudos_storage.dart';
import '../../../../../../services/size_config.dart';
import '../../../../../../views/widgets/bottom_sheet/language_sheet.dart';
import '../../../../../../views/widgets/bottom_sheet/podu_qr_bottom_sheet.dart';
import '../../../../../../views/widgets/custom_container_icon.widget.dart';
import '../../../../../../views/widgets/custom_outline_button.widget.dart';
import '../../../../../../views/widgets/custom_zony_logo.dart';
import '../../../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../../../../couriers/views/widgets/custom_home_service_container.widget.dart';
import '../../../../Recieve/parcel_approve_screen.dart';
import '../../../../inventory/screens/enter_shipment.dart';
import '../../notification.screen.dart';

class PoduHomeScreen extends StatefulWidget {
  const PoduHomeScreen({super.key});

  @override
  State<PoduHomeScreen> createState() => _PoduHomeScreenState();
}

class _PoduHomeScreenState extends State<PoduHomeScreen> {
  String currentLanguage = 'English';

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

  void showPoduQRBottomSheet(BuildContext context) {
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
            maxHeight: SizeConfig.heightPercent(0.85),
            minHeight: SizeConfig.heightPercent(0.75),
          ),
          child: IntrinsicHeight(child: PudoQRBottomSheet()),
        );
      },
    );
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
                      }),
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
                child: Text(
                  'Account',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                //margin: EdgeInsets.all(16.0),
                padding: EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Column(
                  children: [
                    Row(
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
                        FutureBuilder<List<Pudo>>(
        
                          future: PudosStorage.loadPudos(),
        
                          builder: (context, snapshot) {
        
                            //loading when data is being fetched
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
        
                            //if no data found
                            if (!snapshot.hasData || snapshot.data == null) {
                              return Center(child: Text("No PUDO Data Found"));
                            }
        
                            //if list is empty
                            final pudosList = snapshot.data!;
                            if (pudosList.isEmpty) {
                              return Center(child: Text("No PUDO Data Stored"));
                            }
        
                            final pudo = pudosList.first;
        
                            //UI
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pudo.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Color(0xFF49159B),
                                  ),
                                ),
                                Text(
                                  "${pudo.id}",
                                  style: TextStyle(
                                    color: Color(0xFF929292),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        /*Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ahmed M.Aly',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Color(0xFF49159B),
                              ),
                            ),
                            Text(
                              'ahmaly555',
                              style: TextStyle(
                                color: Color(0xFF929292),
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),*/
                        Spacer(),
                        /*Icon(Icons.arrow_forward_ios, color: Colors.grey),*/
                        SvgPicture.asset(
                          'assets/svgs/copy.svg',
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    CustomOutlineButton(
                      onTap: () {
                        showPoduQRBottomSheet(context);
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/qr_icon.svg',
                            color: Color(0xFF49159B),
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'QR Code',
                            style: TextStyle(
                              color: Color(0xFF49159B),
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Services
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Text(
                  'Services',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),

                Column(
                  children: [
                    CustomHomeServiceContainer(
                      title: 'Receiving',
                      svgIconPath: 'assets/svgs/receiving.svg', onTap: () {
                        //AppNavigator.navigateTo(context, () => ParcelApproveScreen());
                      PuduMainHomeController.instance.changeTab(1);
                    },
                    ),
                    CustomHomeServiceContainer(
                      title: 'Delivering',
                      svgIconPath: 'assets/svgs/delivering.svg', onTap: () {
                        //AppNavigator.navigateTo(context, () => PoduDeliveringScreen());
                      PuduMainHomeController.instance.changeTab(2);
                    },
                    ),
                    CustomHomeServiceContainer(
                      title: 'Inventory',
                      svgIconPath: 'assets/svgs/my_parcels.svg', onTap: () {
                        AppNavigator.navigateTo(context, () => EnterShipment());
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
