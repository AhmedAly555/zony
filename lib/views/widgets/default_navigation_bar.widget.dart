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

  static const List<String> _icons = [
    'assets/svgs/home.svg',
    'assets/svgs/receiving.svg',
    'assets/svgs/delivering.svg',
    'assets/svgs/more.svg',
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
                      _icons[index],

                      colorFilter: ColorFilter.mode(
                        isSelected ? const Color(0xFF49159B) : const Color(0xFF929292),
                        BlendMode.srcIn,
                      ),
                      width: 24,
                      height: 24,
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
