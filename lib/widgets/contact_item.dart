// contact_item.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/contact_model.dart';
import '../themes/theme_notifier.dart';
import '../themes/app_colors.dart';

class ContactItem extends StatelessWidget {
  final ContactModel contact;

  const ContactItem({super.key, required this.contact});

  void _inviteContact(BuildContext context) {
    final String inviteText = 'Я использую мессенджер Raven, присоединяйся и ты! '
        'Скачивай по ссылке: https://ravenapp.ru/download';
    
    Share.share(inviteText, subject: 'Присоединяйся к Raven!');
  }

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
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primary.withOpacity(0.2),
            child: Icon(
              Icons.person, 
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact.name, 
                  style: TextStyle(
                    color: AppColors.text(isDark), 
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  contact.phoneNumber, 
                  style: TextStyle(
                    color: AppColors.hint(isDark), 
                    fontSize: 14
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => _inviteContact(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Пригласить',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}