import 'package:flutter/material.dart';
import 'screens/registration_screen.dart';
import 'screens/test_screen.dart';
import 'screens/chat_list_screen.dart';
import 'screens/create_group_chat_screen.dart';

class AppRoutes {
  static const String registration = '/registration';
  static const String test = '/test';
  static const String chatList = '/chat_list';
  static const String createGroupChat = '/create_group_chat';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case registration:
        return MaterialPageRoute(builder: (_) => const RegistrationScreen());
      case test:
        return MaterialPageRoute(builder: (_) => TestScreen());  // Убрано const
      case chatList:
        return MaterialPageRoute(builder: (_) => const ChatListScreen());
      case createGroupChat:
        return MaterialPageRoute(builder: (_) => const CreateGroupChatScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}