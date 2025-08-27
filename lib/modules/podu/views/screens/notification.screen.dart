import 'package:flutter/material.dart';

import '../../../../views/widgets/notification_Item.widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // fake data of notifications
  List<NotificationModel> notifications = [
    NotificationModel(
      id: 1,
      title: "PODU Riyadh",
      subtitle: "Shipment delivered successfully",
      time: "9:25 AM",
      isRead: false,
    ),
    NotificationModel(
      id: 2,
      title: "PODU Jeddah",
      subtitle: "Your parcel is out for delivery",
      time: "11:40 AM",
      isRead: true,
    ),
    NotificationModel(
      id: 3,
      title: "PODU Dammam",
      subtitle: "Package has arrived at hub",
      time: "2:05 PM",
      isRead: false,
    ),
    NotificationModel(
      id: 4,
      title: "PODU Mecca",
      subtitle: "Courier is on the way",
      time: "4:50 PM",
      isRead: false,
    ),
    NotificationModel(
      id: 5,
      title: "PODU Medina",
      subtitle: "Shipment picked up successfully",
      time: "7:30 PM",
      isRead: true,
    ),
  ];

  // function to mark a notification as read
  void _markAsRead(int id) {
    setState(() {
      notifications = notifications.map((notif) {
        if (notif.id == id) {
          return notif.copyWith(isRead: true);
        }
        return notif;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Notification',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E1E1E),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: ListView.separated(
          itemCount: notifications.length,
          separatorBuilder: (context, index) {
            // Divider مlogicا
            return Divider(height: 1, color: Color(0xFFF4F4F4));
          },
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return NotificationItem(
              notification: notification,
              onTap: () => _markAsRead(notification.id),
            );
          },
        ),
      ),
    );
  }
}
