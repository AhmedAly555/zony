import 'package:flutter/material.dart';
import 'package:zony/views/widgets/default_button.widget.dart';

import '../../../../../theme/app_text_styles.dart';
import '../../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../../../services/navigator.services/app_navigator.services.dart';
import '../../../../views/widgets/custom_outline_button.widget.dart';
import '../../../../views/widgets/successful_screen.widget.dart';
import '../../views/screens/main_home/screen/courier_home.screen.dart';
import '../../views/screens/main_home/screen/courier_receiving_screen.dart';
import 'expired_receiving.screen.dart';


class SuccessfulExpiredRecieveScreen extends StatelessWidget {
  //final String? poduId;
  const SuccessfulExpiredRecieveScreen({super.key,
    //this.poduId,
  });

  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: Column(
        children: [
          SuccessfulImage(),
          Text(
            "Successful Delivering process",
            textAlign: TextAlign.center,
            style: AppTextStyles.textStyle24,
          ),
          const SizedBox(height: 18),
          Text(
            "The time and location of the pickup will be recorded automatically.",
            textAlign: TextAlign.center,
            style: AppTextStyles.textStyle14Grey,
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, right: 18, left: 18),
            child: /*DefaultButton(
              onTap:
                  () => AppNavigator.navigateTo(
                context,
                    () => CourierReceivingScreen(
                      //pudoId: poduId!,
                    ),
              ),
              child: Text(
                'Deliver New Parcel',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),*/
            Column(
              children: [
                DefaultButton(
                  onTap:
                      () => AppNavigator.navigateTo(
                    context,
                        () => ExpiredReceivingScreen(
                      //pudoId: poduId!,
                    ),
                  ),
                  child: Text(
                    'Deliver New Parcel',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 18),
                CustomOutlineButton(
                  onTap: () => AppNavigator.navigateTo(context, () => CourierHomeScreen()),
                  title: Text(
                    'Back To Home',
                    style: AppTextStyles.textStyle16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
