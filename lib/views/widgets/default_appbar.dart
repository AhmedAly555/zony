import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarHaveArrow extends StatelessWidget {
  final String title;
  //final Widget? arrow;

  const  AppBarHaveArrow({
    super.key,
    required this.title, //this.arrow,
  });



  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              //shape: BoxShape.circle,
              borderRadius: BorderRadius.circular(12),
              /*boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                ),
              ],*/
            ),
            padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 14),
            child: SvgPicture.asset(
              'assets/svgs/arrow_back.svg',
              width: 10,
              height: 15,
              //color: const Color(0xFF49159B),
            ),
          ),
        ),
        const Spacer(),
         SizedBox(width: 16),
         Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}

class HomeAppBar extends StatelessWidget {
  final String title;
  //final Widget? arrow;

  const  HomeAppBar({
    super.key,
    required this.title, //this.arrow,
  });



  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

