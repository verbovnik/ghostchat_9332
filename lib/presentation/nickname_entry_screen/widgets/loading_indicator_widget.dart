import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class LoadingIndicatorWidget extends StatefulWidget {
  final AnimationController animationController;

  const LoadingIndicatorWidget({
    super.key,
    required this.animationController,
  });

  @override
  State<LoadingIndicatorWidget> createState() => _LoadingIndicatorWidgetState();
}

class _LoadingIndicatorWidgetState extends State<LoadingIndicatorWidget> {
  int _currentDotCount = 1;

  @override
  void initState() {
    super.initState();
    widget.animationController.addListener(_updateDots);
  }

  void _updateDots() {
    if (mounted) {
      setState(() {
        _currentDotCount =
            ((widget.animationController.value * 3).floor() % 3) + 1;
      });
    }
  }

  @override
  void dispose() {
    widget.animationController.removeListener(_updateDots);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Loading text
          Text(
            '> ESTABLISHING SECURE CONNECTION',
            style: AppTheme.terminalTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.primaryTerminal,
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 4.h),

          // Terminal-style loading animation
          Container(
            width: 60.w,
            height: 8.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppTheme.primaryTerminal,
                width: 1.0,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Loading dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'CONNECTING',
                      style:
                          AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.primaryTerminal,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    SizedBox(
                      width: 15.w,
                      child: Text(
                        '.' * _currentDotCount,
                        style: AppTheme.terminalTheme.textTheme.bodyMedium
                            ?.copyWith(
                          color: AppTheme.primaryTerminal,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 1.h),

                // Progress bar
                Container(
                  width: 50.w,
                  height: 0.5.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppTheme.primaryTerminal,
                      width: 1.0,
                    ),
                  ),
                  child: AnimatedBuilder(
                    animation: widget.animationController,
                    builder: (context, child) {
                      return LinearProgressIndicator(
                        value: widget.animationController.value,
                        backgroundColor: AppTheme.backgroundTerminal,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppTheme.primaryTerminal,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 4.h),

          // Status messages
          Column(
            children: [
              _buildStatusLine('> INITIALIZING ANONYMOUS SESSION...'),
              _buildStatusLine('> ENCRYPTING COMMUNICATION CHANNEL...'),
              _buildStatusLine('> VERIFYING NETWORK SECURITY...'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusLine(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Text(
        text,
        style: AppTheme.terminalTheme.textTheme.bodySmall?.copyWith(
          color: AppTheme.textMediumEmphasisTerminal,
          fontSize: 11.sp,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
