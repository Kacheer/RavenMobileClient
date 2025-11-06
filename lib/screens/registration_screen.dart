import 'package:flutter/material.dart'; // Удалён неиспользуемый импорт
import '../widgets/logo_widget.dart'; // Логотип
import '../widgets/subtitle_widget.dart'; // Подзаголовок
import '../widgets/auth_container.dart'; // Контейнер с формами

// Это основной класс виджета для экрана регистрации.
// Он extends StatefulWidget, потому что экран будет иметь состояние (например, для TabController).
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

// Это приватный класс состояния (state) для виджета.
// Здесь хранится логика, переменные состояния и метод build() для отрисовки UI.
class _RegistrationScreenState extends State<RegistrationScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController; // Контроллер для табов (остаётся здесь, т.к. общее для экрана)

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Инициализация
  }

  @override
  void dispose() {
    _tabController.dispose(); // Очистка
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Фоновое изображение
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/BackgroundActivity.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Контент поверх фона с скроллом
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50), // Отступ сверху
                  const LogoWidget(), // Компонент логотипа
                  const SizedBox(height: 10),
                  const SubtitleWidget(), // Компонент подзаголовка
                  const SizedBox(height: 30),
                  AuthContainer(tabController: _tabController), // Компонент контейнера с формами (передаём TabController как prop)
                  const SizedBox(height: 50), // Отступ снизу
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}