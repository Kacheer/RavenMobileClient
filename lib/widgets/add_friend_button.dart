import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../themes/theme_notifier.dart';
import '../themes/app_colors.dart';

class AddFriendButton extends StatelessWidget {
  final VoidCallback onCreateChatPressed;

  const AddFriendButton({super.key, required this.onCreateChatPressed});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDark = themeNotifier.isDark;

    return GestureDetector(
      onTap: onCreateChatPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        margin: const EdgeInsets.only(bottom: 19),
        child: Row(
          children: [
            Icon(Icons.add_circle_outline, size: 24, color: AppColors.primary),
            const SizedBox(width: 12),
            Text(
              'Создать чат',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}