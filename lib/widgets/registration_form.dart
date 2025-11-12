import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final Future<void> Function({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? username,
  }) onRegister;
  final bool isLoading;

  const RegistrationForm({
    super.key,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onRegister,
    required this.isLoading,
  });

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  String? _validateNotEmpty(String? value, String field) {
    if (value == null || value.trim().isEmpty) {
      return 'Введите $field';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Введите email';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value.trim())) return 'Некорректный email';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Введите пароль';
    if (value.length < 6) return 'Минимум 6 символов';
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != widget.passwordController.text) {
      return 'Пароли не совпадают';
    }
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    await widget.onRegister(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: widget.emailController.text.trim(),
      password: widget.passwordController.text,
      username: widget.usernameController.text.trim().isEmpty
          ? null
          : widget.usernameController.text.trim(),
    );
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
            const Text('Имя', style: TextStyle(color: Color(0xFF7B818A), fontSize: 16)),
            const SizedBox(height: 10),
            TextFormField(
              controller: _firstNameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Введите имя',
                hintStyle: TextStyle(color: Color(0xFF7B818A)),
                filled: true,
                fillColor: Color(0x80121212),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (v) => _validateNotEmpty(v, 'имя'),
            ),
            const SizedBox(height: 20),

            const Text('Фамилия', style: TextStyle(color: Color(0xFF7B818A), fontSize: 16)),
            const SizedBox(height: 10),
            TextFormField(
              controller: _lastNameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Введите фамилию',
                hintStyle: TextStyle(color: Color(0xFF7B818A)),
                filled: true,
                fillColor: Color(0x80121212),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (v) => _validateNotEmpty(v, 'фамилию'),
            ),
            const SizedBox(height: 20),

            const Text('Username (необязательно)', style: TextStyle(color: Color(0xFF7B818A), fontSize: 16)),
            const SizedBox(height: 10),
            TextFormField(
              controller: widget.usernameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Придумайте никнейм',
                hintStyle: TextStyle(color: Color(0xFF7B818A)),
                filled: true,
                fillColor: Color(0x80121212),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text('Эл. Почта', style: TextStyle(color: Color(0xFF7B818A), fontSize: 16)),
            const SizedBox(height: 10),
            TextFormField(
              controller: widget.emailController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Введите email',
                hintStyle: TextStyle(color: Color(0xFF7B818A)),
                filled: true,
                fillColor: Color(0x80121212),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: _validateEmail,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),

            const Text('Пароль', style: TextStyle(color: Color(0xFF7B818A), fontSize: 16)),
            const SizedBox(height: 10),
            TextFormField(
              controller: widget.passwordController,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Минимум 6 символов',
                hintStyle: TextStyle(color: Color(0xFF7B818A)),
                filled: true,
                fillColor: Color(0x80121212),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: _validatePassword,
            ),
            const SizedBox(height: 20),

            const Text('Подтвердите пароль', style: TextStyle(color: Color(0xFF7B818A), fontSize: 16)),
            const SizedBox(height: 10),
            TextFormField(
              controller: widget.confirmPasswordController,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Повторите пароль',
                hintStyle: TextStyle(color: Color(0xFF7B818A)),
                filled: true,
                fillColor: Color(0x80121212),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: _validateConfirmPassword,
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA0B8FF),
                  foregroundColor: const Color.fromARGB(255, 48, 55, 78),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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