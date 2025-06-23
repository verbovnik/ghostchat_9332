import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/recent_room_item_widget.dart';
import './widgets/terminal_input_field_widget.dart';

class JoinRoomModal extends StatefulWidget {
  const JoinRoomModal({super.key});

  @override
  State<JoinRoomModal> createState() => _JoinRoomModalState();
}

class _JoinRoomModalState extends State<JoinRoomModal> {
  final TextEditingController _roomIdController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isValidRoomId = false;
  bool _isLoading = false;
  String _errorMessage = '';
  bool _showCursor = true;

  // Mock recent room data
  final List<Map<String, dynamic>> _recentRooms = [
    {
      "roomId": "GHOST001",
      "timeAgo": "2H_AGO",
    },
    {
      "roomId": "ANON456",
      "timeAgo": "5H_AGO",
    },
    {
      "roomId": "TEMP789",
      "timeAgo": "1D_AGO",
    },
  ];

  @override
  void initState() {
    super.initState();
    _roomIdController.addListener(_validateRoomId);
    _startCursorAnimation();
    _checkClipboard();
  }

  @override
  void dispose() {
    _roomIdController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _startCursorAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _showCursor = !_showCursor;
        });
        _startCursorAnimation();
      }
    });
  }

  void _validateRoomId() {
    final roomId = _roomIdController.text.trim().toUpperCase();
    final isValid = roomId.length >= 6 &&
        roomId.length <= 12 &&
        RegExp(r'^[A-Z0-9]+\$').hasMatch(roomId);

    setState(() {
      _isValidRoomId = isValid;
      _errorMessage = '';
    });
  }

  Future<void> _checkClipboard() async {
    try {
      final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
      if (clipboardData?.text != null) {
        final clipText = clipboardData!.text!.trim().toUpperCase();
        if (RegExp(r'^[A-Z0-9]{6,12}\$').hasMatch(clipText)) {
          _showPasteOption(clipText);
        }
      }
    } catch (e) {
      // Clipboard access failed, ignore
    }
  }

  void _showPasteOption(String roomId) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'DETECTED_ROOM_ID: $roomId - TAP TO PASTE',
            style: AppTheme.terminalTheme.textTheme.bodyMedium,
          ),
          backgroundColor: AppTheme.backgroundTerminal,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(color: AppTheme.primaryTerminal, width: 1.0),
          ),
          action: SnackBarAction(
            label: 'PASTE',
            textColor: AppTheme.primaryTerminal,
            onPressed: () {
              _roomIdController.text = roomId;
              _validateRoomId();
            },
          ),
        ),
      );
    }
  }

  Future<void> _connectToRoom() async {
    if (!_isValidRoomId) return;

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    // Simulate server verification
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      // Mock server responses
      final roomId = _roomIdController.text.trim().toUpperCase();

      // Simulate different error scenarios
      if (roomId == 'NOTFOUND') {
        setState(() {
          _isLoading = false;
          _errorMessage = 'ERROR: ROOM_NOT_FOUND';
        });
        return;
      } else if (roomId == 'FULL123') {
        setState(() {
          _isLoading = false;
          _errorMessage = 'ERROR: ROOM_CAPACITY_EXCEEDED';
        });
        return;
      } else if (roomId.length < 6) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'ERROR: INVALID_ROOM_ID';
        });
        return;
      }

      // Success case
      setState(() {
        _isLoading = false;
      });

      // Show success message briefly
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'CONNECTION_ESTABLISHED',
            style: AppTheme.terminalTheme.textTheme.bodyMedium,
          ),
          backgroundColor: AppTheme.backgroundTerminal,
          duration: const Duration(seconds: 1),
        ),
      );

      // Navigate to chat room
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          '/chat-room-screen',
          arguments: {'roomId': roomId},
        );
      }
    }
  }

  void _onRecentRoomTap(String roomId) {
    _roomIdController.text = roomId;
    _validateRoomId();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.terminalTheme,
      child: Scaffold(
        backgroundColor: AppTheme.backgroundTerminal,
        body: SafeArea(
          child: Container(
            width: 100.w,
            height: 100.h,
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                _buildHeader(),
                SizedBox(height: 4.h),

                // Main content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Room ID input section
                        _buildInputSection(),
                        SizedBox(height: 3.h),

                        // Recent rooms section
                        if (_recentRooms.isNotEmpty) ...[
                          _buildRecentRoomsSection(),
                          SizedBox(height: 3.h),
                        ],

                        // Error message
                        if (_errorMessage.isNotEmpty) ...[
                          _buildErrorMessage(),
                          SizedBox(height: 2.h),
                        ],

                        // Connect button
                        _buildConnectButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(vertical: 1.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppTheme.primaryTerminal,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'JOIN EXISTING CHANNEL:',
            style: AppTheme.terminalTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(1.w),
              child: CustomIconWidget(
                iconName: 'close',
                color: AppTheme.primaryTerminal,
                size: 6.w,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Terminal prompt
        Row(
          children: [
            Text(
              '>ENTER_ROOM_ID:',
              style: AppTheme.terminalTheme.textTheme.bodyLarge,
            ),
            if (_showCursor && _focusNode.hasFocus)
              Container(
                width: 2.w,
                height: 2.h,
                margin: EdgeInsets.only(left: 1.w),
                color: AppTheme.primaryTerminal,
              ),
          ],
        ),
        SizedBox(height: 1.h),

        // Input field
        TerminalInputFieldWidget(
          controller: _roomIdController,
          focusNode: _focusNode,
          hintText: 'ROOM_ID_HERE',
          isValid: _isValidRoomId,
          onSubmitted: (value) {
            if (_isValidRoomId && !_isLoading) {
              _connectToRoom();
            }
          },
        ),

        SizedBox(height: 1.h),

        // Format hint
        Text(
          'FORMAT: 6-12 ALPHANUMERIC CHARACTERS',
          style: AppTheme.terminalTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.textMediumEmphasisTerminal,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentRoomsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '>RECENT CHANNELS:',
          style: AppTheme.terminalTheme.textTheme.bodyLarge,
        ),
        SizedBox(height: 1.h),
        Container(
          width: 100.w,
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppTheme.inactiveTerminal,
              width: 1.0,
            ),
          ),
          child: Column(
            children: _recentRooms.map((room) {
              return RecentRoomItemWidget(
                roomId: room['roomId'] as String,
                timeAgo: room['timeAgo'] as String,
                onTap: () => _onRecentRoomTap(room['roomId'] as String),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorMessage() {
    return Container(
      width: 100.w,
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.errorTerminal,
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: 'error_outline',
            color: AppTheme.errorTerminal,
            size: 5.w,
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Text(
              _errorMessage,
              style: AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.errorTerminal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnectButton() {
    return SizedBox(
      width: 100.w,
      height: 6.h,
      child: ElevatedButton(
        onPressed: (_isValidRoomId && !_isLoading) ? _connectToRoom : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _isValidRoomId
              ? AppTheme.primaryTerminal
              : AppTheme.inactiveTerminal,
          foregroundColor: AppTheme.backgroundTerminal,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(
              color: _isValidRoomId
                  ? AppTheme.primaryTerminal
                  : AppTheme.inactiveTerminal,
              width: 1.0,
            ),
          ),
        ),
        child: _isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 4.w,
                    height: 4.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppTheme.backgroundTerminal,
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'VERIFYING CHANNEL ACCESS...',
                    style:
                        AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.backgroundTerminal,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )
            : Text(
                'CONNECT TO ROOM',
                style: AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.backgroundTerminal,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }
}
