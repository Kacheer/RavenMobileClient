import 'package:flutter/material.dart';

// Модель для чата
class ChatModel {
  final String avatarPath; // Путь к аватару
  final String name; // Имя пользователя/группы
  final String lastMessage; // Последнее сообщение
  final String time; // Время
  final IconData securityIcon; // Иконка защиты
  final Color securityColor; // Цвет иконки

  ChatModel({
    required this.avatarPath,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.securityIcon,
    required this.securityColor,
  });

  /// Создаёт модель из JSON-ответа сервера.
  ///
  /// Поддерживает несколько возможных ключей, потому что API может возвращать
  /// данные в разных форматах. Для полей, которые нельзя напрямую десериализовать
  /// (иконка/цвет), используются простые эвристики по значению поля `security`.
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    final avatar = json['avatar'] ?? json['avatarPath'] ?? json['avatar_url'] ?? '';
    final name = json['name'] ?? json['title'] ?? json['chat_name'] ?? 'Без имени';
    final lastMessage = json['lastMessage'] ?? json['last_message'] ?? json['last'] ?? '';
    final time = json['time'] ?? json['updated_at'] ?? json['last_time'] ?? '';

    // Простая логика для определения иконки/цвета безопасности.
    final securityValue = (json['security'] ?? json['status'] ?? json['privacy'])?.toString().toLowerCase() ?? '';
    IconData icon = Icons.lock_open;
    Color color = Colors.grey;

    if (securityValue.contains('secure') || securityValue.contains('private') || securityValue.contains('lock')) {
      icon = Icons.lock;
      color = Colors.green;
    } else if (securityValue.contains('warn') || securityValue.contains('danger') || securityValue.contains('warning')) {
      icon = Icons.warning;
      color = Colors.red;
    }

    return ChatModel(
      avatarPath: avatar.toString(),
      name: name.toString(),
      lastMessage: lastMessage.toString(),
      time: time.toString(),
      securityIcon: icon,
      securityColor: color,
    );
  }
}