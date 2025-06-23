import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class TimeoutSelectorWidget extends StatelessWidget {
  final List<Map<String, dynamic>> timeoutOptions;
  final String selectedTimeout;
  final Function(String) onTimeoutChanged;

  const TimeoutSelectorWidget({
    super.key,
    required this.timeoutOptions,
    required this.selectedTimeout,
    required this.onTimeoutChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TIMEOUT:',
            style: AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
              letterSpacing: 1.0,
            ),
          ),
          SizedBox(height: 1.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppTheme.primaryTerminal,
                width: 1.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AUTO-DESTRUCTION TIMER (INACTIVITY):',
                  style: AppTheme.terminalTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textMediumEmphasisTerminal,
                    letterSpacing: 0.8,
                  ),
                ),
                SizedBox(height: 1.h),
                Wrap(
                  spacing: 3.w,
                  runSpacing: 1.h,
                  children:
                      (timeoutOptions as List).map<Widget>((dynamic timeout) {
                    final timeoutMap = timeout as Map<String, dynamic>;
                    final String value = timeoutMap['value'] as String;
                    final String label = timeoutMap['label'] as String;
                    final bool isSelected = value == selectedTimeout;

                    return GestureDetector(
                      onTap: () => onTimeoutChanged(value),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.w,
                          vertical: 1.h,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected
                                ? AppTheme.primaryTerminal
                                : AppTheme.inactiveTerminal,
                            width: 1.0,
                          ),
                          color: isSelected
                              ? AppTheme.primaryTerminal.withValues(alpha: 0.1)
                              : Colors.transparent,
                        ),
                        child: Text(
                          '[$label]',
                          style: AppTheme.terminalTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: isSelected
                                ? AppTheme.primaryTerminal
                                : AppTheme.textMediumEmphasisTerminal,
                            letterSpacing: 1.0,
                            fontWeight:
                                isSelected ? FontWeight.w700 : FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
