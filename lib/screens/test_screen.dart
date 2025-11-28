import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../routes.dart';
import '../storage/secure_storage_service.dart';
import '../themes/theme_notifier.dart';
import '../themes/app_colors.dart';

class TestScreen extends StatelessWidget {
  TestScreen({super.key});

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
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDark = themeNotifier.isDark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue, width: 2),
                image: const DecorationImage(
                  image: NetworkImage('https://otvet.imgsmail.ru/download/304796237_5534b3bdced682da483b9a93a0ce7a67.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text('Raven', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28, color: AppColors.text(isDark))),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: AppColors.text(isDark)),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.addFriend),
          ),
          IconButton(
            icon: Icon(themeNotifier.isDark ? Icons.light_mode : Icons.dark_mode, color: AppColors.text(isDark)),
            onPressed: () => themeNotifier.toggle(),
          ),
        ],
        backgroundColor: AppColors.appBar(isDark),
      ),
      backgroundColor: AppColors.background(isDark),
      body: ListView.builder(
        itemCount: _chats.length,
        itemBuilder: (context, index) {
          final chat = _chats[index];
          return ListTile(
            leading: CircleAvatar(radius: 28, backgroundImage: NetworkImage(chat['avatar'])),
            title: Text(chat['name'], style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.text(isDark))),
            subtitle: Text(chat['message'], style: TextStyle(color: AppColors.hint(isDark))),
            trailing: Text(chat['time'], style: TextStyle(color: AppColors.hint(isDark))),
            onTap: () => print('Открыт чат с ${chat['name']}'),
          );
        },
      ),
    );
  }
}