import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class RoomTimerWidget extends StatelessWidget {
  final String remainingTime;

  const RoomTimerWidget({
    super.key,
    required this.remainingTime,
  });

  @override
  Widget build(BuildContext context) {
    // Parse remaining time to determine warning color
    final parts = remainingTime.split(':');
    final minutes = int.tryParse(parts[0]) ?? 0;
    final seconds = int.tryParse(parts[1]) ?? 0;
    final totalSeconds = minutes * 60 + seconds;

    Color timerColor = AppTheme.primaryTerminal;
    if (totalSeconds <= 300) {
      // 5 minutes warning
      timerColor = AppTheme.errorTerminal;
    } else if (totalSeconds <= 600) {
      // 10 minutes warning
      timerColor = AppTheme.warningTerminal;
    }

    return Text(
      'AUTO_DESTRUCT: $remainingTime',
      style: AppTheme.terminalTheme.textTheme.bodySmall?.copyWith(
        color: timerColor,
        fontSize: 10.sp,
      ),
    );
  }
}
