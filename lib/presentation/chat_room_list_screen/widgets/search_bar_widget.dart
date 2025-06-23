import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.w),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: AppTheme.terminalTheme.textTheme.bodyMedium,
        decoration: InputDecoration(
          hintText: 'SEARCH ROOM_ID...',
          prefixIcon: Padding(
            padding: EdgeInsets.all(3.w),
            child: CustomIconWidget(
              iconName: 'search',
              color: AppTheme.textMediumEmphasisTerminal,
              size: 20,
            ),
          ),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    controller.clear();
                    onChanged('');
                  },
                  icon: CustomIconWidget(
                    iconName: 'clear',
                    color: AppTheme.textMediumEmphasisTerminal,
                    size: 20,
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppTheme.primaryTerminal, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide:
                BorderSide(color: AppTheme.inactiveTerminal, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppTheme.primaryTerminal, width: 2.0),
          ),
          fillColor: AppTheme.backgroundTerminal,
          filled: true,
        ),
      ),
    );
  }
}
