import 'package:flutter/material.dart';
import '../widgets/logo_widget.dart';
import '../widgets/subtitle_widget.dart';
import '../widgets/auth_container.dart';
import '../api/auth_service.dart';
import '../routes.dart';
import '../storage/secure_storage_service.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final AuthService _authService = AuthService();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final data = {
      'username': _usernameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
    };

    final response = await _authService.register(data);

    if (response.statusCode == 200) {
      final token = response.body; // Assuming the token is in the response body
      await SecureStorageService().writeData('auth_token', token);
      Navigator.pushNamed(context, AppRoutes.test);
    } else {
      print('Registration failed: ${response.body}');
    }
  }

  Future<void> _login() async {
    final data = {
      'email': _emailController.text,
      'password': _passwordController.text,
    };

    final response = await _authService.login(data);

    if (response.statusCode == 200) {
      final token = response.body; // Assuming the token is in the response body
      await SecureStorageService().writeData('auth_token', token);
      Navigator.pushNamed(context, AppRoutes.test);
    } else {
      print('Login failed: ${response.body}');
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
                  AuthContainer(tabController: _tabController),
                  const SizedBox(height: 30),
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