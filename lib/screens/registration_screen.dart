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
  final SecureStorageService _storageService = SecureStorageService();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    print('🔄 RegistrationScreen инициализирован');
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
    if (_isLoading) return;
    
    setState(() {
      _isLoading = true;
    });

    print('🎯 Начало процесса регистрации');
    
    try {
      final data = {
        'username': _usernameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
      };

      print('📝 Данные для регистрации: $data');

      final response = await _authService.register(data);

      print('📊 Ответ получен: ${response.statusCode}');

      if (response.statusCode == 200) {
        final token = response.body;
        print('🔑 Токен получен: ${token.length > 20 ? '${token.substring(0, 20)}...' : token}');
        
        await _storageService.writeData('auth_token', token);
        print('💾 Токен сохранен в Secure Storage');
        
        Navigator.pushNamed(context, AppRoutes.test);
      } else {
        print('❌ Регистрация не удалась: ${response.statusCode}');
        print('📄 Тело ошибки: ${response.body}');
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка регистрации: ${response.body}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('💥 Исключение при регистрации: $e');
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _login() async {
    if (_isLoading) return;
    
    setState(() {
      _isLoading = true;
    });

    print('🎯 Начало процесса входа');
    
    try {
      final data = {
        'email': _emailController.text,
        'password': _passwordController.text,
      };

      print('📝 Данные для входа: $data');

      final response = await _authService.login(data);

      print('📊 Ответ получен: ${response.statusCode}');

      if (response.statusCode == 200) {
        final token = response.body;
        print('🔑 Токен получен: ${token.length > 20 ? '${token.substring(0, 20)}...' : token}');
        
        await _storageService.writeData('auth_token', token);
        print('💾 Токен сохранен в Secure Storage');
        
        Navigator.pushNamed(context, AppRoutes.test);
      } else {
        print('❌ Вход не удался: ${response.statusCode}');
        print('📄 Тело ошибки: ${response.body}');
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка входа: ${response.body}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('💥 Исключение при входе: $e');
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('🏗️ Построение RegistrationScreen');
    
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
                    onRegister: _register,
                    onLogin: _login,
                    isLoading: _isLoading,
                  ),
                  const SizedBox(height: 30),
                  if (_isLoading)
                    const CircularProgressIndicator(),
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