/* import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../services/size_config.dart';

class BoxChoice extends StatelessWidget {
  final String svgPath;
  final String title;
  final VoidCallback onTap;
  final bool isSelected;
  const BoxChoice({
    super.key,
    required this.svgPath,
    required this.title,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize SizeConfig to use responsive sizing
    SizeConfig.init(context);
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: SizeConfig.heightPercent(0.16),
          decoration: BoxDecoration(
            color: Color(0xFFf4f4f4),
            border: Border.all(
              color: isSelected ? Color(0xFF49159B) : Color(0xFFf4f4f4),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                svgPath,
                color: Color(0xFF49159B),

                /* width: 32,
                                height: 32, */
                //color: ,
              ),
              SizedBox(height: SizeConfig.heightPercent(0.02)),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF49159B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../services/size_config.dart';

class BoxChoice extends StatelessWidget {
  final String svgPath;
  final String title;
  final VoidCallback onTap;
  final bool isSelected;

  const BoxChoice({
    super.key,
    required this.svgPath,
    required this.title,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          height: SizeConfig.heightPercent(0.16),
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: isSelected ? Color(0xFF49159B) : Color(0xFFDADADA),
              width: isSelected ? 2 : 1,
            ),
            boxShadow:
                isSelected
                    ? [
                      BoxShadow(
                        color: Color(0xFF49159B).withOpacity(0.3),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ]
                    : [],
            borderRadius: BorderRadius.circular(24),
          ),
          child: AnimatedScale(
            duration: Duration(milliseconds: 300),
            scale: isSelected ? 1.05 : 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  svgPath,
                  color: Color(0xFF49159B),
                  width: 32,
                  height: 32,
                ),
                SizedBox(height: SizeConfig.heightPercent(0.02)),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF49159B),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
