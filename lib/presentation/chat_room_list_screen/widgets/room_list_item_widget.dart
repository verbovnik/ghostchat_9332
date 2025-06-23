import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class RoomListItemWidget extends StatelessWidget {
  final Map<String, dynamic> room;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const RoomListItemWidget({
    super.key,
    required this.room,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final bool isFull = room['isFull'] ?? false;
    final int participants = room['participants'] ?? 0;
    final int maxCapacity = room['maxCapacity'] ?? 0;
    final String roomId = room['id'] ?? '';
    final String lastActivity = room['lastActivity'] ?? '';

    return GestureDetector(
      onTap: isFull ? null : onTap,
      onLongPress: onLongPress,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        decoration: BoxDecoration(
          border: Border.all(
            color:
                isFull ? AppTheme.inactiveTerminal : AppTheme.primaryTerminal,
            width: 1.0,
          ),
          color: AppTheme.backgroundTerminal,
        ),
        child: Row(
          children: [
            // Terminal prompt symbol
            Text(
              '>',
              style: AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
                color: isFull
                    ? AppTheme.inactiveTerminal
                    : AppTheme.primaryTerminal,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 2.w),

            // Room info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        roomId,
                        style: AppTheme.terminalTheme.textTheme.bodyMedium
                            ?.copyWith(
                          color: isFull
                              ? AppTheme.inactiveTerminal
                              : AppTheme.primaryTerminal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        '[$participants/$maxCapacity]',
                        style: AppTheme.terminalTheme.textTheme.bodySmall
                            ?.copyWith(
                          color: isFull
                              ? AppTheme.errorTerminal
                              : AppTheme.textMediumEmphasisTerminal,
                        ),
                      ),
                      if (isFull) ...[
                        SizedBox(width: 2.w),
                        Text(
                          'FULL',
                          style: AppTheme.terminalTheme.textTheme.bodySmall
                              ?.copyWith(
                            color: AppTheme.errorTerminal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    'LAST_ACTIVITY: $lastActivity',
                    style: AppTheme.terminalTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textDisabledTerminal,
                    ),
                  ),
                ],
              ),
            ),

            // Status indicator
            Container(
              width: 1.w,
              height: 6.h,
              color: isFull ? AppTheme.errorTerminal : AppTheme.primaryTerminal,
            ),
          ],
        ),
      ),
    );
  }
}
