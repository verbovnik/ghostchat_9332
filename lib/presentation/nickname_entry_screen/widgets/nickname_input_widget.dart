import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class NicknameInputWidget extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final AnimationController cursorAnimationController;
  final String nickname;
  final int maxLength;
  final Function(String) onSubmitted;

  const NicknameInputWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.cursorAnimationController,
    required this.nickname,
    required this.maxLength,
    required this.onSubmitted,
  });

  @override
  State<NicknameInputWidget> createState() => _NicknameInputWidgetState();
}

class _NicknameInputWidgetState extends State<NicknameInputWidget> {
  bool _showCursor = true;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChange);
    widget.cursorAnimationController.addListener(_onCursorAnimation);
  }

  void _onFocusChange() {
    setState(() {
      _showCursor = widget.focusNode.hasFocus;
    });
  }

  void _onCursorAnimation() {
    if (widget.focusNode.hasFocus && mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    widget.cursorAnimationController.removeListener(_onCursorAnimation);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Input field container
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: AppTheme.backgroundTerminal,
              border: Border.all(
                color: widget.focusNode.hasFocus
                    ? AppTheme.primaryTerminal
                    : AppTheme.inactiveTerminal,
                width: widget.focusNode.hasFocus ? 2.0 : 1.0,
              ),
            ),
            child: Row(
              children: [
                // Terminal prompt
                Text(
                  '\$ ',
                  style: AppTheme.terminalTheme.textTheme.bodyLarge?.copyWith(
                    color: AppTheme.primaryTerminal,
                    fontSize: 14.sp,
                  ),
                ),

                // Input field
                Expanded(
                  child: Stack(
                    children: [
                      // Invisible TextField for input handling
                      TextField(
                        controller: widget.controller,
                        focusNode: widget.focusNode,
                        style: AppTheme.terminalTheme.textTheme.bodyLarge
                            ?.copyWith(
                          color: Colors.transparent, // Make text transparent
                          fontSize: 14.sp,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.none,
                        autocorrect: false,
                        enableSuggestions: false,
                        maxLength: widget.maxLength,
                        buildCounter: (context,
                                {required currentLength,
                                required isFocused,
                                maxLength}) =>
                            null,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z0-9]')),
                          LengthLimitingTextInputFormatter(widget.maxLength),
                        ],
                        onSubmitted: widget.onSubmitted,
                      ),

                      // Custom text display with cursor
                      Positioned.fill(
                        child: _buildCustomTextDisplay(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 1.h),

          // Input instructions
          Text(
            '> ALPHANUMERIC CHARACTERS ONLY',
            style: AppTheme.terminalTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.textDisabledTerminal,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomTextDisplay() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Display typed text
        if (widget.nickname.isNotEmpty)
          Text(
            widget.nickname,
            style: AppTheme.terminalTheme.textTheme.bodyLarge?.copyWith(
              color: AppTheme.primaryTerminal,
              fontSize: 14.sp,
            ),
          ),

        // Blinking cursor
        if (_showCursor)
          AnimatedBuilder(
            animation: widget.cursorAnimationController,
            builder: (context, child) {
              return Opacity(
                opacity: widget.cursorAnimationController.value,
                child: Container(
                  width: 2.w,
                  height: 2.h,
                  color: AppTheme.primaryTerminal,
                ),
              );
            },
          ),
      ],
    );
  }
}
