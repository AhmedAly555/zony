import 'dart:io';

import 'package:flutter/material.dart';

import '../../../modules/auth/screens/login_screen.dart';
import '../../../theme/app_text_styles.dart';
import '../bottom_sheet_container.dart';
import '../default_button.widget.dart';
import '../../../services/navigator.services/app_navigator.services.dart';
import '../custom_outline_button.widget.dart';
import 'componants_bottom_sheet.widgets.dart';

class PhotoConfirmarionBottomSheet extends StatelessWidget {
  final File imageFile;

  final VoidCallback onConfirm;

  const PhotoConfirmarionBottomSheet({super.key, required this.imageFile, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar line
          HederBottomSheetLine(),

          Spacer(),

          // icon
          //BottomSheetIcon(svgPath: 'assets/svgs/check_icon.svg'),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),

            child: Image.file(imageFile, fit: BoxFit.contain),),

          const SizedBox(height: 16),

          // Title
          const Text(
            'PHOTO CONFIRMATION',
            textAlign: TextAlign.center,
            style: AppTextStyles.bottomSheetTitle,
          ),

          /*const SizedBox(height: 8),
          // Description
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod',
            textAlign: TextAlign.center,
            style: AppTextStyles.bottomSheetDescription,
          ),*/
          Spacer(),

          Row(
            children: [
              Expanded(
                child: DefaultButton(
                  onTap:
                      () {
                    onConfirm();
                    //Navigator.pop(context);
                    },
                  child: Text(
                    'Yes, I\'m Confirm.',
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
                  title: Text(
                    'TRY AGAIN',
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

//callback function to show bottom sheet
/*
void showPhotoConfirmarionBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        SizeConfig.init(context);
        return Container(
          constraints: BoxConstraints(
            maxHeight: SizeConfig.heightPercent(0.75),
            minHeight: SizeConfig.heightPercent(0.45),
          ),
          child: IntrinsicHeight(
            child: PhotoConfirmarionBottomSheet(),
          ),
        );
      },

    );
  }
*/
