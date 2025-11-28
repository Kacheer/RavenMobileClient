// add_friend_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
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
  List<ContactModel> _contacts = [];
  bool _isLoading = true;
  bool _permissionGranted = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    try {
      print('Проверка разрешений для контактов...');
      
      final status = await Permission.contacts.status;
      print('Статус разрешения: $status');
      
      if (status.isDenied) {
        final newStatus = await Permission.contacts.request();
        if (!newStatus.isGranted) {
          setState(() {
            _isLoading = false;
            _permissionGranted = false;
            _errorMessage = 'Разрешение не предоставлено';
          });
          return;
        }
      }

      if (status.isGranted) {
        _permissionGranted = true;
        
        // Временное решение: используем демо-контакты
        // В реальном приложении здесь будет интеграция с нативным кодом
        await _loadDemoContacts();
      }
    } catch (e) {
      print('Ошибка загрузки контактов: $e');
      setState(() {
        _isLoading = false;
        _errorMessage = 'Ошибка: $e';
      });
    }
  }

  // Демо-контакты для тестирования функциональности
  Future<void> _loadDemoContacts() async {
    await Future.delayed(const Duration(seconds: 1)); // Имитация загрузки
    
    setState(() {
      _contacts = [
        ContactModel(
          name: 'Иван Иванов',
          phoneNumber: '+79161234567',
          isRegistered: false,
        ),
        ContactModel(
          name: 'Мария Петрова', 
          phoneNumber: '+79169876543',
          isRegistered: false,
        ),
        ContactModel(
          name: 'Алексей Сидоров',
          phoneNumber: '+79165544332',
          isRegistered: false,
        ),
        ContactModel(
          name: 'Екатерина Волкова',
          phoneNumber: '+79167778899',
          isRegistered: false,
        ),
        ContactModel(
          name: 'Дмитрий Козлов',
          phoneNumber: '+79163332211',
          isRegistered: false,
        ),
        ContactModel(
          name: 'Анна Смирнова',
          phoneNumber: '+79164445566',
          isRegistered: false,
        ),
        ContactModel(
          name: 'Сергей Николаев',
          phoneNumber: '+79168889900',
          isRegistered: false,
        ),
        ContactModel(
          name: 'Ольга Федорова',
          phoneNumber: '+79162223344',
          isRegistered: false,
        ),
        ContactModel(
          name: 'Павел Морозов',
          phoneNumber: '+79169998877',
          isRegistered: false,
        ),
        ContactModel(
          name: 'Наталья Захарова',
          phoneNumber: '+79161112233',
          isRegistered: false,
        ),
      ];
      _isLoading = false;
      print('Загружено демо-контактов: ${_contacts.length}');
    });
  }

  void _requestPermission() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    
    final status = await Permission.contacts.request();
    if (status.isGranted) {
      await _loadContacts();
    } else {
      setState(() {
        _isLoading = false;
        _permissionGranted = false;
        _errorMessage = 'Пользователь отказал в доступе';
      });
    }
  }

  void _openAppSettings() {
    openAppSettings();
  }

  void _retryLoadContacts() {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    _loadContacts();
  }

  List<ContactModel> get _filteredContacts {
    if (_searchQuery.isEmpty) return _contacts;
    return _contacts.where((contact) {
      return contact.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
             contact.phoneNumber.contains(_searchQuery);
    }).toList();
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
          
          // Информация о демо-режиме
          if (_contacts.isNotEmpty && _permissionGranted)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.orange, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Демо-режим: показаны тестовые контакты\nВ реальном приложении здесь будут ваши контакты из телефонной книги',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : !_permissionGranted
                    ? _buildPermissionDeniedView()
                    : _contacts.isEmpty
                        ? _buildEmptyContactsView()
                        : _buildContactsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionDeniedView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.contacts_outlined, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'Доступ к контактам не предоставлен',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Для отображения ваших контактов необходимо предоставить разрешение',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            if (_errorMessage.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                _errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.red),
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _requestPermission,
              child: const Text('Предоставить доступ'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: _openAppSettings,
              child: const Text('Открыть настройки'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyContactsView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.contacts_outlined, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'Контакты не найдены',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage.isEmpty 
                  ? 'В вашей адресной книге нет контактов\nили они недоступны'
                  : _errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _retryLoadContacts,
              child: const Text('Повторить загрузку'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: _openAppSettings,
              child: const Text('Проверить настройки'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactsList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Найдено контактов: ${_filteredContacts.length}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: _retryLoadContacts,
                tooltip: 'Обновить контакты',
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredContacts.length,
            itemBuilder: (context, index) => ContactItem(contact: _filteredContacts[index]),
          ),
        ),
      ],
    );
  }
}