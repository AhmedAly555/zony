import 'package:flutter/material.dart';

import '../../delivering/widgets/parcel_row.widget.dart';

class PODUDetails extends StatefulWidget {
  const PODUDetails({super.key});

  @override
  State<PODUDetails> createState() => _PODUDetailsState();
}

class _PODUDetailsState extends State<PODUDetails> {
  int selectedImageIndex = 0;

  final List<String> liveLocationImages = [
    'assets/images/warehouse1.jpg',
    'assets/images/warehouse2.jpg',
    'assets/images/warehouse3.jpg',
    'assets/images/warehouse4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          // Customer Info Container
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
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Customer Info',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF49159B),
                  ),
                ),
                SizedBox(height: 18),
                InfoItem(
                  svgPath: 'assets/svgs/profile_icon_with_background.svg',
                  text: 'Cameron Williamson',
                ),
                SizedBox(height: 16),
                InfoItem(
                  svgPath: 'assets/svgs/location_icon_with_background.svg',
                  text: '4140 Parker Rd. Allentown, New Mexico',
                ),
                SizedBox(height: 16),
                InfoItem(
                  svgPath: 'assets/svgs/call_icon_with_background.svg',
                  text: '(205) 555-0100',
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // Live Location Container
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
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Live Location',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFF4F4F4), thickness: 1),
                const SizedBox(height: 16),

                // Main Image
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.grey[200],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      liveLocationImages[selectedImageIndex],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.warehouse,
                                  size: 50, color: Colors.grey[600]),
                              const SizedBox(height: 8),
                              Text(
                                'Warehouse Image',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Thumbnail Images
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    liveLocationImages.length,
                        (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedImageIndex = index;
                        });
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: selectedImageIndex == index
                                ? const Color(0xFF6B46C1)
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            liveLocationImages[index],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: Icon(
                                  Icons.warehouse,
                                  color: Colors.grey[600],
                                  size: 30,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}