import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Логика входа (добавь API)
                    print('Вход: ${_emailController.text}, ${_passwordController.text}');
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
                child: const Text('Войти'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}