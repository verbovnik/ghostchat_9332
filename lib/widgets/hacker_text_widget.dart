import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class HackerTextWidget extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration animationDuration;
  final bool autoStart;

  const HackerTextWidget({
    super.key,
    required this.text,
    this.style,
    this.animationDuration = const Duration(milliseconds: 2000),
    this.autoStart = true,
  });

  @override
  State<HackerTextWidget> createState() => _HackerTextWidgetState();
}

class _HackerTextWidgetState extends State<HackerTextWidget> {
  String _displayText = '';
  Timer? _timer;
  final Random _random = Random();
  final String _chars =
      '!@#\$%^&*()_+-=[]{}|;:,.<>?ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

  @override
  void initState() {
    super.initState();
    if (widget.autoStart) {
      _startHackerAnimation();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startHackerAnimation() {
    _displayText = '';
    int iterations = 0;
    const maxIterations = 30;

    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (iterations >= maxIterations) {
        setState(() {
          _displayText = widget.text;
        });
        timer.cancel();
        return;
      }

      setState(() {
        _displayText = '';
        for (int i = 0; i < widget.text.length; i++) {
          if (i < (iterations * widget.text.length / maxIterations)) {
            _displayText += widget.text[i];
          } else {
            _displayText += _chars[_random.nextInt(_chars.length)];
          }
        }
      });

      iterations++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayText,
      style: widget.style ??
          GoogleFonts.courierPrime(
            color: AppTheme.primaryTerminal,
            fontSize: 14,
          ),
    );
  }
}
