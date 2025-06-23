import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RecentRoomItemWidget extends StatefulWidget {
  final String roomId;
  final String timeAgo;
  final VoidCallback onTap;

  const RecentRoomItemWidget({
    super.key,
    required this.roomId,
    required this.timeAgo,
    required this.onTap,
  });

  @override
  State<RecentRoomItemWidget> createState() => _RecentRoomItemWidgetState();
}

class _RecentRoomItemWidgetState extends State<RecentRoomItemWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Container(
          width: 100.w,
          padding: EdgeInsets.symmetric(
            horizontal: 2.w,
            vertical: 1.h,
          ),
          margin: EdgeInsets.only(bottom: 0.5.h),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppTheme.primaryTerminal.withValues(alpha: 0.1)
                : Colors.transparent,
            border: _isHovered
                ? Border.all(
                    color: AppTheme.primaryTerminal.withValues(alpha: 0.3),
                    width: 1.0,
                  )
                : null,
          ),
          child: Row(
            children: [
              // Command prompt
              Text(
                '>RECENT:',
                style: AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textMediumEmphasisTerminal,
                ),
              ),
              SizedBox(width: 2.w),

              // Room ID
              Expanded(
                child: Text(
                  widget.roomId,
                  style: AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
                    color: _isHovered
                        ? AppTheme.primaryTerminal
                        : AppTheme.textHighEmphasisTerminal,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
              ),

              // Time ago
              Text(
                '[${widget.timeAgo}]',
                style: AppTheme.terminalTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.textMediumEmphasisTerminal,
                ),
              ),

              SizedBox(width: 2.w),

              // Arrow indicator
              CustomIconWidget(
                iconName: 'keyboard_arrow_right',
                color: _isHovered
                    ? AppTheme.primaryTerminal
                    : AppTheme.textMediumEmphasisTerminal,
                size: 4.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
