import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class TerminalHeaderWidget extends StatelessWidget {
  final bool isConnected;

  const TerminalHeaderWidget({
    super.key,
    required this.isConnected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppTheme.primaryTerminal,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'ACTIVE CHANNELS:',
            style: AppTheme.terminalTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Container(
                width: 2.w,
                height: 2.w,
                decoration: BoxDecoration(
                  color: isConnected
                      ? AppTheme.primaryTerminal
                      : AppTheme.errorTerminal,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 2.w),
              Text(
                isConnected ? 'ONLINE' : 'OFFLINE',
                style: AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
                  color: isConnected
                      ? AppTheme.primaryTerminal
                      : AppTheme.errorTerminal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
