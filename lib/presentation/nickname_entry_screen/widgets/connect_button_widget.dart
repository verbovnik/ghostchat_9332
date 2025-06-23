import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ConnectButtonWidget extends StatefulWidget {
  final bool isEnabled;
  final VoidCallback onPressed;

  const ConnectButtonWidget({
    super.key,
    required this.isEnabled,
    required this.onPressed,
  });

  @override
  State<ConnectButtonWidget> createState() => _ConnectButtonWidgetState();
}

class _ConnectButtonWidgetState extends State<ConnectButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    if (widget.isEnabled) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(ConnectButtonWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isEnabled != oldWidget.isEnabled) {
      if (widget.isEnabled) {
        _pulseController.repeat(reverse: true);
      } else {
        _pulseController.stop();
        _pulseController.reset();
      }
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: widget.isEnabled ? _pulseAnimation.value : 1.0,
            child: Container(
              height: 6.h,
              decoration: BoxDecoration(
                color: widget.isEnabled
                    ? AppTheme.primaryTerminal
                    : AppTheme.backgroundTerminal,
                border: Border.all(
                  color: widget.isEnabled
                      ? AppTheme.primaryTerminal
                      : AppTheme.inactiveTerminal,
                  width: 2.0,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: widget.isEnabled ? widget.onPressed : null,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Terminal prompt
                        Text(
                          '> ',
                          style: AppTheme.terminalTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: widget.isEnabled
                                ? AppTheme.backgroundTerminal
                                : AppTheme.inactiveTerminal,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // Button text
                        Text(
                          'CONNECT',
                          style: AppTheme.terminalTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: widget.isEnabled
                                ? AppTheme.backgroundTerminal
                                : AppTheme.inactiveTerminal,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),

                        SizedBox(width: 2.w),

                        // Arrow indicator
                        CustomIconWidget(
                          iconName: 'arrow_forward',
                          color: widget.isEnabled
                              ? AppTheme.backgroundTerminal
                              : AppTheme.inactiveTerminal,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
