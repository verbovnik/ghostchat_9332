import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TerminalGlowWidget extends StatelessWidget {
  final Widget child;
  final bool enableGlow;
  final Color? glowColor;
  final double glowRadius;

  const TerminalGlowWidget({
    super.key,
    required this.child,
    this.enableGlow = true,
    this.glowColor,
    this.glowRadius = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    if (!enableGlow) return child;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color:
                (glowColor ?? AppTheme.primaryTerminal).withValues(alpha: 0.3),
            blurRadius: glowRadius,
            spreadRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}
