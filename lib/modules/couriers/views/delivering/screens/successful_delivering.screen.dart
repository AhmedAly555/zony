import 'package:flutter/material.dart';
import 'package:zony/modules/auth/widgets/custom_login_button.widget.dart';

import '../../../../../views/widgets/custome_outline_button.widget.dart';
import '../../../../../views/widgets/template_app_scaffold.widget.dart';

class SuccessfulDelivering extends StatelessWidget {
  const SuccessfulDelivering({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: Column(
        children: [
          Text(
            "Successful Delivering process",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            "The time and location of the pickup will be recorded automatically.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF929292),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, right: 18, left: 18),
            child: Column(
              children: [
                CustomLoginButton(
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
                CustomeOutlineButton(
                  title: Text(
                    'Back To Parcel List',
                    style: TextStyle(
                      color: Color(0xFF49159B),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
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
