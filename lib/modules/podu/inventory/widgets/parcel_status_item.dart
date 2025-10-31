import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ParcelStatusItem extends StatefulWidget {
  final String iconPath;
  final String title;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  const ParcelStatusItem({
    super.key,
    required this.iconPath,
    required this.title,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<ParcelStatusItem> createState() => _ParcelStatusItemState();
}

class _ParcelStatusItemState extends State<ParcelStatusItem>
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

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
  }

  @override
  void didUpdateWidget(ParcelStatusItem oldWidget) {
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
    final borderColor =
    widget.isSelected ? const Color(0xFF49159B) : Colors.transparent;

    return GestureDetector(
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF4F4F4),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: borderColor, width: 1.5),
            boxShadow: widget.isSelected
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                widget.iconPath,
                width: 32,
                height: 32,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF49159B),
                  BlendMode.srcIn,
                ),
              ),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF1E1E1E),
                ),
              ),
              Text(
                "(${widget.count})",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
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
