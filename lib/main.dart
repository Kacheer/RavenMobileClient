import 'dart:ui'; // Добавь для ImageFilter.blur
import 'package:flutter/material.dart';
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
      home: const RegistrationScreen(), // Здесь указываем стартовый экран (твой RegistrationScreen).
      debugShowCheckedModeBanner: false, // Убираем debug-баннер (опционально).
    );
  }
}

// Это основной класс виджета для экрана регистрации.
// Он extends StatefulWidget, потому что экран будет иметь состояние (например, для форм).
class RegistrationScreen extends StatefulWidget {
  // Здесь можно добавить конструктор, если нужно передавать параметры извне.
  // Например: const RegistrationScreen({super.key});
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

// Это приватный класс состояния (state) для виджета.
// Здесь хранится логика, переменные состояния и метод build() для отрисовки UI.
class _RegistrationScreenState extends State<RegistrationScreen> with SingleTickerProviderStateMixin {
  // Контроллеры для полей формы
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Ключи для форм (отдельные для каждого таба, чтобы избежать конфликтов)
  final _loginFormKey = GlobalKey<FormState>();
  final _registerFormKey = GlobalKey<FormState>();

  // Контроллер для TabBar
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Инициализация TabController с 2 табами
    _tabController = TabController(length: 2, vsync: this);
    // Здесь инициализируй состояние при создании экрана.
    // Например, добавь слушатели к контроллерам или загрузи данные.
  }

  @override
  void dispose() {
    // Очистка контроллеров
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _tabController.dispose();
    super.dispose();
    // Здесь очищай ресурсы при удалении экрана.
  }

  // Это основной метод, где строится UI.
  // Он вызывается каждый раз, когда состояние меняется (setState()).
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Фоновое изображение (проверь путь в pubspec.yaml)
          Container(
            width: double.infinity, // Растягиваем по ширине
            height: double.infinity, // Растягиваем по высоте
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/BackgroundActivity.png'), // Исправленный путь — проверь и подставь свой.
                fit: BoxFit.cover, // Покрывает весь экран
              ),
            ),
          ),
          // Контент поверх фона с скроллом
          SingleChildScrollView( // Для скролла всего экрана
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50), // Отступ сверху для баланса
                  // Логотип и текст "Raven" в ряд
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/Raven.png', // Путь к логотипу Raven (проверь в pubspec.yaml)
                        width: 50, // Ширина логотипа
                        height: 50, // Высота логотипа
                      ),
                      const SizedBox(width: 10), // Отступ между логотипом и текстом
                      const Text(
                        'Raven',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Roboto', // Убедись, что шрифт добавлен в pubspec.yaml
                          color: Colors.white, // Цвет текста
                          shadows: [
                            Shadow(
                              offset: Offset(2, 2),
                              blurRadius: 3,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10), // Отступ
                  // Подзаголовок
                  const Text(
                    'Платформа безопасного общения',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color.fromARGB(255, 156, 163, 175), // Серый цвет
                    ),
                  ),
                  const SizedBox(height: 30), // Отступ перед формой

                  // Форма с табами и glassmorphism (размытие + полупрозрачный фон)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15), // Отступы по бокам
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25), // Скругление контейнера
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25), // Скругление для клипа
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Размытие для glassmorphism
                        child: Container(
                          color: const Color(0x330A0A0A), // Полупрозрачный фон #0A0A0A33
                          child: Column(
                            children: [
                              // Табы (row-view)
                              TabBar(
                                controller: _tabController,
                                indicatorColor: const Color(0xFFA0B8FF), // Синяя линия под активным табом
                                indicatorSize: TabBarIndicatorSize.label, // Линия под текстом
                                labelColor: Colors.white, // Активный таб белый
                                unselectedLabelColor: const Color(0xFF7B818A), // Неактивный серый
                                tabs: const [
                                  Tab(text: 'Вход'), // Первый таб
                                  Tab(text: 'Регистрация'), // Второй таб
                                ],
                              ),
                              // Содержимое табов (TabBarView с увеличенной высотой и внутренним скроллом)
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.6, // Динамическая высота (60% экрана, чтобы была подлиннее)
                                child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    // Таб "Вход" (только email и пароль) с внутренним скроллом
                                    SingleChildScrollView(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Form(
                                        key: _loginFormKey,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Эл. Почта',
                                              style: TextStyle(color: Color(0xFF7B818A), fontSize: 16),
                                            ),
                                            const SizedBox(height: 10),
                                            TextFormField(
                                              controller: _emailController,
                                              style: const TextStyle(color: Colors.white), // Изменение цвета текста на белый
                                              decoration: InputDecoration(
                                                hintText: 'Введите вашу эл. почту',
                                                hintStyle: const TextStyle(color: Color(0xFF7B818A)),
                                                filled: true,
                                                fillColor: const Color(0x80121212),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                  borderSide: BorderSide.none,
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Пожалуйста, введите email';
                                                }
                                                return null;
                                              },
                                            ),
                                            const SizedBox(height: 20),
                                            const Text(
                                              'Пароль',
                                              style: TextStyle(color: Color(0xFF7B818A), fontSize: 16),
                                            ),
                                            const SizedBox(height: 10),
                                            TextFormField(
                                              controller: _passwordController,
                                              obscureText: true, // Для пароля
                                              style: const TextStyle(color: Colors.white), // Изменение цвета текста на белый
                                              decoration: InputDecoration(
                                                hintText: 'Введите свой пароль',
                                                hintStyle: const TextStyle(color: Color(0xFF7B818A)),
                                                filled: true,
                                                fillColor: const Color(0x80121212),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                  borderSide: BorderSide.none,
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Пожалуйста, введите пароль';
                                                }
                                                return null;
                                              },
                                            ),
                                            const SizedBox(height: 30),
                                            SizedBox(
                                              width: double.infinity, // Кнопка растянута на ширину полей
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  if (_loginFormKey.currentState!.validate()) {
                                                    // Логика входа (добавь API)
                                                    print('Вход: ${_emailController.text}, ${_passwordController.text}');
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: const Color(0xFFA0B8FF), // Цвет #A0B8FF (160, 184, 255)
                                                  foregroundColor: const Color.fromARGB(255, 48, 55, 78),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10), // Закругление как у полей
                                                  ),
                                                  padding: const EdgeInsets.symmetric(vertical: 16), // Высота кнопки
                                                ),
                                                child: const Text('Войти'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Таб "Регистрация" (все поля) с внутренним скроллом
                                    SingleChildScrollView(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Form(
                                        key: _registerFormKey,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Имя пользователя',
                                              style: TextStyle(color: Color(0xFF7B818A), fontSize: 16),
                                            ),
                                            const SizedBox(height: 10),
                                            TextFormField(
                                              controller: _usernameController,
                                              style: const TextStyle(color: Colors.white), // Изменение цвета текста на белый
                                              decoration: InputDecoration(
                                                hintText: 'Ваше имя',
                                                hintStyle: const TextStyle(color: Color(0xFF7B818A)),
                                                filled: true,
                                                fillColor: const Color(0x80121212),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                  borderSide: BorderSide.none,
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Пожалуйста, введите имя';
                                                }
                                                return null;
                                              },
                                            ),
                                            const SizedBox(height: 20),
                                            const Text(
                                              'Эл. Почта',
                                              style: TextStyle(color: Color(0xFF7B818A), fontSize: 16),
                                            ),
                                            const SizedBox(height: 10),
                                            TextFormField(
                                              controller: _emailController,
                                              decoration: InputDecoration(
                                                hintText: 'Введите вашу эл. почту',
                                                hintStyle: const TextStyle(color: Color(0xFF7B818A)),
                                                filled: true,
                                                fillColor: const Color(0x80121212),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                  borderSide: BorderSide.none,
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Пожалуйста, введите email';
                                                }
                                                return null;
                                              },
                                            ),
                                            const SizedBox(height: 20),
                                            const Text(
                                              'Пароль',
                                              style: TextStyle(color: Color(0xFF7B818A), fontSize: 16),
                                            ),
                                            const SizedBox(height: 10),
                                            TextFormField(
                                              controller: _passwordController,
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                hintText: 'Введите свой пароль',
                                                hintStyle: const TextStyle(color: Color(0xFF7B818A)),
                                                filled: true,
                                                fillColor: const Color(0x80121212),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                  borderSide: BorderSide.none,
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Пожалуйста, введите пароль';
                                                }
                                                return null;
                                              },
                                            ),
                                            const SizedBox(height: 20),
                                            const Text(
                                              'Подтверждение пароля',
                                              style: TextStyle(color: Color(0xFF7B818A), fontSize: 16),
                                            ),
                                            const SizedBox(height: 10),
                                            TextFormField(
                                              controller: _confirmPasswordController,
                                              obscureText: true,
                                              style: const TextStyle(color: Colors.white), // Изменение цвета текста на белый
                                              decoration: InputDecoration(
                                                hintText: 'Введите пароль ещё раз',
                                                hintStyle: const TextStyle(color: Color(0xFF7B818A)),
                                                filled: true,
                                                fillColor: const Color(0x80121212),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                  borderSide: BorderSide.none,
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Пожалуйста, подтвердите пароль';
                                                }
                                                if (value != _passwordController.text) {
                                                  return 'Пароли не совпадают';
                                                }
                                                return null;
                                              },
                                            ),
                                            const SizedBox(height: 30),
                                            SizedBox(
                                              width: double.infinity, // Кнопка растянута на ширину полей
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  if (_registerFormKey.currentState!.validate()) {
                                                    // Логика регистрации (добавь API)
                                                    print('Регистрация: ${_usernameController.text}, ${_emailController.text}, ${_passwordController.text}');
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: const Color(0xFFA0B8FF), // Цвет #A0B8FF (160, 184, 255)
                                                  foregroundColor: const Color.fromARGB(255, 48, 55, 78),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10), // Закругление как у полей
                                                  ),
                                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                                ),
                                                child: const Text('Зарегистрироваться'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50), // Отступ снизу для баланса
                ],
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: Здесь добавь плавающую кнопку, если нужно.
      // bottomNavigationBar: Здесь добавь нижнюю навигацию, если нужно.
    );
  }

  // Здесь добавляй методы для логики.
  // Например:
  // void _register() {
  //   setState(() { _isLoading = true; }); // Изменение состояния — вызовет перерисовку build().
  //   // Логика регистрации (API вызов и т.д.).
  // }
}