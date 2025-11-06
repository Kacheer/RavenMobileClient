import 'package:flutter/material.dart';
import 'screens/registration_screen.dart';
import 'screens/test_screen.dart';

class AppRoutes {
  static const String registration = '/registration';
  static const String test = '/test';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case registration:
        return MaterialPageRoute(builder: (_) => const RegistrationScreen());
      case test:
        return MaterialPageRoute(builder: (_) => const TestScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}