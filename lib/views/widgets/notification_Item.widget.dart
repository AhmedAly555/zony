import 'package:flutter/material.dart';
class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const NotificationItem({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        color: notification.isRead ? Colors.grey[100] : Colors.white,
        child: Row(
          children: [
            // الدائرة الرمادية مع الأيكون
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.info_outline,
                color: Colors.grey,
                size: 20,
              ),
            ),

            const SizedBox(width: 12),

            // النص (Title & Subtitle)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // الوقت في الشمال
            Text(
              notification.time,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// موديل النوتيفيكيشن
class NotificationModel {
  final int id;
  final String title;
  final String subtitle;
  final String time;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.isRead,
  });

  NotificationModel copyWith({
    int? id,
    String? title,
    String? subtitle,
    String? time,
    bool? isRead,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      time: time ?? this.time,
      isRead: isRead ?? this.isRead,
    );
  }
}