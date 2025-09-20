import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/services/navigator.services/app_navigator.services.dart';
import '../../../../../../views/widgets/custome_container_icon.widget.dart';
import '../../../../../../views/widgets/default_navigation_bar.widget.dart';
import '../../../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../../../../couriers/views/screens/main_home/screen/delivering_screen.dart';
import '../../../widgets/custom_home_service_container.widget.dart';
import '../../notification.screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60.0, right: 18, left: 18),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                /*SvgPicture.asset(
                  'assets/svgs/image 13.svg',
                  color: Theme.of(context).primaryColor,
                  width: 24,
                  height: 24,
                ),*/
                Image.asset(
                  'assets/images/image 13.png',
                  width: 102,
                  height: 50,
                ),
                Spacer(),
                CostumeContainerIcon(svgPath: 'assets/svgs/svg_language.svg'),
                SizedBox(width: 10),
                CostumeContainerIcon(
                  svgPath: 'assets/svgs/technical_support.svg',
                ),
                SizedBox(width: 10),
                CostumeContainerIcon(
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
              child: Row(
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
              child: Column(
                children: [
                  CustomHomeServiceContainer(
                    title: 'Receiving',
                    svgIconPath: 'assets/svgs/receiving.svg', onTap: () {},
                  ),
                  CustomHomeServiceContainer(
                    title: 'Delivering',
                    svgIconPath: 'assets/svgs/delivering.svg', onTap: () {
                      AppNavigator.navigateTo(context, () => DeliveringScreen());
                  },
                  ),
                  CustomHomeServiceContainer(
                    title: 'My Parcels',
                    svgIconPath: 'assets/svgs/my_parcels.svg', onTap: () {  },
                  ),
                  CustomHomeServiceContainer(
                    title: 'PODUs',
                    svgIconPath: 'assets/svgs/my_parcels.svg', onTap: () {  },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
