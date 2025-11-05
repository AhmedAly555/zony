import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zony/views/widgets/default_appbar.dart';

import '../../../../services/size_config.dart';
import '../../../../views/widgets/bottom_sheet/pickup_point_bottom_sheet.dart';
import '../../../../views/widgets/template_app_scaffold.widget.dart';

class AllPODUsScreen extends StatelessWidget {
  const AllPODUsScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarHaveArrow(title: 'My PODUs'),
              SizedBox(height: 28,),
              // Search Row with TextField and Map Button
              Row(
                children: [
                  // Search TextField
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'All Parcels',
                        prefixIcon: Icon(Icons.search, color: Color(0xFF49159B),size: 24,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  // Map Button
                  GestureDetector(
                    onTap: (){
                      showPickupPointBottomSheet(context);
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFF49159B),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SvgPicture.asset(
                        'assets/svgs/podus_location.svg',
                        //color: Theme.of(context).primaryColor,
                        width: 24,
                        height: 24,

                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24,),
              // Container with notifications
              Container(
                //margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Unread Text
                    Text(
                      'Unread',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),

                    // Divider
                    Divider(
                      color: Color(0xFFF4F4F4),
                      //color: Colors.black,
                      thickness: 1,
                    ),
                    SizedBox(height: 8),

                    // Notifications List
                    Column(
                      children: [
                        NotificationItem(
                          title: 'PODU Giza',
                          subtitle: 'Your shipment has been successfully received',
                          time: '3:14 PM',
                        ),
                        NotificationItem(
                          title: 'PODU Giza',
                          subtitle: 'Your shipment has been successfully received',
                          time: '3:14 PM',
                        ),
                        NotificationItem(
                          title: 'PODU Giza',
                          subtitle: 'Your shipment has been successfully received',
                          time: '3:14 PM',
                        ),
                        NotificationItem(
                          title: 'PODU Giza',
                          subtitle: 'Your shipment has been successfully received',
                          time: '3:14 PM',
                        ),
                        NotificationItem(
                          title: 'PODU Giza',
                          subtitle: 'Your shipment has been successfully received',
                          time: '3:14 PM',
                        ),
                        NotificationItem(
                          title: 'PODU Giza',
                          subtitle: 'Your shipment has been successfully received',
                          time: '3:14 PM',
                        ),
                        NotificationItem(
                          title: 'PODU Giza',
                          subtitle: 'Your shipment has been successfully received',
                          time: '3:14 PM',
                          isLast: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final bool isLast;

  const NotificationItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // Green circle indicator
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 12),

            // Grey circle with icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.info_outline,
                color: Colors.grey[600],
                size: 20,
              ),
            ),
            SizedBox(width: 12),

            // Title and subtitle column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Time
            Text(
              time,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Divider(
            color: Color(0xFFF4F4F4),
            //color: Colors.black,
            thickness: 1,
          ),
        ),
        //if (!isLast) SizedBox(height: 16),
      ],
    );
  }
}