import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zony/generated/l10n.dart';

import '../../../modules/auth/screens/login_screen.dart';
import '../../../services/api_service.dart';
import '../../../services/get_res_pudos_service.dart';
import '../../../theme/app_text_styles.dart';
import '../bottom_sheet_container.dart';
import '../default_button.widget.dart';
import '../../../services/navigator.services/app_navigator.services.dart';
import '../custom_outline_button.widget.dart';
import '../toasts.dart';
import 'componants_bottom_sheet.widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LogOutBottomSheet extends StatefulWidget {
  const LogOutBottomSheet({super.key});

  @override
  State<LogOutBottomSheet> createState() => _LogOutBottomSheetState();
}

class _LogOutBottomSheetState extends State<LogOutBottomSheet> {
  bool isLoading = false;

  Future<void> _handleLogout() async {
    setState(() {
      isLoading = true;
    });

    try {
      await ApiService.clearUserData();
      await ResponsiblePudoService.instance.clearPudos();

      if (context.mounted) {
        AppNavigator.navigateAndRemoveUntil(context, () => const LoginScreen());
        Fluttertoast.showToast(
          msg: S.of(context).loggedOutSuccessfully,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xFF333333),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      if (context.mounted) {
        showErrorToast(
          message: S.of(context).anErrorOccurred + '${e.toString()}',
        );
      }
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
    return BottomSheetContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar line
          HederBottomSheetLine(),

          Spacer(),
          // Language icon
          BottomSheetIcon(svgPath: 'assets/svgs/logout.svg'),

          const SizedBox(height: 16),

          // Title
          Text(
            S.of(context).areYouSureYouWantToLogOut,
            textAlign: TextAlign.center,
            style: AppTextStyles.bottomSheetTitle,
          ),

          const SizedBox(height: 8),

          // Description
          Text(
            S.of(context).logOutDescription,
            textAlign: TextAlign.center,
            style: AppTextStyles.bottomSheetDescription,
          ),

          Spacer(),

          Row(
            children: [
              Expanded(
                child: DefaultButton(
                  onTap: () => isLoading ? null : _handleLogout(),
                  child:
                      isLoading
                          ? LoadingAnimationWidget.threeArchedCircle(
                            color: Colors.white,
                            size: 30,
                          )
                          : Text(
                            S.of(context).yesImSure,
                            textAlign: TextAlign.center,

                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: CustomOutlineButton(
                  onTap: () => Navigator.pop(context),
                  title: Text(
                    S.of(context).noCancel,
                    style: TextStyle(
                      color: Color(0xFF49159B),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(padding: const EdgeInsets.only(bottom: 16)),
        ],
      ),
    );
  }
}
