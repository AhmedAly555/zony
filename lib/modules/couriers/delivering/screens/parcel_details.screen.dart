import 'package:flutter/material.dart';

import '../../../../../theme/app_text_styles.dart';
import '../../../../../views/widgets/custom_parcel_details.dart';
import '../../../../../views/widgets/default_button.widget.dart';
import '../../../../../views/widgets/secondary_appbar.dart';
import '../../../../../views/widgets/template_app_scaffold.widget.dart';
import '../widgets/parcel_row.widget.dart';

class ParcelDetailsScreen extends StatelessWidget {
  const ParcelDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Column(
          children: [
            SecondaryAppBar(title: 'Parcel Details'),

            const SizedBox(height: 24),

            CustomParcelDetails(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
            ),
            Spacer(),
            DefaultButton(
              onTap: () {},
              child: Text(
                'Capture Parcel',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
