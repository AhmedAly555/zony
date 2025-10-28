import 'package:flutter/material.dart';
import 'package:zony/views/widgets/default_button.widget.dart';

import '../../../../../theme/app_text_styles.dart';
import '../../../../../views/widgets/custom_outline_button.widget.dart';
import '../../../../../views/widgets/template_app_scaffold.widget.dart';

class SuccessfulRecieve extends StatelessWidget {
  const SuccessfulRecieve({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: Column(
        children: [
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
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, right: 18, left: 18),
            child: Column(
              children: [
                DefaultButton(
                  onTap: () {},
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
                  title: Text(
                    'Back To Parcel List',
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
