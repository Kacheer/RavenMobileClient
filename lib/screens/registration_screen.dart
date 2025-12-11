import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../api/auth_service.dart';
import '../storage/secure_storage_service.dart';
import '../routes.dart';
import '../widgets/logo_widget.dart';
import '../widgets/subtitle_widget.dart';
import '../widgets/auth_container.dart';

/// Экран регистрации и входа. Обрабатывает форму через AuthContainer.
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final AuthService _authService = AuthService();
  final SecureStorageService _storageService = SecureStorageService();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    if (kDebugMode) {
      print('RegistrationScreen: initState');
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? username,
  }) async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    try {
      if (kDebugMode) print('Регистрация: $email, имя=$firstName $lastName');
      final result = await _authService.register(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        username: username,
      );

      final token = result['Token']?.toString();
      if (token == null) throw Exception('Токен не получен');

  await _storageService.writeData('auth_token', token);

      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.test);
      }
    } catch (e, st) {
      if (kDebugMode) print('Ошибка регистрации: $e\n$st');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ошибка регистрации: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleLogin() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    try {
      if (kDebugMode) print('Вход: $email');
  final result = await _authService.login(email: email, password: password);

      final token = result['Token']?.toString();
      if (token == null) throw Exception('Токен не получен');

  await _storageService.writeData('auth_token', token);

      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.test);
      }
    } catch (e, st) {
      if (kDebugMode) print('Ошибка входа: $e\n$st');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ошибка входа: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const LogoWidget(),
                  const SizedBox(height: 10),
                  const SubtitleWidget(),
                  const SizedBox(height: 30),
                  AuthContainer(
                    tabController: _tabController,
                    usernameController: _usernameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                    firstNameController: _firstNameController,
                    lastNameController: _lastNameController,
                    onRegister: ({required String firstName, required String lastName, required String email, required String password, String? username}) {
                      return _handleRegister(firstName: firstName, lastName: lastName, email: email, password: password, username: username);
                    },
                    onLogin: () => _handleLogin(),
                    isLoading: _isLoading,
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}