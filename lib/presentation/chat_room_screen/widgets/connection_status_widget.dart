import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class ConnectionStatusWidget extends StatelessWidget {
  final bool isConnected;

  const ConnectionStatusWidget({
    super.key,
    required this.isConnected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        border: Border.all(
          color:
              isConnected ? AppTheme.primaryTerminal : AppTheme.errorTerminal,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isConnected
                  ? AppTheme.primaryTerminal
                  : AppTheme.errorTerminal,
            ),
          ),
          SizedBox(width: 1.w),
          Text(
            isConnected ? 'ONLINE' : 'OFFLINE',
            style: AppTheme.terminalTheme.textTheme.bodySmall?.copyWith(
              color: isConnected
                  ? AppTheme.primaryTerminal
                  : AppTheme.errorTerminal,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
