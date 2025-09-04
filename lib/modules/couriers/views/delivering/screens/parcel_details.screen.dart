import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              SecondaryAppBar(title: 'Parcel Details'),

              const SizedBox(height: 24),

              Container(
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
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF6B46C1),
                      ),
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

            ],
          ),
        ),
      ),
    );
  }
}
