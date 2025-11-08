import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 7.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Color(0xFFdbd0eb),
              ),
              child: SvgPicture.asset(
                'assets/svgs/delivering.svg',
                width: 22,
                height: 24,
                color: Color(0xFF49159B),
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