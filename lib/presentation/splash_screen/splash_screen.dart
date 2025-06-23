import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import '../../widgets/matrix_rain_widget.dart';
import '../../widgets/scan_lines_widget.dart';
import './widgets/loading_indicator_widget.dart';
import './widgets/system_status_widget.dart';
import './widgets/terminal_logo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  late AnimationController _cursorAnimationController;
  late AnimationController _loadingAnimationController;
  late AnimationController _matrixAnimationController;

  late Animation<double> _logoOpacity;
  late Animation<double> _cursorOpacity;
  late Animation<double> _matrixOpacity;

  String _currentLoadingMessage = '';
  bool _isInitializationComplete = false;
  int _currentMessageIndex = 0;

  final List<String> _loadingMessages = [
    'INITIALIZING SECURE CONNECTION...',
    'BYPASSING NETWORK FILTERS...',
    'ESTABLISHING ANONYMOUS SESSION...',
    'LOADING ENCRYPTION PROTOCOLS...',
    'SYSTEM READY - ACCESS GRANTED'
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startInitializationSequence();
    _hideStatusBar();
  }

  void _initializeAnimations() {
    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _cursorAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _loadingAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _matrixAnimationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _logoOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.easeInOut,
    ));

    _cursorOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _cursorAnimationController,
      curve: Curves.easeInOut,
    ));

    _matrixOpacity = Tween<double>(
      begin: 0.0,
      end: 0.15,
    ).animate(CurvedAnimation(
      parent: _matrixAnimationController,
      curve: Curves.easeInOut,
    ));

    _logoAnimationController.forward();
    _cursorAnimationController.repeat(reverse: true);
    _matrixAnimationController.forward();
  }

  void _hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  void _restoreStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  Future<void> _startInitializationSequence() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    for (int i = 0; i < _loadingMessages.length; i++) {
      if (mounted) {
        setState(() {
          _currentMessageIndex = i;
          _currentLoadingMessage = _loadingMessages[i];
        });

        _loadingAnimationController.reset();
        _loadingAnimationController.forward();

        await Future.delayed(const Duration(milliseconds: 800));
      }
    }

    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      setState(() {
        _isInitializationComplete = true;
      });

      await Future.delayed(const Duration(milliseconds: 1000));
      _navigateToNextScreen();
    }
  }

  void _navigateToNextScreen() {
    _restoreStatusBar();
    Navigator.pushReplacementNamed(context, '/nickname-entry-screen');
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _cursorAnimationController.dispose();
    _loadingAnimationController.dispose();
    _matrixAnimationController.dispose();
    _restoreStatusBar();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundTerminal,
      body: Stack(
        children: [
          // Matrix rain background effect
          AnimatedBuilder(
            animation: _matrixOpacity,
            builder: (context, child) {
              return MatrixRainWidget(
                opacity: _matrixOpacity.value,
                isActive: true,
              );
            },
          ),

          // Scan lines overlay
          ScanLinesWidget(
            opacity: 0.03,
            isActive: true,
          ),

          // Main content
          SafeArea(
            child: Container(
              width: 100.w,
              height: 100.h,
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: AnimatedBuilder(
                        animation: _logoOpacity,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _logoOpacity.value,
                            child: TerminalLogoWidget(),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: _cursorAnimationController,
                          builder: (context, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '>',
                                  style: AppTheme
                                      .terminalTheme.textTheme.bodyLarge
                                      ?.copyWith(
                                    color: AppTheme.primaryTerminal,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                SizedBox(width: 1.w),
                                Opacity(
                                  opacity: _cursorOpacity.value,
                                  child: Container(
                                    width: 2.w,
                                    height: 2.h,
                                    decoration: BoxDecoration(
                                      color: AppTheme.primaryTerminal,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppTheme.primaryTerminal
                                              .withValues(alpha: 0.5),
                                          blurRadius: 4,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(height: 2.h),
                        SystemStatusWidget(
                          currentMessage: _currentLoadingMessage,
                          isComplete: _isInitializationComplete,
                          messageIndex: _currentMessageIndex,
                        ),
                        SizedBox(height: 2.h),
                        LoadingIndicatorWidget(
                          isVisible: !_isInitializationComplete,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
