import 'package:flutter/material.dart';
import 'dart:ui'; // Добавлен импорт для ImageFilter
import '../routes.dart';
import '../storage/secure_storage_service.dart';

class TestScreen extends StatelessWidget {
  TestScreen({super.key}); // Убрано 'const' из конструктора

  // Фиктивные данные для чатов (замени на реальные из API)
  final List<Map<String, dynamic>> _chats = [
    {
      'avatar': 'https://otvet.imgsmail.ru/download/304796237_5534b3bdced682da483b9a93a0ce7a67.jpg',
      'name': 'John Doe',
      'message': 'Привет, как дела?',
      'time': '10:30',
    },
    {
      'avatar': 'https://otvet.imgsmail.ru/download/304796237_5534b3bdced682da483b9a93a0ce7a67.jpg',
      'name': 'Jane Smith',
      'message': 'Увидимся завтра!',
      'time': 'Вчера',
    },
    {
      'avatar': 'https://otvet.imgsmail.ru/download/304796237_5534b3bdced682da483b9a93a0ce7a67.jpg',
      'name': 'Alex Johnson',
      'message': 'Спасибо за помощь.',
      'time': 'Понедельник',
    },
    {
      'avatar': 'https://otvet.imgsmail.ru/download/304796237_5534b3bdced682da483b9a93a0ce7a67.jpg',
      'name': 'Emily Davis',
      'message': 'Проверь почту.',
      'time': '12:45',
    },
    {
      'avatar': 'https://otvet.imgsmail.ru/download/304796237_5534b3bdced682da483b9a93a0ce7a67.jpg',
      'name': 'Michael Brown',
      'message': 'Ок, согласен.',
      'time': '13:00',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Убираем стрелку «назад»
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.blue,
                  width: 2,
                ),
                image: DecorationImage(
                  image: NetworkImage('https://otvet.imgsmail.ru/download/304796237_5534b3bdced682da483b9a93a0ce7a67.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16),
            Text(
              'Raven',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: _chats.length,
        itemBuilder: (context, index) {
          final chat = _chats[index];
          return ListTile(
            leading: CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(chat['avatar']),
            ),
            title: Text(
              chat['name'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(chat['message']),
            trailing: Text(chat['time']),
            onTap: () {
              // Переход в чат (добавь Navigator.push к экрану чата)
              print('Открыт чат с ${chat['name']}');
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddFriendDialog(context);
        },
        child: Icon(Icons.person_add),
        tooltip: 'Добавить друга',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // Модалка добавления друга (оптимизированная версия из CodeTea)
  void _showAddFriendDialog(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();

    showDialog(
      context: context,
      barrierColor: Color(0x3B000000), // Полупрозрачный оверлей
      builder: (BuildContext context) {
        return Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(29),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Размытие (если нужно)
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8, // Адаптивно
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(29),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Добавление пользователя в друзья',
                          style: TextStyle(
                            color: Color(0xFF2C2E35),
                            fontSize: 20,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, size: 30),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: Color(0xFFF5F5F5),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(Icons.search, size: 24), // Иконка поиска
                          ),
                          Expanded(
                            child: TextField(
                              controller: usernameController,
                              style: TextStyle(
                                color: Color(0xFF7B818A),
                                fontSize: 20,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Введите @username...',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    // Плейсхолдер для результатов поиска (можно заменить на ListView)
                    Container(
                      width: double.infinity,
                      height: 22,
                      color: Colors.grey[200], // Пустой блок, как в макете
                      child: Center(child: Text('Результаты поиска появятся здесь')),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final username = usernameController.text;
                          if (username.isNotEmpty) {
                            print('Отправлена заявка: $username');
                            Navigator.of(context).pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF8196FF),
                          padding: EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Отправить заявку в друзья',
                          style: TextStyle(
                            color: Color(0xFFE8E8FF),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}