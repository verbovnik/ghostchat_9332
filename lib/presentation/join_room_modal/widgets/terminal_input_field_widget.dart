import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class TerminalInputFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final bool isValid;
  final Function(String)? onSubmitted;

  const TerminalInputFieldWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hintText,
    this.isValid = false,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
        border: Border.all(
          color: focusNode.hasFocus
              ? AppTheme.primaryTerminal
              : AppTheme.inactiveTerminal,
          width: focusNode.hasFocus ? 2.0 : 1.0,
        ),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: AppTheme.terminalTheme.textTheme.bodyLarge?.copyWith(
          letterSpacing: 2.0,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTheme.terminalTheme.textTheme.bodyLarge?.copyWith(
            color: AppTheme.textDisabledTerminal,
            letterSpacing: 2.0,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 3.w,
            vertical: 1.5.h,
          ),
          prefixText: '> ',
          prefixStyle: AppTheme.terminalTheme.textTheme.bodyLarge,
        ),
        textCapitalization: TextCapitalization.characters,
        autocorrect: false,
        enableSuggestions: false,
        keyboardType: TextInputType.visiblePassword,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
          LengthLimitingTextInputFormatter(12),
          UpperCaseTextFormatter(),
        ],
        onSubmitted: onSubmitted,
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
