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

    return Container(
      margin: const EdgeInsets.only(bottom: 19),
      child: ElevatedButton(
        onPressed: onCreateChatPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.add_circle_outline, size: 24),
            const SizedBox(width: 12),
            Text(
              'Создать чат',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
