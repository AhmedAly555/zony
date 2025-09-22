import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../services/navigator.services/app_navigator.services.dart';
import '../../../../../../services/size_config.dart';
import '../../../../../../views/widgets/bottom_sheet/podu_qr_bottom_sheet.dart';
import '../../../../../../views/widgets/custom_container_icon.widget.dart';
import '../../../../../../views/widgets/custom_outline_button.widget.dart';
import '../../../../../../views/widgets/custom_zony_logo.dart';
import '../../../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../../../../couriers/views/widgets/custom_home_service_container.widget.dart';
import '../../notification.screen.dart';

class PoduHomeScreen extends StatelessWidget {
  const PoduHomeScreen({super.key});

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
          child: IntrinsicHeight(child: PoduQRBottomSheet()),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0, right: 18, left: 18),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomZonyLogo(),
                Spacer(),
                CustomContainerIcon(svgPath: 'assets/svgs/svg_language.svg'),
                SizedBox(width: 10),
                CustomContainerIcon(
                  svgPath: 'assets/svgs/technical_support.svg',
                ),
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
            // will make it costume widget in the future
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Text(
                  'RUH-5-AZ-10',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF49159B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

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
                      Column(
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
                      ),
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomHomeServiceContainer(
                      title: 'Receiving',
                      svgIconPath: 'assets/svgs/receiving.svg', onTap: () {},
                    ),
                    CustomHomeServiceContainer(
                      title: 'Delivering',
                      svgIconPath: 'assets/svgs/delivering.svg', onTap: () {},
                    ),
                    CustomHomeServiceContainer(
                      title: 'Inventory',
                      svgIconPath: 'assets/svgs/my_parcels.svg', onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
