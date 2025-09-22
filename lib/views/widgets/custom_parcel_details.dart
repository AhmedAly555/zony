import 'package:flutter/material.dart';

import '../../modules/couriers/delivering/widgets/parcel_row.widget.dart';
import '../../theme/app_text_styles.dart';

class CustomParcelDetails extends StatelessWidget {
  const CustomParcelDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset('assets/images/2057.jpg',
            ),
          ),

          const SizedBox(height: 24),

          // Product info text
          const Text(
            'Product info',
            style: AppTextStyles.textStyle16LightPurple,
          ),

          const SizedBox(height: 18),

          // Info items
          InfoItem(
            svgPath: 'assets/svgs/profile_icon_with_background.svg',
            text: 'Cameron Williamson',
          ),
          const SizedBox(height: 12),
          InfoItem(
            svgPath: 'assets/svgs/location_icon_with_background.svg',
            text: '4140 Parker Rd, Allentown, New Mexico',
          ),
          const SizedBox(height: 12),
          InfoItem(
            svgPath: 'assets/svgs/call_icon_with_background.svg',
            text: '(205) 555-0100',
          ),
        ],
      ),
    );
  }
}
