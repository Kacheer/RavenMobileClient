import 'package:flutter/material.dart';
import 'app_theme.dart';

extension ThemeDataExtensions on ThemeData {
  AppColors get appColors => extension<AppColors>()!;
}

class ThemeHelper {
  static AppColors of(BuildContext context) {
    return Theme.of(context).appColors;
  }
}