import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class TerminalHeaderWidget extends StatelessWidget {
  const TerminalHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Terminal prompt line
        Row(
          children: [
            Text(
              '>',
              style: AppTheme.terminalTheme.textTheme.headlineSmall?.copyWith(
                color: AppTheme.primaryTerminal,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: Text(
                'GHOSTCHAT TERMINAL v1.0',
                style: AppTheme.terminalTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.primaryTerminal,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 2.h),

        // System info
        _buildSystemLine('SYSTEM: ANONYMOUS MESSAGING PROTOCOL'),
        _buildSystemLine('STATUS: AWAITING USER IDENTIFICATION'),
        _buildSystemLine('SECURITY: EPHEMERAL SESSION ACTIVE'),

        SizedBox(height: 3.h),

        // Main prompt
        Row(
          children: [
            Text(
              '>',
              style: AppTheme.terminalTheme.textTheme.headlineSmall?.copyWith(
                color: AppTheme.primaryTerminal,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: Text(
                'ENTER ANONYMOUS HANDLE:',
                style: AppTheme.terminalTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.primaryTerminal,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSystemLine(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0.5.h),
      child: Text(
        text,
        style: AppTheme.terminalTheme.textTheme.bodySmall?.copyWith(
          color: AppTheme.textMediumEmphasisTerminal,
          fontSize: 11.sp,
        ),
      ),
    );
  }
}
