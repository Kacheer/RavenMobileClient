import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/contact_model.dart';
import '../themes/theme_notifier.dart';
import '../themes/app_colors.dart';

class ContactItem extends StatelessWidget {
  final ContactModel contact;

  const ContactItem({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDark = themeNotifier.isDark;

    return Container(
      color: AppColors.itemBackground(isDark),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          CircleAvatar(radius: 20, backgroundImage: AssetImage(contact.avatarPath)),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(contact.name, style: TextStyle(color: AppColors.text(isDark), fontSize: 16)),
              Text(contact.username, style: TextStyle(color: AppColors.hint(isDark), fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }
}