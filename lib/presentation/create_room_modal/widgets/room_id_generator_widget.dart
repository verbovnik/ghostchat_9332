import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RoomIdGeneratorWidget extends StatelessWidget {
  final String roomId;
  final bool isGenerating;
  final VoidCallback onRefresh;

  const RoomIdGeneratorWidget({
    super.key,
    required this.roomId,
    required this.isGenerating,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.primaryTerminal,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ROOM_ID:',
                style: AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
                  letterSpacing: 1.0,
                ),
              ),
              GestureDetector(
                onTap: isGenerating ? null : onRefresh,
                child: Container(
                  padding: EdgeInsets.all(1.w),
                  child: CustomIconWidget(
                    iconName: 'refresh',
                    color: isGenerating
                        ? AppTheme.inactiveTerminal
                        : AppTheme.primaryTerminal,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.w),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppTheme.inactiveTerminal,
                width: 1.0,
              ),
            ),
            child: Row(
              children: [
                Text(
                  '>',
                  style: AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.primaryTerminal,
                    letterSpacing: 1.0,
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Text(
                    isGenerating ? 'GENERATING...' : roomId,
                    style:
                        AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w700,
                      color: isGenerating
                          ? AppTheme.textMediumEmphasisTerminal
                          : AppTheme.primaryTerminal,
                    ),
                  ),
                ),
                if (isGenerating)
                  SizedBox(
                    width: 4.w,
                    height: 4.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppTheme.primaryTerminal,
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
