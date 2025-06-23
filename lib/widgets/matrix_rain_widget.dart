import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../theme/app_theme.dart';

class MatrixRainWidget extends StatefulWidget {
  final double opacity;
  final bool isActive;

  const MatrixRainWidget({
    super.key,
    this.opacity = 0.1,
    this.isActive = true,
  });

  @override
  State<MatrixRainWidget> createState() => _MatrixRainWidgetState();
}

class _MatrixRainWidgetState extends State<MatrixRainWidget> {
  late Timer _timer;
  final List<MatrixColumn> _columns = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _initializeColumns();
    _startAnimation();
  }

  void _initializeColumns() {
    final columnCount =
        (100.w / 12).floor(); // Approximately 12 units per column
    for (int i = 0; i < columnCount; i++) {
      _columns.add(MatrixColumn(
        x: i * 12.0,
        speed: _random.nextDouble() * 2 + 1,
        length: _random.nextInt(20) + 10,
      ));
    }
  }

  void _startAnimation() {
    if (widget.isActive) {
      _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
        if (mounted) {
          setState(() {
            for (var column in _columns) {
              column.update();
            }
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isActive) return Container();

    return Positioned.fill(
      child: Opacity(
        opacity: widget.opacity,
        child: CustomPaint(
          painter: MatrixRainPainter(_columns),
        ),
      ),
    );
  }
}

class MatrixColumn {
  double x;
  double y;
  double speed;
  int length;
  List<String> characters;

  MatrixColumn({
    required this.x,
    required this.speed,
    required this.length,
  })  : y = -length * 20.0,
        characters = _generateCharacters(length);

  static List<String> _generateCharacters(int length) {
    final chars =
        '01ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz@#\$%^&*()';
    final random = Random();
    return List.generate(length, (_) => chars[random.nextInt(chars.length)]);
  }

  void update() {
    y += speed;
    if (y > 100.h + length * 20) {
      y = -length * 20.0;
      characters = _generateCharacters(length);
    }
  }
}

class MatrixRainPainter extends CustomPainter {
  final List<MatrixColumn> columns;

  MatrixRainPainter(this.columns);

  @override
  void paint(Canvas canvas, Size size) {
    for (var column in columns) {
      for (int i = 0; i < column.characters.length; i++) {
        final alpha = (1.0 - (i / column.characters.length)).clamp(0.0, 1.0);
        final color = AppTheme.matrixGreen.withValues(alpha: alpha * 0.8);

        final textPainter = TextPainter(
          text: TextSpan(
            text: column.characters[i],
            style: TextStyle(
              color: i == 0 ? AppTheme.glowGreen : color,
              fontSize: 12,
              fontFamily: 'monospace',
              fontWeight: i == 0 ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          textDirection: TextDirection.ltr,
        );

        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(column.x, column.y + i * 20),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
