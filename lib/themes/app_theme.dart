import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.appBar,
    required this.surface,
    required this.text,
    required this.hint,
    required this.itemBackground,
    required this.primary,
  });

  final Color background;
  final Color appBar;
  final Color surface;
  final Color text;
  final Color hint;
  final Color itemBackground;
  final Color primary;

  // Светлая тема
  static const AppColors light = AppColors(
    background: Color(0xFFFFFFFF),
    appBar: Color(0xFFE0E0E0),
    surface: Color(0xFFF5F5F5),
    text: Color(0xFF000000),
    hint: Color(0xFF7B818A),
    itemBackground: Color(0xFFF0F0F0),
    primary: Color(0xFFA0B8FF),
  );

  // Тёмная тема
  static const AppColors dark = AppColors(
    background: Color(0xFF000000),
    appBar: Color(0xFF0A0A0A),
    surface: Color(0xFF121212),
    text: Color(0xFFFFFFFF),
    hint: Color(0xFF7B818A),
    itemBackground: Color(0xFF121212),
    primary: Color(0xFFA0B8FF),
  );

  @override
  AppColors copyWith({
    Color? background,
    Color? appBar,
    Color? surface,
    Color? text,
    Color? hint,
    Color? itemBackground,
    Color? primary,
  }) {
    return AppColors(
      background: background ?? this.background,
      appBar: appBar ?? this.appBar,
      surface: surface ?? this.surface,
      text: text ?? this.text,
      hint: hint ?? this.hint,
      itemBackground: itemBackground ?? this.itemBackground,
      primary: primary ?? this.primary,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      appBar: Color.lerp(appBar, other.appBar, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      text: Color.lerp(text, other.text, t)!,
      hint: Color.lerp(hint, other.hint, t)!,
      itemBackground: Color.lerp(itemBackground, other.itemBackground, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
    );
  }
}