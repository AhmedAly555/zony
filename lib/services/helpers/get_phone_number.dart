import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../views/widgets/toasts.dart';

class GetPhoneNumber {
  static Future<void> makePhoneCall(BuildContext context, String? phoneNumber) async {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      showErrorToast(message: 'Phone number is missing');
      /*ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('رقم الهاتف غير متوفر')),
      );*/
      return;
    }

    // Remove any spaces or non-numeric characters from the phone number
    final cleanedNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    final Uri phoneUri = Uri(scheme: 'tel', path: cleanedNumber);

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        if (context.mounted) {
          /*ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('لا يمكن فتح تطبيق الاتصال')),
          );*/
          showErrorToast(message: 'can not open phone app');

        }
      }
    } catch (e) {
      if (context.mounted) {
        /*ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ: $e')),
        );*/
        //print('Error: $e');
      }
    }
  }
}