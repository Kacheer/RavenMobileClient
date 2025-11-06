import 'package:flutter/material.dart';
import 'dart:ui'; // Для blur
import 'login_form.dart'; // Импорт формы входа
import 'registration_form.dart'; // Импорт формы регистрации

class AuthContainer extends StatelessWidget {
  final TabController tabController; // Prop: контроллер табов от родителя

  const AuthContainer({super.key, required this.tabController});

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
                // TabBar
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
                // TabBarView с формами
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: TabBarView(
                    controller: tabController,
                    children: const [
                      LoginForm(), // Компонент формы входа
                      RegistrationForm(), // Компонент формы регистрации
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