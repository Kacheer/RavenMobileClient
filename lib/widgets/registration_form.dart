import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  final Future<void> Function({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? username,
  }) onRegister;
  final bool isLoading;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  const RegistrationForm({
    super.key,
    required this.onRegister,
    required this.isLoading,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.firstNameController,
    required this.lastNameController,
  });

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  String? _validateNotEmpty(String? v, String field) {
    if (v == null || v.trim().isEmpty) return 'Введите $field';
    return null;
  }

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Введите email';
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(v.trim())) return 'Некорректный email';
    return null;
  }

  String? _validatePassword(String? v) {
    if (v == null || v.isEmpty) return 'Введите пароль';
    if (v.length < 6) return 'Минимум 6 символов';
    return null;
  }

  String? _validateConfirm(String? v) {
    if (v != widget.passwordController.text) return 'Пароли не совпадают';
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final firstName = widget.firstNameController.text.trim();
    final lastName = widget.lastNameController.text.trim();
    final email = widget.emailController.text.trim();
    final password = widget.passwordController.text;
    final username = widget.usernameController.text.trim().isEmpty
        ? null
        : widget.usernameController.text.trim();

    await widget.onRegister(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      username: username,
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
              controller: widget.firstNameController,
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
              controller: widget.lastNameController,
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
              validator: _validateConfirm,
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