import 'package:flutter/material.dart';

class ScannerLine extends StatefulWidget {

  final double width;        // The width of the area where the line moves
  final double height;       // The height of the area where the line moves
  final Color color;         // The color of the scanning line
  final double lineHeight;   // The thickness of the scanning line
  final Duration duration;   // The duration for a full up-down cycle

  const ScannerLine({
    super.key,
    required this.width,
    required this.height,
    this.color = Colors.greenAccent,
    this.lineHeight = 4,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<ScannerLine> createState() => _ScannerLineState();
}

class _ScannerLineState extends State<ScannerLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0,
      end: widget.height - widget.lineHeight,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Stack(
            children: [
              Positioned(
                top: _animation.value,
                left: 0,
                right: 0,
                child: Container(
                  height: widget.lineHeight,
                  color: widget.color.withOpacity(0.8),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
