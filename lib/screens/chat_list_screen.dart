import 'package:flutter/material.dart';
import '../widgets/chat_header_widget.dart'; // Шапка
import '../widgets/chat_search_bar.dart'; // Поиск
import '../widgets/chat_item.dart'; // Элемент чата
import '../models/chat_model.dart'; // Модель для чата

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  // Mock-данные для чатов (замени на реальные из API или DB)
  final List<ChatModel> _chats = [
    ChatModel(
      avatarPath: 'assets/user_avatar1.png', // Замени на реальный ассет
      name: 'Пользователь 1',
      lastMessage: 'Привет, как дела?',
      time: '10:30',
      securityIcon: Icons.lock, // Защищено
      securityColor: Colors.green,
    ),
    ChatModel(
      avatarPath: 'assets/group_avatar.png',
      name: 'Группа друзей',
      lastMessage: 'Встреча завтра?',
      time: 'Вчера',
      securityIcon: Icons.warning, // Угроза
      securityColor: Colors.red,
    ),
    // Добавь больше...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000), // Фон #000000 как в макете
      body: Column(
        children: [
          const ChatHeaderWidget(), // Компонент шапки
          const ChatSearchBar(), // Компонент поиска
          Expanded(
            child: ListView.builder(
              itemCount: _chats.length,
              itemBuilder: (context, index) {
                return ChatItem(chat: _chats[index]); // Компонент элемента чата
              },
            ),
          ),
        ],
      ),
    );
  }
}