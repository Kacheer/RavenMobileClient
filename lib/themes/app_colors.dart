import 'package:flutter/material.dart';

class AppColors {
  // Светлая тема
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightAppBar = Color(0xFFE0E0E0);
  static const Color lightSurface = Color(0xFFF5F5F5);
  static const Color lightText = Color(0xFF000000);
  static const Color lightHint = Color(0xFF7B818A);
  static const Color lightItem = Color(0xFFF0F0F0);

  // Тёмная тема
  static const Color darkBackground = Color(0xFF000000);
  static const Color darkAppBar = Color(0xFF0A0A0A);
  static const Color darkSurface = Color(0xFF121212);
  static const Color darkText = Color(0xFFFFFFFF);
  static const Color darkHint = Color(0xFF7B818A);
  static const Color darkItem = Color(0xFF121212);

  // Универсальные цвета
  static const Color primary = Color(0xFFA0B8FF);

  // Статические методы для получения цветов на основе темы
  static Color background(bool isDark) => isDark ? darkBackground : lightBackground;
  static Color appBar(bool isDark) => isDark ? darkAppBar : lightAppBar;
  static Color surface(bool isDark) => isDark ? darkSurface : lightSurface;
  static Color text(bool isDark) => isDark ? darkText : lightText;
  static Color hint(bool isDark) => isDark ? darkHint : lightHint;
  static Color itemBackground(bool isDark) => isDark ? darkItem : lightItem;
}