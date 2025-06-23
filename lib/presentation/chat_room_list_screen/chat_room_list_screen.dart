import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/empty_state_widget.dart';
import './widgets/room_list_item_widget.dart';
import './widgets/search_bar_widget.dart';
import './widgets/terminal_header_widget.dart';

class ChatRoomListScreen extends StatefulWidget {
  const ChatRoomListScreen({super.key});

  @override
  State<ChatRoomListScreen> createState() => _ChatRoomListScreenState();
}

class _ChatRoomListScreenState extends State<ChatRoomListScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isConnected = true;
  bool _isLoading = false;
  String _searchQuery = '';
  Timer? _connectionTimer;
  final TextEditingController _searchController = TextEditingController();

  // Mock data for active chat rooms
  final List<Map<String, dynamic>> _activeRooms = [
    {
      "id": "ALPHA7X9",
      "participants": 12,
      "lastActivity": "2m ago",
      "isFull": false,
      "maxCapacity": 50,
    },
    {
      "id": "BETA4K2",
      "participants": 8,
      "lastActivity": "5m ago",
      "isFull": false,
      "maxCapacity": 25,
    },
    {
      "id": "GAMMA1Z8",
      "participants": 25,
      "lastActivity": "1m ago",
      "isFull": true,
      "maxCapacity": 25,
    },
    {
      "id": "DELTA9M3",
      "participants": 3,
      "lastActivity": "15m ago",
      "isFull": false,
      "maxCapacity": 30,
    },
    {
      "id": "ECHO5N7",
      "participants": 18,
      "lastActivity": "8m ago",
      "isFull": false,
      "maxCapacity": 40,
    },
    {
      "id": "FOXTROT2L6",
      "participants": 6,
      "lastActivity": "22m ago",
      "isFull": false,
      "maxCapacity": 20,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _simulateConnectionStatus();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _connectionTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _simulateConnectionStatus() {
    _connectionTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (mounted) {
        setState(() {
          _isConnected = !_isConnected;
        });

        // Auto-reconnect after 3 seconds if disconnected
        if (!_isConnected) {
          Timer(const Duration(seconds: 3), () {
            if (mounted) {
              setState(() {
                _isConnected = true;
              });
            }
          });
        }
      }
    });
  }

  Future<void> _refreshRooms() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<Map<String, dynamic>> get _filteredRooms {
    if (_searchQuery.isEmpty) {
      return _activeRooms;
    }
    return _activeRooms.where((room) {
      final roomId = (room['id'] as String).toLowerCase();
      return roomId.contains(_searchQuery.toLowerCase());
    }).toList();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _joinRoom(String roomId) {
    Navigator.pushNamed(context, '/chat-room-screen',
        arguments: {'roomId': roomId});
  }

  void _shareRoomId(String roomId) {
    // Simulate sharing functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('ROOM_ID: $roomId COPIED TO CLIPBOARD'),
        backgroundColor: AppTheme.backgroundTerminal,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: AppTheme.primaryTerminal, width: 1.0),
        ),
      ),
    );
  }

  void _showRoomInfo(Map<String, dynamic> room) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: AppTheme.backgroundTerminal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: AppTheme.primaryTerminal, width: 1.0),
        ),
        child: Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ROOM INFO:',
                style: AppTheme.terminalTheme.textTheme.titleMedium,
              ),
              SizedBox(height: 2.h),
              Text(
                'ID: ${room['id']}',
                style: AppTheme.terminalTheme.textTheme.bodyMedium,
              ),
              Text(
                'PARTICIPANTS: ${room['participants']}/${room['maxCapacity']}',
                style: AppTheme.terminalTheme.textTheme.bodyMedium,
              ),
              Text(
                'LAST_ACTIVITY: ${room['lastActivity']}',
                style: AppTheme.terminalTheme.textTheme.bodyMedium,
              ),
              Text(
                'STATUS: ${room['isFull'] ? 'FULL' : 'AVAILABLE'}',
                style: AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
                  color: room['isFull']
                      ? AppTheme.errorTerminal
                      : AppTheme.primaryTerminal,
                ),
              ),
              SizedBox(height: 3.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('CLOSE'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createNewRoom() {
    Navigator.pushNamed(context, '/create-room-modal');
  }

  void _joinRoomModal() {
    Navigator.pushNamed(context, '/join-room-modal');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundTerminal,
      body: SafeArea(
        child: Column(
          children: [
            // Terminal Header
            TerminalHeaderWidget(
              isConnected: _isConnected,
            ),

            // Tab Bar
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppTheme.primaryTerminal,
                    width: 1.0,
                  ),
                ),
              ),
              child: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: 'ROOMS'),
                  Tab(text: 'SETTINGS'),
                ],
              ),
            ),

            // Tab Bar View
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Rooms Tab
                  _buildRoomsTab(),

                  // Settings Tab
                  _buildSettingsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _tabController.index == 0
          ? FloatingActionButton(
              onPressed: _createNewRoom,
              backgroundColor: AppTheme.backgroundTerminal,
              foregroundColor: AppTheme.primaryTerminal,
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
                side: BorderSide(color: AppTheme.primaryTerminal, width: 1.0),
              ),
              child: CustomIconWidget(
                iconName: 'add',
                color: AppTheme.primaryTerminal,
                size: 24,
              ),
            )
          : null,
    );
  }

  Widget _buildRoomsTab() {
    if (!_isConnected) {
      return _buildDisconnectedState();
    }

    return Column(
      children: [
        // Search Bar
        SearchBarWidget(
          controller: _searchController,
          onChanged: _onSearchChanged,
        ),

        // Room List
        Expanded(
          child: _filteredRooms.isEmpty
              ? EmptyStateWidget(
                  onCreateRoom: _createNewRoom,
                  onJoinRoom: _joinRoomModal,
                )
              : RefreshIndicator(
                  onRefresh: _refreshRooms,
                  color: AppTheme.primaryTerminal,
                  backgroundColor: AppTheme.backgroundTerminal,
                  child: ListView.separated(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                    itemCount: _filteredRooms.length,
                    separatorBuilder: (context, index) => SizedBox(height: 1.h),
                    itemBuilder: (context, index) {
                      final room = _filteredRooms[index];
                      return RoomListItemWidget(
                        room: room,
                        onTap: () => _joinRoom(room['id']),
                        onLongPress: () => _showContextMenu(room),
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildSettingsTab() {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SYSTEM SETTINGS:',
            style: AppTheme.terminalTheme.textTheme.titleMedium,
          ),
          SizedBox(height: 3.h),
          _buildSettingItem('AUTO_RECONNECT', 'ENABLED'),
          _buildSettingItem('NOTIFICATION', 'DISABLED'),
          _buildSettingItem('SOUND_EFFECTS', 'ENABLED'),
          _buildSettingItem('HAPTIC_FEEDBACK', 'ENABLED'),
          SizedBox(height: 4.h),
          Text(
            'PRIVACY SETTINGS:',
            style: AppTheme.terminalTheme.textTheme.titleMedium,
          ),
          SizedBox(height: 3.h),
          _buildSettingItem('DATA_PERSISTENCE', 'DISABLED'),
          _buildSettingItem('ANALYTICS', 'DISABLED'),
          _buildSettingItem('CRASH_REPORTS', 'DISABLED'),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String setting, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            setting,
            style: AppTheme.terminalTheme.textTheme.bodyMedium,
          ),
          Text(
            value,
            style: AppTheme.terminalTheme.textTheme.bodyMedium?.copyWith(
              color: value == 'ENABLED'
                  ? AppTheme.primaryTerminal
                  : AppTheme.errorTerminal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisconnectedState() {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'wifi_off',
            color: AppTheme.errorTerminal,
            size: 48,
          ),
          SizedBox(height: 2.h),
          Text(
            'CONNECTION LOST',
            style: AppTheme.terminalTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.errorTerminal,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'ATTEMPTING TO RECONNECT...',
            style: AppTheme.terminalTheme.textTheme.bodyMedium,
          ),
          SizedBox(height: 3.h),
          LinearProgressIndicator(
            color: AppTheme.primaryTerminal,
            backgroundColor: AppTheme.inactiveTerminal,
          ),
        ],
      ),
    );
  }

  void _showContextMenu(Map<String, dynamic> room) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.backgroundTerminal,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(color: AppTheme.primaryTerminal, width: 1.0),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'ROOM: ${room['id']}',
              style: AppTheme.terminalTheme.textTheme.titleMedium,
            ),
            SizedBox(height: 3.h),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'login',
                color: AppTheme.primaryTerminal,
                size: 20,
              ),
              title: Text(
                'JOIN ROOM',
                style: AppTheme.terminalTheme.textTheme.bodyMedium,
              ),
              onTap: () {
                Navigator.pop(context);
                _joinRoom(room['id']);
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'share',
                color: AppTheme.primaryTerminal,
                size: 20,
              ),
              title: Text(
                'SHARE ROOM ID',
                style: AppTheme.terminalTheme.textTheme.bodyMedium,
              ),
              onTap: () {
                Navigator.pop(context);
                _shareRoomId(room['id']);
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'info',
                color: AppTheme.primaryTerminal,
                size: 20,
              ),
              title: Text(
                'ROOM INFO',
                style: AppTheme.terminalTheme.textTheme.bodyMedium,
              ),
              onTap: () {
                Navigator.pop(context);
                _showRoomInfo(room);
              },
            ),
          ],
        ),
      ),
    );
  }
}