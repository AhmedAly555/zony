import 'package:flutter/material.dart';

import '../../../services/size_config.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_login_button.widget.dart';
import '../widgets/password_text_field.widget.dart';
import '../widgets/username_text_field.widget.dart';
import 'generic_login_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});


  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GenericLoginScreen(

      height: SizeConfig.heightPercent(0.30),
      appBar: CustomAppbar(
        title: 'Forget Password',
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Enter your personal information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10),
          Divider(height: 1, color: Color(0xFFF4F4F4)),
          SizedBox(height: 20),
          UsernameTextField(),
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
