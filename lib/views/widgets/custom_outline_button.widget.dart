import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {

  final Widget title;
  final VoidCallback? onTap;

  const CustomOutlineButton({super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(

        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(
            width: 2,
            color: Color(0xFF49159B),
          ),

          // shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          overlayColor: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child:  title,
        ),
      ),
    );
  }
}
