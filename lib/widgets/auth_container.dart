import 'package:flutter/material.dart';
import 'dart:ui';
import './login_form.dart';
import './registration_form.dart';

class AuthContainer extends StatelessWidget {
  final TabController tabController;
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
  final VoidCallback onLogin;
  final bool isLoading;

  const AuthContainer({
    super.key,
    required this.tabController,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onRegister,
    required this.onLogin,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            color: const Color(0x330A0A0A),
            child: Column(
              children: [
                TabBar(
                  controller: tabController,
                  indicatorColor: const Color(0xFFA0B8FF),
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: Colors.white,
                  unselectedLabelColor: const Color(0xFF7B818A),
                  tabs: const [
                    Tab(text: 'Вход'),
                    Tab(text: 'Регистрация'),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      LoginForm(
                        onLogin: onLogin,
                        isLoading: isLoading,
                        emailController: emailController,
                        passwordController: passwordController,
                      ),
                      RegistrationForm(
                        onRegister: onRegister,
                        isLoading: isLoading,
                        usernameController: usernameController,
                        emailController: emailController,
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}