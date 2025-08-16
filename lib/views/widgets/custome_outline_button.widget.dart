import 'package:flutter/material.dart';

class CustomeOutlineButton extends StatelessWidget {
  const CustomeOutlineButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      onPressed: (){},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(
          width: 2,
          color: Color(0xFF49159B),
        ),

        // shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: const Text(
          'No, cancel',
          style: TextStyle(
            color: Color(0xFF49159B),
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
