import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class MessageItemWidget extends StatelessWidget {
  final String content;
  final String timestamp;
  final bool isSystem;
  final bool isOwn;

  const MessageItemWidget({
    super.key,
    required this.content,
    required this.timestamp,
    this.isSystem = false,
    this.isOwn = false,
  });

  void _showContextMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.backgroundTerminal,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(color: AppTheme.primaryTerminal, width: 1),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 2.h),
                decoration: BoxDecoration(
                  border: Border(
                    bottom:
                        BorderSide(color: AppTheme.primaryTerminal, width: 1),
                  ),
                ),
                child: Text(
                  'MESSAGE_ACTIONS',
                  style: AppTheme.terminalTheme.textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 2.h),
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'content_copy',
                  color: AppTheme.primaryTerminal,
                  size: 20,
                ),
                title: Text(
                  'COPY_TEXT',
                  style: AppTheme.terminalTheme.textTheme.bodyMedium,
                ),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: content));
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'TEXT_COPIED_TO_CLIPBOARD',
                        style: AppTheme.terminalTheme.textTheme.bodyMedium,
                      ),
                      backgroundColor: AppTheme.backgroundTerminal,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(
                            color: AppTheme.primaryTerminal, width: 1),
                      ),
                    ),
                  );
                },
              ),
              if (!isSystem && !isOwn)
                ListTile(
                  leading: CustomIconWidget(
                    iconName: 'report',
                    color: AppTheme.errorTerminal,
                    size: 20,
                  ),
                  title: Text(
                    'REPORT_MESSAGE',
                    style:
                        AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.errorTerminal,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'MESSAGE_REPORTED',
                          style: AppTheme.terminalTheme.textTheme.bodyMedium,
                        ),
                        backgroundColor: AppTheme.backgroundTerminal,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                          side: BorderSide(
                              color: AppTheme.errorTerminal, width: 1),
                        ),
                      ),
                    );
                  },
                ),
              SizedBox(height: 2.h),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _showContextMenu(context),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 1.h),
        padding: EdgeInsets.symmetric(vertical: 0.5.h),
        child: RichText(
          text: TextSpan(
            style: AppTheme.terminalTheme.textTheme.bodyMedium,
            children: [
              if (isSystem)
                TextSpan(
                  text: '[$timestamp] SYSTEM: ',
                  style: AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.warningTerminal,
                  ),
                )
              else
                TextSpan(
                  text: '[$timestamp] ${isOwn ? "YOU" : "ANONYMOUS_USER"}: ',
                  style: AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
                    color: isOwn
                        ? AppTheme.primaryTerminal.withValues(alpha: 0.8)
                        : AppTheme.primaryTerminal,
                  ),
                ),
              TextSpan(
                text: content,
                style: AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
                  color: isSystem
                      ? AppTheme.warningTerminal
                      : AppTheme.textHighEmphasisTerminal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
