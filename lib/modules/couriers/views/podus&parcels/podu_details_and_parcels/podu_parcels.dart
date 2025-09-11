import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../delivering/widgets/parcel_row.widget.dart';

class PODOParcels extends StatelessWidget {
  const PODOParcels({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
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
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        shape: BoxShape.circle,
                        //borderRadius: BorderRadius.circular(8),
                      ),
                      child: SvgPicture.asset(
                        'assets/svgs/bag_icon.svg',
                        color: Theme.of(context).primaryColor,
                        width: 19.5,
                        height: 22,

                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '2 Bag',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF49159B),
                            ),
                          ),
                          Text(
                            '# 568589',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF929292),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Color(0xFF16A34A),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'Recieved',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF16A34A),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Divider
                Divider(
                  color: Color(0xFFF4F4F4),
                  thickness: 1,
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
                  svgPath: 'assets/svgs/profile_icon_with_background.svg',
                  text: 'PODU: Rahmah Pharmacy',
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
    );
  }
}