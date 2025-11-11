import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:zony/generated/l10n.dart';


import '../../../services/size_config.dart';
import '../../../theme/app_text_styles.dart';
import '../bottom_sheet_container.dart';
import 'componants_bottom_sheet.widgets.dart';

class ManuallyUsernameBottomSheet extends StatefulWidget {
  final Function(String) onConfirm;

  const ManuallyUsernameBottomSheet({super.key, required this.onConfirm});

  @override
  State<ManuallyUsernameBottomSheet> createState() =>
      _ManuallyUsernameBottomSheetState();
}

class _ManuallyUsernameBottomSheetState
    extends State<ManuallyUsernameBottomSheet>
    with SingleTickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      _isButtonEnabled = _usernameController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
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
              S.of(context).enterManually,
              textAlign: TextAlign.center,
              style: AppTextStyles.bottomSheetTitle,
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).pickupPointUsername,
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
                hintText: S.of(context).pleaseEnterUsernameHere,
                hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.grey[300]!,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.grey[300]!,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Color(0xFF49159B),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
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
                      onPressed: _isButtonEnabled
                          ? () {
                              widget.onConfirm(_usernameController.text);
                              Navigator.pop(context);
                            }
                          : null,
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
void showManuallyUsernameBottomSheet(BuildContext context, {required Function(String) onConfirm}) {
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
        child: IntrinsicHeight(child: ManuallyUsernameBottomSheet(onConfirm: onConfirm)),
      );
    },

  );
}
