import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});
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
              width: 48, // 2 × radius
              height: 48, // 2 × radius
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.blue, // Цвет обводки
                  width: 2, // Толщина обводки
                ),
                image: DecorationImage(
                  image: NetworkImage('https://otvet.imgsmail.ru/download/304796237_5534b3bdced682da483b9a93a0ce7a67.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16), // Отступ между аватаром и текстом
            Text('Raven', style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 28
            ),),
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
      body: Center(
        child: ListTile(),
      ),
    );
  }
}
