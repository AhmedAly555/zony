import 'package:flutter/material.dart';

import '../../../services/size_config.dart';
import '../../../theme/app_text_styles.dart';
import '../../../views/widgets/bottom_sheet/confirm_parcel_bottom_sheet.dart';
import '../../../views/widgets/circler_icon.dart';
import '../../../views/widgets/custom_parcel_details.dart';
import '../../../views/widgets/default_button.widget.dart';
import '../../../views/widgets/secondary_appbar.dart';
import '../../../views/widgets/template_app_scaffold.widget.dart';
import '../../couriers/delivering/widgets/parcel_row.widget.dart';
import '../views/widgets/not_found.widget.dart';
import '../views/widgets/parcel_states.widget.dart';
import '../views/widgets/total_parcels_approved.widget.dart';

class ParcelApproveScreen extends StatelessWidget {
  const ParcelApproveScreen({super.key});

  void showConfirmParcelBottomSheet(BuildContext context) {
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
            maxHeight: SizeConfig.heightPercent(0.45),
            minHeight: SizeConfig.heightPercent(0.35),
          ),
          child: IntrinsicHeight(
            child: ConfirmParcelBottomSheet(),
          ),
        );
      },

    );
  }

  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
          child: Column(
            children: [
              SecondaryAppBar(title: 'Parcel Approve'),
          
              const SizedBox(height: 24),

              TotalParcelsApproved(),

              const SizedBox(height: 24),

              CustomParcelDetails(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CirclerIcon(svgPath: 'assets/svgs/barcode_icon.svg',),
                      const SizedBox(width: 13),
                      Text('#1234',
                      style: AppTextStyles.textStyle16,
                      ),
                      const Spacer(),
                      PendingWidget(),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Divider(
                    color: Color(0xFFF4F4F4),
                    thickness: 1,
                  ),
                  const SizedBox(height: 24),
                  ImageContainer(),
          
                  const SizedBox(height: 24),
          
                  // Product info text
                  const Text(
                    'Product info',
                    style: AppTextStyles.textStyle16LightPurple,
                  ),
          
                  const SizedBox(height: 18),
          
                  // Info items
                  InfoItem(
                    svgPath: 'assets/svgs/barcode_with_background.svg',
                    text: '#123456',
                  ),
                  const SizedBox(height: 12),
                  InfoItem(
                    svgPath: 'assets/svgs/calender_with_background.svg',
                    text: '12 May ,2025 - 12:32 pm',
                  ),
                  const SizedBox(height: 12),
                  InfoItem(
                    svgPath: 'assets/svgs/call_icon_with_background.svg',
                    text: '(205) 555-0100',
                  ),
                  SizedBox(height: 30,),
                  DefaultButton(onTap: () {
                    showConfirmParcelBottomSheet(context);
                  },
                    child: Text('Confirm Parcel', style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFFFFFFF),
                    ),),
                  ),
                ],
              ),),

              /*NotFoundWidget(),*/
          
          
            ],
          ),
        ),
      ),
    );
  }
}
