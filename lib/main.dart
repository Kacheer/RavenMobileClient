import 'package:flutter/material.dart';
import 'screens/registration_screen.dart'; // Импорт экрана

void main() {
  runApp(const MyApp()); // Запускаем корневой виджет приложения.
}

// Это корневой виджет приложения. Он Stateless, так как не меняет состояние.
// Здесь оборачиваем всё в MaterialApp для тем, навигации и т.д.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Мессенджер', // Название приложения (показывается в таск-менеджере).
      theme: ThemeData(
        primarySwatch: Colors.blue, // Базовая тема (можно кастомизировать).
      ),
      home: const RegistrationScreen(), // Здесь указываем стартовый экран.
      debugShowCheckedModeBanner: false, // Убираем debug-баннер (опционально).
    );
  }
}