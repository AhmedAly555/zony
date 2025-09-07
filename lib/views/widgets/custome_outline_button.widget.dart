import 'package:flutter/material.dart';

class CustomeOutlineButton extends StatelessWidget {

  final Widget title;
  const CustomeOutlineButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(

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
          child:  title,
        ),
      ),
    );
  }
}
