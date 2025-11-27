import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/add_friend_search.dart';
import '../widgets/add_friend_button.dart';
import '../widgets/contact_item.dart';
import '../models/contact_model.dart';
import '../themes/theme_notifier.dart';
import '../themes/app_colors.dart';
import '../routes.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  String _searchQuery = '';

  final List<ContactModel> _contacts = [
    ContactModel(avatarPath: 'assets/contact1.png', username: '@john_doe', name: 'John Doe'),
    ContactModel(avatarPath: 'assets/contact2.png', username: '@jane_smith', name: 'Jane Smith'),
  ];

  List<ContactModel> get _filteredContacts {
    if (_searchQuery.isEmpty) return _contacts;
    return _contacts.where((c) => c.username.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDark = themeNotifier.isDark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Новое сообщение'),
        backgroundColor: AppColors.appBar(isDark),
        elevation: 0,
      ),
      backgroundColor: AppColors.background(isDark),
      body: Column(
        children: [
          AddFriendSearch(onChanged: (v) => setState(() => _searchQuery = v)),
          AddFriendButton(
            onCreateChatPressed: () => Navigator.pushNamed(context, AppRoutes.createGroupChat),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredContacts.length,
              itemBuilder: (context, index) => ContactItem(contact: _filteredContacts[index]),
            ),
          ),
        ],
      ),
    );
  }
}