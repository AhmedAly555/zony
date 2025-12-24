import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zony/generated/l10n.dart';

class DefaultNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const DefaultNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<Map<String, dynamic>> _icons = [
    {
      'path': 'assets/svgs/home.svg',
      'width': 24.0,
      'height': 24.0,
    },
    {
      'path': 'assets/svgs/receiving.svg',
      'width': 24.0,
      'height': 24.0,
    },
    {
      'path': 'assets/svgs/delivering.svg',
      'width': 22.0,
      'height': 22.0,
    },
    {
      'path': 'assets/svgs/more.svg',
      'width': 18.0,
      'height': 18.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final List<String> labels = [
      S.of(context).home,
      S.of(context).receiving,
      S.of(context).delivering,
      S.of(context).more,
    ];

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 25,
            blurRadius: 30,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF49159B),
          unselectedItemColor: const Color(0xFF929292),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          items: List.generate(_icons.length, (index) {
            final bool isSelected = currentIndex == index;
            final iconData = _icons[index];
            return BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  transform: Matrix4.translationValues(
                    0.0,
                    isSelected ? -4.0 : 0.0,
                    0.0,
                  ),
                  child: Opacity(
                    opacity: isSelected ? 1.0 : 0.7,
                    child: SvgPicture.asset(
                      iconData['path'] as String,
                      colorFilter: ColorFilter.mode(
                        isSelected ? const Color(0xFF49159B) : const Color(0xFF929292),
                        BlendMode.srcIn,
                      ),
                      width: iconData['width'] as double,
                      height: iconData['height'] as double,
                    ),
                  ),
                ),
              ),
              label: labels[index],
            );
          }),
        ),
      ),
    );
  }
}
