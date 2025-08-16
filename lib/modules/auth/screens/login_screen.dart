import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // import the fluttertoast library

import '../../../services/auth_service.dart';
import '../../../services/navigator.services/app_navigator.services.dart';
import '../../../services/size_config.dart';
import '../../../views/widgets/default_text_filed.dart';
import '../../couriers/views/screens/main_home/screen/main_home_screen.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_login_button.widget.dart';
import 'change_password.dart';
import 'forget_password.screen.dart';
import 'generic_login_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final authService = AuthService();

  bool isLoading = false;
  // errorMessage is no longer needed since we're using toasts
  // String? errorMessage;

  // Function to handle login
  void handleLogin() async {
    setState(() {
      isLoading = true;
      // errorMessage is no longer needed
      // errorMessage = null;
    });

    try {
      final response = await authService.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      // If not, we stop execution to avoid using an invalid context.
      if (!mounted) return;

      // login success: Show a green toast
      Fluttertoast.showToast(
        msg: '✅ Login Successful',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      AppNavigator.navigateTo(context, () => const MainHomeScreen());

    } catch (e) {
      // login failed: Show a red toast
      Fluttertoast.showToast(
        msg: 'Failed to login', // Corrected the typo 'Filed' to 'Failed'
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
          DefaultTextField(
            controller: _passwordController,
            hintText: "Enter Password",
            fieldType: DefaultTextFieldType.password,
          ),
          SizedBox(height: 20),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              const Spacer(),
              TextButton(
                onPressed: () {
                  AppNavigator.navigateTo(
                    context,
                        () => const ForgetPasswordScreen(),
                  );
                },
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

          // The error message widget is no longer needed with toasts
          // if (errorMessage != null)
          //   Text(errorMessage!, style: const TextStyle(color: Colors.red)),
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
                child: CustomLoginButton(
                  onTap: () => isLoading ? null : handleLogin(),
                  child:
                  isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
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

