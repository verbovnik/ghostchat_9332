import 'package:flutter/material.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/chat_room_list_screen/chat_room_list_screen.dart';
import '../presentation/nickname_entry_screen/nickname_entry_screen.dart';
import '../presentation/create_room_modal/create_room_modal.dart';
import '../presentation/join_room_modal/join_room_modal.dart';
import '../presentation/chat_room_screen/chat_room_screen.dart';

class AppRoutes {
  static const String initial = '/';
  static const String splashScreen = '/splash-screen';
  static const String nicknameEntryScreen = '/nickname-entry-screen';
  static const String chatRoomListScreen = '/chat-room-list-screen';
  static const String createRoomModal = '/create-room-modal';
  static const String joinRoomModal = '/join-room-modal';
  static const String chatRoomScreen = '/chat-room-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    splashScreen: (context) => const SplashScreen(),
    nicknameEntryScreen: (context) => const NicknameEntryScreen(),
    chatRoomListScreen: (context) => const ChatRoomListScreen(),
    createRoomModal: (context) => const CreateRoomModal(),
    joinRoomModal: (context) => const JoinRoomModal(),
    chatRoomScreen: (context) => const ChatRoomScreen(),
  };
}
