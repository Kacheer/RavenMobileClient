import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../storage/secure_storage_service.dart';
import '../models/chat_model.dart'; // Импортируем ChatModel из отдельного файла

class ChatsService {
  final String baseUrl = 'http://ravenapp.ru/api';
  final Duration _timeout = const Duration(seconds: 10);
  final SecureStorageService _storageService = SecureStorageService();

  // Получение списка чатов пользователя
  Future<List<ChatModel>> getUserChats({
    int page = 1,
    int pageSize = 25,
  }) async {
    final token = await _storageService.readData('auth_token');
    if (token == null) {
      throw Exception('Токен не найден. Пожалуйста, авторизуйтесь заново.');
    }

    final uri = Uri.parse('$baseUrl/chats?page=$page&pageSize=$pageSize');

    print('Запрос чатов: $uri');

    http.Response response;
    try {
      response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(_timeout);
    } on TimeoutException {
      throw Exception('Превышено время ожидания.');
    } on Exception catch (e) {
      throw Exception('Ошибка соединения: $e');
    }

    print('Статус получения чатов: ${response.statusCode}');
    print('Тело ответа чатов: ${response.body}');

    if (response.statusCode == 401) {
      await _storageService.deleteAllData();
      throw Exception('Сессия истекла. Пожалуйста, авторизуйтесь заново.');
    }

    if (!response.ok) {
      _handleChatError(response);
    }

    try {
      final List<dynamic> jsonList = jsonDecode(response.body);
      final chats = jsonList.map((json) => ChatModel.fromJson(json)).toList();
      
      print('Чаты загружены успешно: ${chats.length} чатов');
      return chats;
    } on FormatException catch (e) {
      print('Ошибка парсинга JSON чатов: $e');
      throw Exception('Не удалось распарсить ответ сервера');
    }
  }

  // Создание группового чата
  Future<ChatModel> createGroupChat({
    required String name,
    required List<String> participantIds,
    String? description,
  }) async {
    final token = await _storageService.readData('auth_token');
    if (token == null) {
      throw Exception('Токен не найден. Пожалуйста, авторизуйтесь заново.');
    }

    final uri = Uri.parse('$baseUrl/chats/group');
    final payload = {
      'name': name,
      'participantIds': participantIds,
      if (description != null && description.trim().isNotEmpty) 
        'description': description,
    };

    print('Создание группового чата: $payload');

    http.Response response;
    try {
      response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(payload),
      ).timeout(_timeout);
    } on TimeoutException {
      throw Exception('Превышено время ожидания.');
    } on Exception catch (e) {
      throw Exception('Ошибка соединения: $e');
    }

    print('Статус создания чата: ${response.statusCode}');
    print('Тело ответа создания чата: ${response.body}');

    if (response.statusCode == 401) {
      await _storageService.deleteAllData();
      throw Exception('Сессия истекла. Пожалуйста, авторизуйтесь заново.');
    }

    if (!response.ok) {
      _handleChatError(response);
    }

    try {
      final json = jsonDecode(response.body);
      return ChatModel.fromJson(json);
    } on FormatException catch (e) {
      print('Ошибка парсинга JSON создания чата: $e');
      throw Exception('Не удалось распарсить ответ сервера');
    }
  }

  // Обработка ошибок для чатов
  Never _handleChatError(http.Response response) {
    try {
      final decoded = jsonDecode(response.body);
      
      // Обработка ошибок валидации (400)
      if (response.statusCode == 400) {
        final errors = decoded['errors'];
        if (errors != null) {
          // Обработка chat ошибок (как в фронтенде)
          final chatErrors = errors['chat'] ?? [];
          if (chatErrors.isNotEmpty) {
            print('Детали chat ошибки: $chatErrors');
            throw Exception(chatErrors.first.toString());
          }
          
          // Общая обработка ошибок валидации
          final validationErrors = errors.entries.map((entry) {
            final field = entry.key;
            final messages = entry.value is List ? entry.value : [entry.value];
            return '$field: ${messages.join(", ")}';
          }).join('; ');
          
          throw Exception('Ошибка валидации: $validationErrors');
        }
      }
      
      final errorMessage = decoded['title'] ?? decoded['message'] ?? 'Ошибка ${response.statusCode}';
      throw Exception(errorMessage);
    } on FormatException {
      throw Exception('HTTP ${response.statusCode}: ${response.body}');
    }
  }
}

// Расширение для проверки статуса ответа
extension HttpResponseExtensions on http.Response {
  bool get ok {
    return statusCode >= 200 && statusCode < 300;
  }
}