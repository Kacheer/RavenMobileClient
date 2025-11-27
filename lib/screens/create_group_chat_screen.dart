import 'package:flutter/material.dart';
import '../api/chats_service.dart';
import '../themes/theme_helper.dart';
import '../storage/secure_storage_service.dart';

class CreateGroupChatScreen extends StatefulWidget {
  const CreateGroupChatScreen({super.key});

  @override
  State<CreateGroupChatScreen> createState() => _CreateGroupChatScreenState();
}

class _CreateGroupChatScreenState extends State<CreateGroupChatScreen> {
  final ChatsService _chatsService = ChatsService();
  final SecureStorageService _storageService = SecureStorageService();
  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  
  final List<Map<String, dynamic>> _availableUsers = [
    {'id': '1', 'name': 'John Doe', 'username': '@john_doe', 'selected': false},
    {'id': '2', 'name': 'Jane Smith', 'username': '@jane_smith', 'selected': false},
    {'id': '3', 'name': 'Alex Johnson', 'username': '@alex_j', 'selected': false},
    {'id': '4', 'name': 'Emily Davis', 'username': '@emily_d', 'selected': false},
  ];

  bool _isLoading = false;

  Future<void> _createGroupChat() async {
    if (_isLoading) return;
    
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введите название чата'), backgroundColor: Colors.red),
      );
      return;
    }

    final selectedUserIds = _availableUsers
        .where((user) => user['selected'] == true)
        .map((user) => user['id'].toString())
        .toList();

    if (selectedUserIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Выберите хотя бы одного участника'), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final chat = await _chatsService.createGroupChat(
        name: name,
        participantIds: selectedUserIds,
        description: _descriptionController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Чат "${chat.name}" создан!'), backgroundColor: Colors.green),
        );
        Navigator.pop(context, chat);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка создания чата: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _toggleUserSelection(int index) {
    setState(() {
      _availableUsers[index]['selected'] = !_availableUsers[index]['selected'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Создать групповой чат'),
        backgroundColor: colors.appBar,
        elevation: 0,
        actions: [
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _createGroupChat,
            ),
        ],
      ),
      backgroundColor: colors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Название чата',
              style: TextStyle(
                color: colors.text,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              style: TextStyle(color: colors.text),
              decoration: InputDecoration(
                hintText: 'Введите название чата',
                hintStyle: TextStyle(color: colors.hint),
                filled: true,
                fillColor: colors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(height: 20),

            Text(
              'Описание (необязательно)',
              style: TextStyle(
                color: colors.text,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              style: TextStyle(color: colors.text),
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Введите описание чата',
                hintStyle: TextStyle(color: colors.hint),
                filled: true,
                fillColor: colors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(height: 24),

            Text(
              'Участники',
              style: TextStyle(
                color: colors.text,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            ..._availableUsers.asMap().entries.map((entry) {
              final index = entry.key;
              final user = entry.value;
              
              return Card(
                color: colors.itemBackground,
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: colors.primary,
                    child: Text(
                      user['name'].toString().substring(0, 1).toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    user['name'],
                    style: TextStyle(color: colors.text, fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    user['username'],
                    style: TextStyle(color: colors.hint),
                  ),
                  trailing: Checkbox(
                    value: user['selected'] ?? false,
                    onChanged: (value) => _toggleUserSelection(index),
                    fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                      if (states.contains(MaterialState.selected)) {
                        return colors.primary;
                      }
                      return Colors.grey;
                    }),
                  ),
                  onTap: () => _toggleUserSelection(index),
                ),
              );
            }),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _createGroupChat,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Создать групповой чат',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}