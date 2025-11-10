import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:zony/generated/l10n.dart';


import '../../../services/size_config.dart';
import '../../../theme/app_text_styles.dart';
import '../bottom_sheet_container.dart';
import 'componants_bottom_sheet.widgets.dart';

class PasswordBottomSheet extends StatefulWidget {
  const PasswordBottomSheet({super.key});

  @override
  State<PasswordBottomSheet> createState() =>
      _PasswordBottomSheetState();
}

class _PasswordBottomSheetState
    extends State<PasswordBottomSheet>
    with SingleTickerProviderStateMixin {
  final TextEditingController _passwordController = TextEditingController();

  final String _correctUsername = "ahmaly555";

  bool _isButtonEnabled = false;
  bool _hasError = false;
  bool _isPasswordVisible = false;

  late AnimationController _animationController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_onTextChanged);

    // Animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _shakeAnimation = Tween<double>(
      begin: 0,
      end: 10,
    ).chain(CurveTween(curve: Curves.elasticIn)).animate(_animationController);
  }

  void _onTextChanged() {
    setState(() {
      _isButtonEnabled = _passwordController.text.isNotEmpty;
      if (_hasError) _hasError = false;
    });
  }

  void _confirmUsername() {
    if (_passwordController.text == _correctUsername) {
      Navigator.pop(context);
    } else {
      setState(() {
        _hasError = true;
      });
      // vibration
      _animationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: BottomSheetContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            HederBottomSheetLine(),
            const Spacer(),
            Text(
              "Enter your Password",
              textAlign: TextAlign.center,
              style: AppTextStyles.bottomSheetTitle,
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Password",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF1E1E1E),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                hintText: "************",
                hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                suffixIcon: IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      VerticalDivider(
                        color: Colors.grey[300],
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: _hasError ? Colors.red : Colors.grey[300]!,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: _hasError ? Colors.red : Colors.grey[300]!,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: _hasError ? Colors.red : Color(0xFF49159B),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
            //Animated button
            if (_hasError)
              AnimatedBuilder(
                animation: _shakeAnimation,
                builder: (context, child) {
                  final t = _shakeAnimation.value;

                  final cycles = 1;
                  final maxOffset = 2.0;     //right & left distance
                  final angle = t * 2 * math.pi * cycles;

                  // Smooth
                  final dx = math.sin(angle) * maxOffset * (1 - t);

                  return Transform.translate(
                    offset: Offset(dx, 0),
                    child: child,
                  );
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Text(
                      S.of(context).usernameIsNotValid,
                      key: ValueKey('error-text'),
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            const Spacer(),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: 0.0,
                end: _isButtonEnabled ? 1.0 : 0.0,
              ),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Container(
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        const Color(0xFF49159B),
                        Color.lerp(
                          const Color(0xFF49159B),
                          Colors.grey,
                          1 - value,
                        )!,
                      ],
                      stops: [0.0, value.clamp(0.0, 1.0)],
                    ),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isButtonEnabled ? _confirmUsername : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        S.of(context).confirm,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const Padding(padding: EdgeInsets.only(bottom: 16)),
          ],
        ),
      ),
    );
  }
}

//Show manually username bottom sheet(callback)
void showPasswordBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      SizeConfig.init(context);
      return Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxHeight: SizeConfig.heightPercent(0.75),
          minHeight: SizeConfig.heightPercent(0.45),
        ),
        child: IntrinsicHeight(child: PasswordBottomSheet()),
      );
    },

  );
}
