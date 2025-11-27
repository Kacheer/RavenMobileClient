import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../themes/theme_notifier.dart';
import '../themes/app_colors.dart';

class AddFriendSearch extends StatelessWidget {
  final Function(String) onChanged;

  const AddFriendSearch({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDark = themeNotifier.isDark;

    return Container(
      color: AppColors.appBar(isDark),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      margin: const EdgeInsets.only(bottom: 19),
      child: Container(
        decoration: BoxDecoration(color: AppColors.surface(isDark), borderRadius: BorderRadius.circular(9)),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Icon(Icons.search, color: AppColors.text(isDark), size: 24),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: 'Найти...',
                  hintStyle: TextStyle(color: AppColors.hint(isDark), fontSize: 20),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: AppColors.text(isDark)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}