import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EmptyStateWidget extends StatelessWidget {
  final VoidCallback onCreateRoom;
  final VoidCallback onJoinRoom;

  const EmptyStateWidget({
    super.key,
    required this.onCreateRoom,
    required this.onJoinRoom,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'chat_bubble_outline',
            color: AppTheme.inactiveTerminal,
            size: 64,
          ),
          SizedBox(height: 3.h),
          Text(
            'NO ACTIVE CHANNELS FOUND',
            style: AppTheme.terminalTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.textMediumEmphasisTerminal,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2.h),
          Text(
            'INITIALIZE NEW COMMUNICATION CHANNEL',
            style: AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textDisabledTerminal,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),

          // Command-style buttons
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: onCreateRoom,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    child: Row(
                      children: [
                        Text(
                          '> ',
                          style: AppTheme.terminalTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme.primaryTerminal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'CREATE_NEW_ROOM',
                          style: AppTheme.terminalTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme.primaryTerminal,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 1.h),
                GestureDetector(
                  onTap: onJoinRoom,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    child: Row(
                      children: [
                        Text(
                          '> ',
                          style: AppTheme.terminalTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme.primaryTerminal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'JOIN_EXISTING_ROOM',
                          style: AppTheme.terminalTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme.primaryTerminal,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
