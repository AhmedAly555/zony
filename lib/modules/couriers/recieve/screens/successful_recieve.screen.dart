import 'package:flutter/material.dart';
import 'package:zony/generated/l10n.dart';
import 'package:zony/views/widgets/default_button.widget.dart';

import '../../../../../theme/app_text_styles.dart';
import '../../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../../../controllers/courier_main_home_controller.dart';
import '../../../../services/navigator.services/app_navigator.services.dart';
import '../../../../views/widgets/custom_outline_button.widget.dart';
import '../../../../views/widgets/successful_screen.widget.dart';
import '../../views/screens/main_home/screen/courier_home.screen.dart';
import '../../views/screens/main_home/screen/courier_main_home_screen.dart';
import '../../views/screens/main_home/screen/courier_receiving_screen.dart';


class SuccessfulRecieveScreen extends StatelessWidget {
  //final String? poduId;
  const SuccessfulRecieveScreen({super.key,
    //this.poduId,
  });

  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: Column(
        children: [
          const SuccessfulImage(),
          Text(
            S.of(context).successfulReceivingProcess,
            textAlign: TextAlign.center,
            style: AppTextStyles.textStyle24,
          ),
          const SizedBox(height: 18),
          Text(
            S.of(context).pickupTimeAndLocationRecorded,
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
                        () => const CourierReceivingScreen(
                      //pudoId: poduId!,
                    ),
                  ),
                  child: Text(
                    S.of(context).receiveNewParcel,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                CustomOutlineButton(
                  //onTap: () => AppNavigator.navigateAndRemoveUntil(context, () => const CourierHomeScreen()),
                  onTap: () {
                    AppNavigator.navigateAndRemoveUntil(
                        context,
                            () => const CourierMainHomeScreen()
                    );
                    CourierMainHomeController.instance.changeTab(0);
                  },
                  title: Text(
                    S.of(context).backToHome,
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
