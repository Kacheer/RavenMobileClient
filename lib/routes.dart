import 'package:flutter/material.dart';
import 'screens/registration_screen.dart';
import 'screens/test_screen.dart';
import 'screens/add_friend_screen.dart';
import 'screens/create_group_chat_screen.dart'; // Добавьте этот импорт

class AppRoutes {
  static const String registration = '/registration';
  static const String test = '/test';
  static const String addFriend = '/add-friend';
  static const String createGroupChat = '/create-group-chat';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case registration:
        return MaterialPageRoute(builder: (_) => const RegistrationScreen());
      case test:
        return MaterialPageRoute(builder: (_) => TestScreen());
      case createGroupChat:
        return MaterialPageRoute(builder: (_) => const CreateGroupChatScreen());
      case addFriend:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const AddFriendScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final slideAnimation = Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInQuad,
            ));
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 300),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}