import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class SystemStatusWidget extends StatefulWidget {
  final String currentMessage;
  final bool isComplete;
  final int messageIndex;

  const SystemStatusWidget({
    super.key,
    required this.currentMessage,
    required this.isComplete,
    required this.messageIndex,
  });

  @override
  State<SystemStatusWidget> createState() => _SystemStatusWidgetState();
}

class _SystemStatusWidgetState extends State<SystemStatusWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _blinkController;
  late Animation<double> _blinkAnimation;

  @override
  void initState() {
    super.initState();
    _initializeBlinkAnimation();
  }

  void _initializeBlinkAnimation() {
    _blinkController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _blinkAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _blinkController,
      curve: Curves.easeInOut,
    ));

    _blinkController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _blinkController.dispose();
    super.dispose();
  }

  Widget _buildStatusIndicator() {
    if (widget.isComplete) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '[',
            style: AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.primaryTerminal,
              fontSize: 12.sp,
            ),
          ),
          Text(
            'OK',
            style: AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.primaryTerminal,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            ']',
            style: AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.primaryTerminal,
              fontSize: 12.sp,
            ),
          ),
        ],
      );
    }

    return AnimatedBuilder(
      animation: _blinkAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _blinkAnimation.value,
          child: Text(
            '[...]',
            style: AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textMediumEmphasisTerminal,
              fontSize: 12.sp,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      constraints: BoxConstraints(
        minHeight: 6.h,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.currentMessage.isNotEmpty
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppTheme.primaryTerminal.withValues(alpha: 0.3),
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.currentMessage,
                          style: AppTheme.terminalTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: widget.isComplete && widget.messageIndex == 2
                                ? AppTheme.primaryTerminal
                                : AppTheme.textMediumEmphasisTerminal,
                            fontSize: 11.sp,
                            letterSpacing: 0.5,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      _buildStatusIndicator(),
                    ],
                  ),
                )
              : SizedBox(
                  height: 6.h,
                  child: Center(
                    child: Text(
                      'INITIALIZING...',
                      style:
                          AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textDisabledTerminal,
                        fontSize: 11.sp,
                      ),
                    ),
                  ),
                ),
          if (widget.isComplete) ...[
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'PRESS ANY KEY TO CONTINUE',
                  style: AppTheme.terminalTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textMediumEmphasisTerminal,
                    fontSize: 10.sp,
                    letterSpacing: 1.0,
                  ),
                ),
                SizedBox(width: 2.w),
                AnimatedBuilder(
                  animation: _blinkAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _blinkAnimation.value,
                      child: Text(
                        '_',
                        style: AppTheme.terminalTheme.textTheme.bodyMedium
                            ?.copyWith(
                          color: AppTheme.primaryTerminal,
                          fontSize: 12.sp,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
