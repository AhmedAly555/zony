import 'package:flutter/material.dart';

import '../../../../../theme/app_text_styles.dart';
import '../../../../../views/widgets/custom_parcel_details.dart';
import '../../../../../views/widgets/default_button.widget.dart';
import '../../../../../views/widgets/secondary_appbar.dart';
import '../../../../../views/widgets/template_app_scaffold.widget.dart';

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

            CustomParcelDetails(),
            Spacer(),
            DefaultButton(onTap: () {},
            child: Text('Capture Parcel', style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFFFFFFFF),
            ),),
            ),

          ],
        ),
      ),
    );
  }
}
