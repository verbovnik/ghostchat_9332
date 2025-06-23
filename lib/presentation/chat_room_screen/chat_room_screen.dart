import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/connection_status_widget.dart';
import './widgets/message_item_widget.dart';
import './widgets/room_timer_widget.dart';
import './widgets/typing_indicator_widget.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen>
    with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _messageFocusNode = FocusNode();

  Timer? _typingTimer;
  Timer? _roomTimer;
  Timer? _blinkTimer;

  bool _isTyping = false;
  final bool _isConnected = true;
  bool _showCursor = true;
  final int _participantCount = 5;
  final String _roomId = "ABC123";
  int _remainingTime = 1800; // 30 minutes in seconds
  int _characterCount = 0;
  final int _maxCharacters = 280;

  // Mock messages data
  final List<Map<String, dynamic>> _messages = [
    {
      "id": 1,
      "content":
          "Welcome to the anonymous chat room. All messages are ephemeral.",
      "timestamp": DateTime.now().subtract(Duration(minutes: 15)),
      "isSystem": true,
    },
    {
      "id": 2,
      "content": "Hey everyone, glad to be here!",
      "timestamp": DateTime.now().subtract(Duration(minutes: 12)),
      "isSystem": false,
    },
    {
      "id": 3,
      "content": "This terminal interface is pretty cool",
      "timestamp": DateTime.now().subtract(Duration(minutes: 8)),
      "isSystem": false,
    },
    {
      "id": 4,
      "content": "Anyone working on interesting projects?",
      "timestamp": DateTime.now().subtract(Duration(minutes: 5)),
      "isSystem": false,
    },
    {
      "id": 5,
      "content": "Just exploring anonymous communication platforms",
      "timestamp": DateTime.now().subtract(Duration(minutes: 2)),
      "isSystem": false,
    },
  ];

  final List<String> _typingUsers = ["ANONYMOUS_USER_1", "ANONYMOUS_USER_2"];

  @override
  void initState() {
    super.initState();
    _startBlinkingCursor();
    _startRoomTimer();
    _messageController.addListener(_onMessageChanged);
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _roomTimer?.cancel();
    _blinkTimer?.cancel();
    _messageController.dispose();
    _scrollController.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  void _startBlinkingCursor() {
    _blinkTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          _showCursor = !_showCursor;
        });
      }
    });
  }

  void _startRoomTimer() {
    _roomTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted && _remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _onMessageChanged() {
    setState(() {
      _characterCount = _messageController.text.length;
    });

    if (!_isTyping && _messageController.text.isNotEmpty) {
      setState(() {
        _isTyping = true;
      });
    }

    _typingTimer?.cancel();
    _typingTimer = Timer(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isTyping = false;
        });
      }
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      HapticFeedback.lightImpact();

      setState(() {
        _messages.add({
          "id": _messages.length + 1,
          "content": _messageController.text.trim(),
          "timestamp": DateTime.now(),
          "isSystem": false,
          "isOwn": true,
        });
        _messageController.clear();
        _characterCount = 0;
        _isTyping = false;
      });

      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showExitConfirmation() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.8),
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.backgroundTerminal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(color: AppTheme.primaryTerminal, width: 1.0),
          ),
          title: Text(
            'EXIT_ROOM_CONFIRMATION',
            style: AppTheme.terminalTheme.textTheme.titleMedium,
          ),
          content: Text(
            'All messages will be permanently deleted.\nThis action cannot be undone.\n\nContinue exit? [Y/N]',
            style: AppTheme.terminalTheme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('[N] CANCEL'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('[Y] EXIT'),
            ),
          ],
        );
      },
    );
  }

  String _formatTime(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  String _formatRemainingTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundTerminal,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundTerminal,
        elevation: 0,
        leading: IconButton(
          onPressed: _showExitConfirmation,
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.primaryTerminal,
            size: 24,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ROOM_$_roomId [\$_participantCount_USERS_ACTIVE]',
              style: AppTheme.terminalTheme.textTheme.titleMedium,
            ),
            if (_remainingTime > 0)
              RoomTimerWidget(
                remainingTime: _formatRemainingTime(_remainingTime),
              ),
          ],
        ),
        actions: [
          ConnectionStatusWidget(isConnected: _isConnected),
          SizedBox(width: 4.w),
        ],
      ),
      body: Column(
        children: [
          // Terminal border line
          Container(
            width: double.infinity,
            height: 1,
            color: AppTheme.primaryTerminal,
          ),

          // Messages area
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(Duration(milliseconds: 500));
                HapticFeedback.lightImpact();
              },
              color: AppTheme.primaryTerminal,
              backgroundColor: AppTheme.backgroundTerminal,
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                itemCount: _messages.length + (_typingUsers.isNotEmpty ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _messages.length) {
                    return TypingIndicatorWidget(typingUsers: _typingUsers);
                  }

                  final message = _messages[index];
                  return MessageItemWidget(
                    content: message["content"] as String,
                    timestamp: _formatTime(message["timestamp"] as DateTime),
                    isSystem: message["isSystem"] as bool? ?? false,
                    isOwn: message["isOwn"] as bool? ?? false,
                  );
                },
              ),
            ),
          ),

          // Input area
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: AppTheme.primaryTerminal, width: 1),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Character counter
                  if (_characterCount > 0)
                    Padding(
                      padding: EdgeInsets.only(bottom: 1.h),
                      child: Text(
                        'CHARS: $_characterCount/$_maxCharacters',
                        style: AppTheme.terminalTheme.textTheme.bodySmall
                            ?.copyWith(
                          color: _characterCount > _maxCharacters * 0.8
                              ? AppTheme.warningTerminal
                              : AppTheme.textMediumEmphasisTerminal,
                        ),
                      ),
                    ),

                  // Input row
                  Row(
                    children: [
                      // Terminal prompt
                      Text(
                        '>MESSAGE: ',
                        style: AppTheme.terminalTheme.textTheme.bodyMedium,
                      ),

                      // Input field
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          focusNode: _messageFocusNode,
                          maxLength: _maxCharacters,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) => _sendMessage(),
                          style: AppTheme.terminalTheme.textTheme.bodyMedium,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            counterText: '',
                            hintText: 'type_message_here',
                            hintStyle: AppTheme
                                .terminalTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppTheme.textDisabledTerminal,
                            ),
                            suffixIcon:
                                _messageFocusNode.hasFocus && _showCursor
                                    ? Container(
                                        width: 2,
                                        height: 20,
                                        color: AppTheme.primaryTerminal,
                                      )
                                    : null,
                          ),
                        ),
                      ),

                      SizedBox(width: 2.w),

                      // Send button
                      GestureDetector(
                        onTap: _sendMessage,
                        child: Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _messageController.text.trim().isNotEmpty
                                  ? AppTheme.primaryTerminal
                                  : AppTheme.inactiveTerminal,
                              width: 1,
                            ),
                          ),
                          child: CustomIconWidget(
                            iconName: 'send',
                            color: _messageController.text.trim().isNotEmpty
                                ? AppTheme.primaryTerminal
                                : AppTheme.inactiveTerminal,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
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
