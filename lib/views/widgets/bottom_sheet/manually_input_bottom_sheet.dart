import 'package:flutter/material.dart';
import 'package:zony/generated/l10n.dart';

import '../../../services/size_config.dart';
import '../../../theme/app_text_styles.dart';
import '../bottom_sheet_container.dart';
import 'componants_bottom_sheet.widgets.dart';

class ManuallyInputBottomSheet extends StatefulWidget {
  final Function(String) onConfirm;

  const ManuallyInputBottomSheet({super.key, required this.onConfirm});

  @override
  State<ManuallyInputBottomSheet> createState() =>
      _ManuallyInputBottomSheetState();
}

class _ManuallyInputBottomSheetState extends State<ManuallyInputBottomSheet> {
  final TextEditingController _inputController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _inputController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      _isButtonEnabled = _inputController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
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
            const HederBottomSheetLine(),
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
                S.of(context).codeNumber, // Using a more generic term
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF1E1E1E),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _inputController,
              decoration: InputDecoration(
                hintText: S.of(context).pleaseEnterUsernameHere,
                // Re-using for now
                hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF49159B)),
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
                  width: double.infinity,
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
                          const Color(0xFFF4F4F4),
                          1 - value,
                        )!,
                      ],
                      stops: [0.0, value.clamp(0.0, 1.0)],
                    ),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap:
                    _isButtonEnabled
                        ? () {
                      widget.onConfirm(_inputController.text.trim());
                    }
                        : null,
                    child: Center(
                      child: Text(
                        S.of(context).confirm,
                        style: TextStyle(
                          color:
                          value > 0.5
                              ? Colors.white
                              : Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),


            /*ElevatedButton(
              onPressed:
                  _isButtonEnabled
                      ? () {
                        widget.onConfirm(_inputController.text.trim());
                      }
                      : null,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
                backgroundColor: const Color(0xFF49159B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ).copyWith(
                backgroundColor: MaterialStateProperty.resolveWith<Color?>((
                  Set<MaterialState> states,
                ) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.grey;
                  }
                  return const Color(
                    0xFF49159B,
                  ); // Use the component's default color
                }),
              ),
              child: Text(
                S.of(context).confirm,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),*/
            const Padding(padding: EdgeInsets.symmetric(vertical: 22)),
          ],
        ),
      ),
    );
  }
}

// Helper function to show the bottom sheet
Future<String?> showManuallyInputBottomSheet(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      SizeConfig.init(context);
      return Container(
        constraints: BoxConstraints(
          maxHeight: SizeConfig.heightPercent(0.70),
          minHeight: SizeConfig.heightPercent(0.50),
        ),
        child: IntrinsicHeight(
          child: ManuallyInputBottomSheet(
            onConfirm: (String value) {
              Navigator.of(context).pop(value);
            },
          ),
        ),
      );
    },
  );
}
