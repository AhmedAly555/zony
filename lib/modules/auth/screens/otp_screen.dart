import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zony/modules/couriers/views/screens/main_home/screen/main_home_screen.dart';

import '../../../services/navigator.services/app_navigator.services.dart';
import '../../../services/size_config.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_login_button.widget.dart';
import 'generic_login_screen.dart';

class OTPScreen extends StatefulWidget {

  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final List<TextEditingController> _controllers =
  List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes =
  List.generate(6, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  Widget _buildOTPField(int index) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(
          color: _controllers[index].text.isNotEmpty
              ? const Color(0xFF7C3AED)
              : const Color(0xFFD1D5DB),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
        color: _controllers[index].text.isNotEmpty
            ? const Color(0xFFF3E8FF)
            : const Color(0xFFF9FAFB),
      ),
      child: TextFormField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: _controllers[index].text.isNotEmpty
              ? const Color(0xFF7C3AED)
              : const Color(0xFF9CA3AF),
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: '-',
          hintStyle: TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 18,
          ),
        ),
        onChanged: (value) {
          setState(() {
            _onChanged(value, index);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return GenericLoginScreen(
      height: SizeConfig.heightPercent(0.47),

      appBar: CustomAppbar(title: 'Authentication Code'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Enter the verification code',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
            ),
            //textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            'We have sent the verification code to your email/phone. Enter the code to continue.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
              height: 1.5,
            ),
            //textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Divider(height: 1, color: Color(0xFFF4F4F4)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(6, (index) => _buildOTPField(index)),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Didn't receive the code? ",
                style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
              ),
              GestureDetector(
                onTap: () => print('Resend code tapped'),
                child: const Text(
                  'Resend it',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF7C3AED),
                    fontWeight: FontWeight.w600,
                    //decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: CustomLoginButton(
              onTap: () {
                AppNavigator.navigateTo(
                  context,
                      () =>  const MainHomeScreen(),
                );
              },
              child:
              const  Text(
                'Verify the code',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}