import 'package:flutter/material.dart';
import 'package:zony/generated/l10n.dart';
import 'package:zony/views/widgets/default_button.widget.dart';

import '../../../../../theme/app_text_styles.dart';
import '../../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../../../services/navigator.services/app_navigator.services.dart';
import '../../../../views/widgets/custom_outline_button.widget.dart';
import '../../../../views/widgets/successful_screen.widget.dart';
import '../../views/screens/main_home/screen/podu_delivering_screen.dart';
import '../../views/screens/main_home/screen/podu_home_screen.dart';


class SuccessfulPoduDelivering extends StatelessWidget {
  //final String? pudoId;
  SuccessfulPoduDelivering({super.key,
    //this.pudoId
  });

  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: Column(
        children: [
          SuccessfulImage(),
          Text(
            S.of(context).successfulDeliveringProcess,
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
                    () => PoduDeliveringScreen(),
              ),
              child: Text(
                S.of(context).deliverNewParcel,
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
                        () => PoduDeliveringScreen(),
                  ),
                  child: Text(
                    S.of(context).deliverNewParcel,
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
                  onTap: () => AppNavigator.navigateTo(context, () => PoduHomeScreen()),
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
