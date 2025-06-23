import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class LoadingIndicatorWidget extends StatefulWidget {
  final bool isVisible;

  const LoadingIndicatorWidget({
    super.key,
    required this.isVisible,
  });

  @override
  State<LoadingIndicatorWidget> createState() => _LoadingIndicatorWidgetState();
}

class _LoadingIndicatorWidgetState extends State<LoadingIndicatorWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<int> _dotAnimation;

  final List<String> _dotStates = ['', '.', '..', '...'];

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
  }

  void _initializeAnimation() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _dotAnimation = IntTween(
      begin: 0,
      end: _dotStates.length - 1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));

    if (widget.isVisible) {
      _animationController.repeat();
    }
  }

  @override
  void didUpdateWidget(LoadingIndicatorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible != oldWidget.isVisible) {
      if (widget.isVisible) {
        _animationController.repeat();
      } else {
        _animationController.stop();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: SizedBox(
        height: 4.h,
        child: AnimatedBuilder(
          animation: _dotAnimation,
          builder: (context, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'LOADING',
                  style: AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textMediumEmphasisTerminal,
                    fontSize: 12.sp,
                    letterSpacing: 1.0,
                  ),
                ),
                SizedBox(width: 2.w),
                Container(
                  width: 8.w,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _dotStates[_dotAnimation.value],
                    style:
                        AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.primaryTerminal,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
