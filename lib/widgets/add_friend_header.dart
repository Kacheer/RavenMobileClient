import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../themes/app_colors.dart';
import '../themes/theme_notifier.dart';

class AddFriendHeader extends StatelessWidget {
  const AddFriendHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDark = themeNotifier.isDark;

    return Container(
      color: AppColors.appBar(isDark), // Фон #0A0A0A или светлый
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.arrow_back,
                color: AppColors.text(isDark),
                size: 22,
              ),
              const SizedBox(width: 22),
              Expanded(
                child: Text(
                  'Новое сообщение',
                  style: TextStyle(
                    color: AppColors.text(isDark),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}