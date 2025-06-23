import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ScanLinesWidget extends StatefulWidget {
  final double opacity;
  final bool isActive;

  const ScanLinesWidget({
    super.key,
    this.opacity = 0.05,
    this.isActive = true,
  });

  @override
  State<ScanLinesWidget> createState() => _ScanLinesWidgetState();
}

class _ScanLinesWidgetState extends State<ScanLinesWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    if (widget.isActive) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isActive) return Container();

    return Positioned.fill(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Opacity(
            opacity: widget.opacity,
            child: CustomPaint(
              painter: ScanLinesPainter(_animation.value),
            ),
          );
        },
      ),
    );
  }
}

class ScanLinesPainter extends CustomPainter {
  final double animationValue;

  ScanLinesPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.scanlineGreen
      ..strokeWidth = 1;

    // Horizontal scan lines
    for (double y = 0; y < size.height; y += 4) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }

    // Moving scan line effect
    final movingY = animationValue * size.height;
    final glowPaint = Paint()
      ..color = AppTheme.glowGreen.withValues(alpha: 0.3)
      ..strokeWidth = 2;

    canvas.drawLine(
      Offset(0, movingY),
      Offset(size.width, movingY),
      glowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
