import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../services/auth_service.dart';
import '../../../services/navigator.services/app_navigator.services.dart';
import '../../../services/size_config.dart';
import '../../../views/widgets/default_text_filed.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_login_button.widget.dart';
import 'generic_login_screen.dart';
import 'otp_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final authService = AuthService();

  bool isLoading = false;

  void handleReset() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await authService.resetPassword(
        _emailController.text.trim(),
      );

      if (!mounted) return;

      Fluttertoast.showToast(
        msg: 'Valid email.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );

    } catch (e) {
      if (!mounted) return;

      Fluttertoast.showToast(
        msg: "Failed: Please check your email.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GenericLoginScreen(
      height: SizeConfig.heightPercent(0.35),
      appBar: CustomAppbar(title: 'Forget Password'),
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
          const Text(
            'username or phone number',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8.0),
          DefaultTextField(
            hintText: 'Enter Username Or Phone Number',
            controller: _emailController,
            fieldType: DefaultTextFieldType.email,
          ),
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
                height: SizeConfig.heightPercent(0.06), //52,
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
                child: CustomLoginButton(
                  onTap: () {
                    isLoading ? null : handleReset();
                    AppNavigator.navigateTo(
                      context,
                          () =>  const OTPScreen(),
                    );
                  },
                  child:
                  isLoading
                      ? const CircularProgressIndicator()
                      : const  Text(
                    'Confirm',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
