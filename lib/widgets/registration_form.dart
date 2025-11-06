import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: _formKey,
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
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Ваше имя',
                hintStyle: TextStyle(color: Color(0xFF7B818A)),
                filled: true,
                fillColor: Color(0x80121212),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
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
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Введите вашу эл. почту',
                hintStyle: TextStyle(color: Color(0xFF7B818A)),
                filled: true,
                fillColor: Color(0x80121212),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
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
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Введите свой пароль',
                hintStyle: TextStyle(color: Color(0xFF7B818A)),
                filled: true,
                fillColor: Color(0x80121212),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
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
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Введите пароль ещё раз',
                hintStyle: TextStyle(color: Color(0xFF7B818A)),
                filled: true,
                fillColor: Color(0x80121212),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
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
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Логика регистрации (добавь API)
                    print('Регистрация: ${_usernameController.text}, ${_emailController.text}, ${_passwordController.text}');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA0B8FF),
                  foregroundColor: const Color.fromARGB(255, 48, 55, 78),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Зарегистрироваться'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}