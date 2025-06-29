import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/hacker_text_widget.dart';

class TerminalLogoWidget extends StatefulWidget {
  const TerminalLogoWidget({super.key});

  @override
  State<TerminalLogoWidget> createState() => _TerminalLogoWidgetState();
}

class _TerminalLogoWidgetState extends State<TerminalLogoWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _typewriterController;
  late Animation<int> _typewriterAnimation;

  final String _logoText = '''
   ██████╗ ██╗  ██╗ ██████╗ ███████╗████████╗
  ██╔════╝ ██║  ██║██╔═══██╗██╔════╝╚══██╔══╝
  ██║  ███╗███████║██║   ██║███████╗   ██║   
  ██║   ██║██╔══██║██║   ██║╚════██║   ██║   
  ╚██████╔╝██║  ██║╚██████╔╝███████║   ██║   
   ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝   
                                              
                 ██████╗██╗  ██╗ █████╗ ████████╗
                ██╔════╝██║  ██║██╔══██╗╚══██╔══╝
                ██║     ███████║███████║   ██║   
                ██║     ██╔══██║██╔══██║   ██║   
                ╚██████╗██║  ██║██║  ██║   ██║   
                 ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   
  ''';

  @override
  void initState() {
    super.initState();
    _initializeTypewriterAnimation();
  }

  void _initializeTypewriterAnimation() {
    _typewriterController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _typewriterAnimation = IntTween(
      begin: 0,
      end: _logoText.length,
    ).animate(CurvedAnimation(
      parent: _typewriterController,
      curve: Curves.easeInOut,
    ));

    _typewriterController.forward();
  }

  @override
  void dispose() {
    _typewriterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      constraints: BoxConstraints(
        maxHeight: 35.h,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryTerminal.withValues(alpha: 0.2),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: AnimatedBuilder(
        animation: _typewriterAnimation,
        builder: (context, child) {
          final displayText =
              _logoText.substring(0, _typewriterAnimation.value);

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  displayText,
                  style: AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.primaryTerminal,
                    fontSize: 8.sp,
                    fontFamily: 'monospace',
                    height: 1.0,
                    shadows: [
                      Shadow(
                        color: AppTheme.primaryTerminal.withValues(alpha: 0.5),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2.h),
                HackerTextWidget(
                  text: 'ANONYMOUS EPHEMERAL MESSAGING',
                  style: AppTheme.terminalTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textMediumEmphasisTerminal,
                    fontSize: 10.sp,
                    letterSpacing: 2.0,
                    shadows: [
                      Shadow(
                        color: AppTheme.primaryTerminal.withValues(alpha: 0.3),
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  animationDuration: Duration(milliseconds: 1500),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
