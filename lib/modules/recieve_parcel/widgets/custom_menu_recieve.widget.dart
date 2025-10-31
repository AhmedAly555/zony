/*
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuItemData {
  final String svgPath;
  final String title;
  final VoidCallback onTap;

  MenuItemData({required this.svgPath, required this.title, required this.onTap});
}

class CustomMenuRecieve extends StatefulWidget {
  final List<MenuItemData> items;

  const CustomMenuRecieve({super.key, required this.items});

  @override
  State<CustomMenuRecieve> createState() => _CustomMenuRecieveState();
}

class _CustomMenuRecieveState extends State<CustomMenuRecieve> {
  int selectedIndex = -1;

  void _onMenuItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.items[index].onTap();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.items.length, (index) {
          final item = widget.items[index];
          return Padding(
            padding: EdgeInsets.only(
              bottom: index < widget.items.length - 1 ? 12 : 0,
            ),
            child: BuildMenuItem(
              index: index,
              svgPath: item.svgPath,
              title: item.title,
              isSelected: selectedIndex == index,
              onTap: _onMenuItemTapped,
            ),
          );
        }),
      ),
    );
  }
}

class BuildMenuItem extends StatelessWidget {
  final int index;
  final String svgPath;
  final String title;
  final bool isSelected;
  final void Function(int) onTap;

  const BuildMenuItem({
    super.key,
    required this.index,
    required this.svgPath,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F4FF),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF49159B) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
              color: Theme.of(context).primaryColor,
              width: 32,
              height: 32,

            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuItemData {
  final String svgPath;
  final String title;
  final VoidCallback onTap;

  MenuItemData({
    required this.svgPath,
    required this.title,
    required this.onTap,
  });
}

class CustomMenuRecieve extends StatefulWidget {
  final List<MenuItemData> items;

  const CustomMenuRecieve({super.key, required this.items});

  @override
  State<CustomMenuRecieve> createState() => _CustomMenuRecieveState();
}

class _CustomMenuRecieveState extends State<CustomMenuRecieve> {
  int selectedIndex = -1;

  void _onMenuItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.items[index].onTap();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.items.length, (index) {
          final item = widget.items[index];
          return Padding(
            padding: EdgeInsets.only(
              bottom: index < widget.items.length - 1 ? 12 : 0,
            ),
            child: BuildMenuItem(
              index: index,
              svgPath: item.svgPath,
              title: item.title,
              isSelected: selectedIndex == index,
              onTap: _onMenuItemTapped,
            ),
          );
        }),
      ),
    );
  }
}

class BuildMenuItem extends StatefulWidget {
  final int index;
  final String svgPath;
  final String title;
  final bool isSelected;
  final void Function(int) onTap;

  const BuildMenuItem({
    super.key,
    required this.index,
    required this.svgPath,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<BuildMenuItem> createState() => _BuildMenuItemState();
}

class _BuildMenuItemState extends State<BuildMenuItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.06,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
  }

  @override
  void didUpdateWidget(BuildMenuItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected && !oldWidget.isSelected) {
      _controller.forward();
    } else if (!widget.isSelected && oldWidget.isSelected) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(widget.index),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F4FF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color:
                  widget.isSelected
                      ? const Color(0xFF49159B)
                      : Colors.transparent,
              width: 2,
            ),
            boxShadow:
                widget.isSelected
                    ? [
                      BoxShadow(
                        color: const Color(0xFF49159B).withOpacity(0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                    : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                widget.svgPath,
                color: Theme.of(context).primaryColor,
                width: 32,
                height: 32,
              ),
              const SizedBox(width: 12),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
