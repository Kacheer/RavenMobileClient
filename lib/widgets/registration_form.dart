import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  final VoidCallback onRegister;
  final bool isLoading;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const RegistrationForm({
    super.key,
    required this.onRegister,
    required this.isLoading,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

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
              controller: widget.usernameController,
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
              controller: widget.emailController,
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
              controller: widget.passwordController,
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
                if (value.length < 6) {
                  return 'Пароль должен быть не менее 6 символов';
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
              controller: widget.confirmPasswordController,
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
                if (value != widget.passwordController.text) {
                  return 'Пароли не совпадают';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.isLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          print('🚀 Попытка регистрации: ${widget.usernameController.text}, ${widget.emailController.text}');
                          widget.onRegister();
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
                child: widget.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 48, 55, 78)),
                        ),
                      )
                    : const Text('Зарегистрироваться'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}