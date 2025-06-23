import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class TypingIndicatorWidget extends StatefulWidget {
  final List<String> typingUsers;

  const TypingIndicatorWidget({
    super.key,
    required this.typingUsers,
  });

  @override
  State<TypingIndicatorWidget> createState() => _TypingIndicatorWidgetState();
}

class _TypingIndicatorWidgetState extends State<TypingIndicatorWidget> {
  Timer? _animationTimer;
  int _dotCount = 0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  @override
  void dispose() {
    _animationTimer?.cancel();
    super.dispose();
  }

  void _startAnimation() {
    _animationTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          _dotCount = (_dotCount + 1) % 4;
        });
      }
    });
  }

  String _getDots() {
    return '.' * _dotCount;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.typingUsers.isEmpty) {
      return SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 1.h),
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Text(
        widget.typingUsers.length == 1
            ? '${widget.typingUsers.first}_TYPING${_getDots()}'
            : '${widget.typingUsers.length}_USERS_TYPING${_getDots()}',
        style: AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
          color: AppTheme.textMediumEmphasisTerminal,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
