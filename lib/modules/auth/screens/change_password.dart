import 'package:flutter/material.dart';

import '../../../core/services/size_config.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_login_button.widget.dart';
import '../widgets/password_text_field.widget.dart';
import 'generic_login_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GenericLoginScreen(
      height: SizeConfig.heightPercent(0.55),
      appBar: CustomAppbar(title: 'Change Your Password'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Change Your Password',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 3),
          Divider(height: 1, color: Color(0xFFF4F4F4)),
          SizedBox(height: 12),
          const Text(
            'Current password',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
          //const SizedBox(height: 3.0),
          PasswordTextField(hintText: 'Enter Current Password'),
          SizedBox(height: 12),
          const Text(
            'New password',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
          //const SizedBox(height: 8.0),
          PasswordTextField(hintText: 'Enter New Password'),
          SizedBox(height: 12),
          const Text(
            'Confirm password',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
          //const SizedBox(height: 8.0),
          PasswordTextField(),
          SizedBox(height: 20),

          TweenAnimationBuilder<double>(
            tween: Tween<double>(
              begin: 0.0,
              end: 1.0,
              /* (_selectedIndex == 0 || _selectedIndex == 1)
                      ? 1.0
                      : 0.0, */
            ),
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
            builder: (context, value, child) {
              return Container(
                width: double.infinity,
                height: SizeConfig.heightPercent(0.07), //52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color(0xFF49159B),
                      Color.lerp(
                        Color(0xFF49159B),
                        Color(0xFFF4F4F4),
                        1 - value,
                      )!,
                    ],
                    stops: [0.0, value.clamp(0.0, 1.0)],
                  ),
                ),
                child: CustomLoginButton(onTap: () {}),
              );
            },
          ),
        ],
      ),
    );
  }
}
