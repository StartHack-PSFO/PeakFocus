import 'dart:math';
import 'package:flutter/material.dart';

class RotatingDotCircle extends StatefulWidget {
  final int countdown;

  RotatingDotCircle({required this.countdown});

  @override
  _RotatingDotCircleState createState() => _RotatingDotCircleState();
}

class _RotatingDotCircleState extends State<RotatingDotCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return CustomPaint(
          painter: CirclePainter(
            dotCount: 20,
            rotation: _animationController.value * 2 * pi,
            countdown: widget.countdown,
            context: context,
          ),
          child: child,
        );
      },
      child: Center(
        child: Text(
          widget.countdown.toString() + 's',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final int dotCount;
  final double rotation;
  final int countdown;
  final BuildContext context;

  CirclePainter(
      {required this.dotCount,
      required this.rotation,
      required this.countdown,
      required this.context});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;
    final angle = 2 * pi / dotCount;

    final paint = Paint()..color = Theme.of(context).colorScheme.primary;

    for (int i = 0; i < dotCount; i++) {
      final dotAngle = i * angle + rotation;
      final dotX = center.dx + radius * cos(dotAngle);
      final dotY = center.dy + radius * sin(dotAngle);
      final dotOffset = Offset(dotX, dotY);

      canvas.drawCircle(dotOffset, 4.0, paint);
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return oldDelegate.rotation != rotation ||
        oldDelegate.countdown != countdown;
  }
}
