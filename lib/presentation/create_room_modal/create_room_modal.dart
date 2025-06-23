import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/room_capacity_selector_widget.dart';
import './widgets/room_id_generator_widget.dart';
import './widgets/timeout_selector_widget.dart';

class CreateRoomModal extends StatefulWidget {
  const CreateRoomModal({super.key});

  @override
  State<CreateRoomModal> createState() => _CreateRoomModalState();
}

class _CreateRoomModalState extends State<CreateRoomModal>
    with TickerProviderStateMixin {
  final TextEditingController _descriptionController = TextEditingController();
  String _generatedRoomId = '';
  int _selectedCapacity = 10;
  String _selectedTimeout = '1HR';
  bool _isLoading = false;
  bool _isGeneratingId = false;
  late AnimationController _dotsAnimationController;
  late Animation<int> _dotsAnimation;

  // Mock room data for demonstration
  final List<Map<String, dynamic>> _mockRoomCapacities = [
    {'value': 5, 'label': '5'},
    {'value': 10, 'label': '10'},
    {'value': 25, 'label': '25'},
    {'value': 50, 'label': '50'},
  ];

  final List<Map<String, dynamic>> _mockTimeoutOptions = [
    {'value': '30MIN', 'label': '30MIN'},
    {'value': '1HR', 'label': '1HR'},
    {'value': '4HR', 'label': '4HR'},
    {'value': '24HR', 'label': '24HR'},
  ];

  @override
  void initState() {
    super.initState();
    _generateRoomId();
    _dotsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _dotsAnimation = IntTween(begin: 0, end: 3).animate(
      CurvedAnimation(
        parent: _dotsAnimationController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _dotsAnimationController.dispose();
    super.dispose();
  }

  void _generateRoomId() {
    setState(() {
      _isGeneratingId = true;
    });

    // Simulate network delay for ID generation
    Timer(const Duration(milliseconds: 800), () {
      final random = Random();
      final chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
      _generatedRoomId = List.generate(
        8,
        (index) => chars[random.nextInt(chars.length)],
      ).join();

      setState(() {
        _isGeneratingId = false;
      });
    });
  }

  void _createRoom() async {
    if (_generatedRoomId.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    _dotsAnimationController.repeat();

    // Simulate room creation process
    await Future.delayed(const Duration(seconds: 2));

    _dotsAnimationController.stop();

    // Navigate to chat room screen with room details
    if (mounted) {
      Navigator.pushReplacementNamed(
        context,
        '/chat-room-screen',
        arguments: {
          'roomId': _generatedRoomId,
          'description': _descriptionController.text.trim(),
          'capacity': _selectedCapacity,
          'timeout': _selectedTimeout,
        },
      );
    }
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
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
            'CREATE NEW CHANNEL:',
            style: AppTheme.terminalTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(1.w),
              child: CustomIconWidget(
                iconName: 'close',
                color: AppTheme.primaryTerminal,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Column(
        children: [
          Text(
            'INITIALIZING SECURE CHANNEL',
            style: AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
              letterSpacing: 1.0,
            ),
          ),
          SizedBox(height: 2.h),
          AnimatedBuilder(
            animation: _dotsAnimation,
            builder: (context, child) {
              return Text(
                '.' * (_dotsAnimation.value + 1),
                style: AppTheme.terminalTheme.textTheme.headlineSmall?.copyWith(
                  letterSpacing: 2.0,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DESCRIPTION: (OPTIONAL)',
            style: AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
              letterSpacing: 1.0,
            ),
          ),
          SizedBox(height: 1.h),
          TextField(
            controller: _descriptionController,
            maxLength: 50,
            maxLines: 2,
            style: AppTheme.terminalTheme.textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: 'Enter channel description...',
              counterStyle:
                  AppTheme.terminalTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textMediumEmphasisTerminal,
              ),
              contentPadding: EdgeInsets.all(3.w),
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 6.h,
            child: ElevatedButton(
              onPressed:
                  _isLoading || _generatedRoomId.isEmpty ? null : _createRoom,
              style: AppTheme.terminalTheme.elevatedButtonTheme.style?.copyWith(
                backgroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.disabled)) {
                    return AppTheme.inactiveTerminal;
                  }
                  return AppTheme.primaryTerminal;
                }),
              ),
              child: Text(
                'INITIALIZE ROOM',
                style: AppTheme.terminalTheme.textTheme.labelLarge?.copyWith(
                  color: AppTheme.backgroundTerminal,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
          SizedBox(height: 2.h),
          SizedBox(
            width: double.infinity,
            height: 6.h,
            child: OutlinedButton(
              onPressed: _isGeneratingId ? null : _generateRoomId,
              child: Text(
                _isGeneratingId ? 'GENERATING...' : 'GENERATE NEW ID',
                style: AppTheme.terminalTheme.textTheme.labelLarge?.copyWith(
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundTerminal,
      body: SafeArea(
        child: _isLoading
            ? _buildLoadingIndicator()
            : Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 2.h),
                          RoomIdGeneratorWidget(
                            roomId: _generatedRoomId,
                            isGenerating: _isGeneratingId,
                            onRefresh: _generateRoomId,
                          ),
                          SizedBox(height: 2.h),
                          _buildDescriptionField(),
                          SizedBox(height: 2.h),
                          RoomCapacitySelectorWidget(
                            capacities: _mockRoomCapacities,
                            selectedCapacity: _selectedCapacity,
                            onCapacityChanged: (capacity) {
                              setState(() {
                                _selectedCapacity = capacity;
                              });
                            },
                          ),
                          SizedBox(height: 2.h),
                          TimeoutSelectorWidget(
                            timeoutOptions: _mockTimeoutOptions,
                            selectedTimeout: _selectedTimeout,
                            onTimeoutChanged: (timeout) {
                              setState(() {
                                _selectedTimeout = timeout;
                              });
                            },
                          ),
                          SizedBox(height: 4.h),
                        ],
                      ),
                    ),
                  ),
                  _buildActionButtons(),
                ],
              ),
      ),
    );
  }
}
