import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/connect_button_widget.dart';
import './widgets/loading_indicator_widget.dart';
import './widgets/nickname_input_widget.dart';
import './widgets/terminal_header_widget.dart';

class NicknameEntryScreen extends StatefulWidget {
  const NicknameEntryScreen({super.key});

  @override
  State<NicknameEntryScreen> createState() => _NicknameEntryScreenState();
}

class _NicknameEntryScreenState extends State<NicknameEntryScreen>
    with TickerProviderStateMixin {
  final TextEditingController _nicknameController = TextEditingController();
  final FocusNode _nicknameFocusNode = FocusNode();

  bool _isLoading = false;
  bool _isValidNickname = false;
  String _errorMessage = '';
  String _nickname = '';

  late AnimationController _cursorAnimationController;
  late AnimationController _loadingAnimationController;

  static const int maxNicknameLength = 20;
  static const String validCharacters = r'^[a-zA-Z0-9]+$';

  // Mock profanity filter - simple list for demonstration
  final List<String> _profanityList = ['badword1', 'badword2', 'inappropriate'];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _setupTextController();

    // Auto-focus input field for immediate typing
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _nicknameFocusNode.requestFocus();
    });
  }

  void _initializeAnimations() {
    _cursorAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _loadingAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
  }

  void _setupTextController() {
    _nicknameController.addListener(() {
      setState(() {
        _nickname = _nicknameController.text;
        _validateNickname();
      });
    });
  }

  void _validateNickname() {
    final nickname = _nickname.trim();

    if (nickname.isEmpty) {
      _isValidNickname = false;
      _errorMessage = '';
      return;
    }

    if (nickname.length > maxNicknameLength) {
      _isValidNickname = false;
      _errorMessage = 'ERROR: HANDLE TOO LONG';
      return;
    }

    if (!RegExp(validCharacters).hasMatch(nickname)) {
      _isValidNickname = false;
      _errorMessage = 'ERROR: INVALID CHARACTERS DETECTED';
      return;
    }

    if (_profanityList
        .any((word) => nickname.toLowerCase().contains(word.toLowerCase()))) {
      _isValidNickname = false;
      _errorMessage = 'ERROR: INAPPROPRIATE HANDLE';
      return;
    }

    _isValidNickname = true;
    _errorMessage = '';
  }

  Future<void> _connectToChat() async {
    if (!_isValidNickname || _isLoading) return;

    setState(() {
      _isLoading = true;
    });

    // Haptic feedback
    HapticFeedback.lightImpact();

    _loadingAnimationController.repeat();

    // Simulate connection process
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      _loadingAnimationController.stop();

      // Success haptic feedback
      HapticFeedback.mediumImpact();

      // Navigate to chat room list
      Navigator.pushReplacementNamed(context, '/chat-room-list-screen');
    }
  }

  void _onBackPressed() {
    // Exit app completely to maintain zero data persistence
    SystemNavigator.pop();
  }

  @override
  void dispose() {
    _cursorAnimationController.dispose();
    _loadingAnimationController.dispose();
    _nicknameController.dispose();
    _nicknameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onBackPressed();
        return false;
      },
      child: Scaffold(
        backgroundColor: AppTheme.backgroundTerminal,
        body: SafeArea(
          child: _isLoading ? _buildLoadingView() : _buildMainView(),
        ),
      ),
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: LoadingIndicatorWidget(
        animationController: _loadingAnimationController,
      ),
    );
  }

  Widget _buildMainView() {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: 100.h -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom,
        ),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),

            // Terminal header
            TerminalHeaderWidget(),

            SizedBox(height: 8.h),

            // Nickname input section
            NicknameInputWidget(
              controller: _nicknameController,
              focusNode: _nicknameFocusNode,
              cursorAnimationController: _cursorAnimationController,
              nickname: _nickname,
              maxLength: maxNicknameLength,
              onSubmitted: (_) => _connectToChat(),
            ),

            SizedBox(height: 2.h),

            // Character counter
            _buildCharacterCounter(),

            SizedBox(height: 1.h),

            // Error message
            if (_errorMessage.isNotEmpty) _buildErrorMessage(),

            SizedBox(height: 6.h),

            // Connect button
            ConnectButtonWidget(
              isEnabled: _isValidNickname && !_isLoading,
              onPressed: _connectToChat,
            ),

            const Spacer(),

            // Terminal footer info
            _buildFooterInfo(),

            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _buildCharacterCounter() {
    final remainingChars = maxNicknameLength - _nickname.length;
    final isNearLimit = remainingChars <= 5;

    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        'CHARS REMAINING: $remainingChars',
        style: AppTheme.terminalTheme.textTheme.bodySmall?.copyWith(
          color: isNearLimit
              ? AppTheme.warningTerminal
              : AppTheme.textMediumEmphasisTerminal,
          fontSize: 10.sp,
        ),
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.errorTerminal,
          width: 1.0,
        ),
      ),
      child: Text(
        _errorMessage,
        style: AppTheme.terminalTheme.textTheme.bodySmall?.copyWith(
          color: AppTheme.errorTerminal,
          fontSize: 11.sp,
        ),
      ),
    );
  }

  Widget _buildFooterInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '> ANONYMOUS SESSION ONLY',
          style: AppTheme.terminalTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.textDisabledTerminal,
            fontSize: 10.sp,
          ),
        ),
        SizedBox(height: 0.5.h),
        Text(
          '> NO DATA PERSISTENCE',
          style: AppTheme.terminalTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.textDisabledTerminal,
            fontSize: 10.sp,
          ),
        ),
        SizedBox(height: 0.5.h),
        Text(
          '> ZERO DIGITAL FOOTPRINT',
          style: AppTheme.terminalTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.textDisabledTerminal,
            fontSize: 10.sp,
          ),
        ),
      ],
    );
  }
}
