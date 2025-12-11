import 'package:flutter/material.dart';
import '../models/chat_model.dart';

class ChatItem extends StatelessWidget {
  final ChatModel chat; // Prop: данные чата

  const ChatItem({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF121212), // Фон элемента #121212
        borderRadius: BorderRadius.circular(9),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        children: [
          Image.asset(
            chat.avatarPath, // Аватар
            width: 53,
            height: 53,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat.name, // Имя
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(
                  chat.lastMessage, // Сообщение
                  style: const TextStyle(color: Color(0xFFA5ADB8), fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                chat.time, // Время
                style: const TextStyle(color: Color(0xFF7B818A), fontSize: 12),
              ),
              const SizedBox(height: 5),
              Icon(
                chat.securityIcon, // Иконка защиты
                color: chat.securityColor,
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}