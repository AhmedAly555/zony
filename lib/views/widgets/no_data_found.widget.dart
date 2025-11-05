import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignmen t.center,
      children: [
        /*Align(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                //shape: BoxShape.circle,
                borderRadius: BorderRadius.circular(12),
                *//*boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                  ),
                ],*//*
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
        ),*/
        //const Spacer(),
        SvgPicture.asset(
            'assets/svgs/not_found_icon.svg',
            height: 205,
            width: 185,
        ),
        const SizedBox(height: 32),
        const Text(
          'No Data Found',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF929292),
          ),
        ),
        //const Spacer(),

      ],
    );
  }
}
