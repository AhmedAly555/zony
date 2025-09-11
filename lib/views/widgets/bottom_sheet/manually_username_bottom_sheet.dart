import 'dart:math' as math;

import 'package:flutter/material.dart';


import '../../../services/size_config.dart';
import 'componants_bottom_sheet.widgets.dart';

class ManuallyUsernameBottomSheet extends StatefulWidget {
  const ManuallyUsernameBottomSheet({super.key});

  @override
  State<ManuallyUsernameBottomSheet> createState() =>
      _ManuallyUsernameBottomSheetState();
}

class _ManuallyUsernameBottomSheetState
    extends State<ManuallyUsernameBottomSheet>
    with SingleTickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();

  final String _correctUsername = "ahmaly555";

  bool _isButtonEnabled = false;
  bool _hasError = false;

  late AnimationController _animationController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_onTextChanged);

    // إعداد الأنيميشن
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
      _isButtonEnabled = _usernameController.text.isNotEmpty;
      if (_hasError) _hasError = false;
    });
  }

  void _confirmUsername() {
    if (_usernameController.text == _correctUsername) {
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
    _usernameController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              HederBottomSheetLine(),
              const Spacer(),
              const Text(
                'Enter Manually',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Pickup Point Username',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF1E1E1E),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'Please Enter Username Here !',
                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
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
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Text(
                        'The username You Entered Is Not Valid',
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
                        child: const Text(
                          "Confirm",
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
      ),
    );
  }
}

//Show manually username bottom sheet(callback)
void showManuallyUsernameBottomSheet(BuildContext context) {
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
        child: IntrinsicHeight(child: ManuallyUsernameBottomSheet()),
      );
    },

  );
}