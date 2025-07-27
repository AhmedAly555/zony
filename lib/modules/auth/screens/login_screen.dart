import 'package:flutter/material.dart';

import '../../../services/navigator.services/app_navigator.services.dart';
import '../../../services/size_config.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_login_button.widget.dart';
import '../widgets/password_text_field.widget.dart';
import '../widgets/username_text_field.widget.dart';
import 'change_password.dart';
import 'generic_login_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GenericLoginScreen(
      appBar: CustomAppbar(),
      height: SizeConfig.heightPercent(0.52),
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

          const SizedBox(height: 20.0),
          const Text(
            'Password',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8.0),
          PasswordTextField(),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 24.0,
                height: 24.0,
                child: Checkbox(
                  value: _rememberMe,
                  onChanged: (bool? newValue) {
                    setState(() {
                      _rememberMe = newValue!;
                    });
                  },
                  activeColor: Colors.deepPurple,
                  checkColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),

              const Text(
                'Remember me',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xFF92929D),
                  fontWeight: FontWeight.w400,
                ),
              ),
              //const Spacer(),
              TextButton(
                onPressed: () {AppNavigator.navigateTo(context, () => const ChangePasswordScreen());},
                child: const Text(
                  'Forgot Password',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
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
