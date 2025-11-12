import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class AuthService {
  /// Базовый URL для эндпоинта аутентификации (без завершающего слеша)
  final String baseUrl = 'http://ravenapp.ru/api/Auth';

  /// Таймаут для сетевых запросов
  final Duration _timeout = const Duration(seconds: 10);

  /// Регистрирует пользователя.
  /// Принимает: email, password, firstName, lastName, username (опционально).
  /// В случае успеха возвращает Map с ключами:
  /// { "UserId": ..., "Email": ..., "FirstName": ..., "LastName": ..., "Username": ..., "Token": ... }
  /// В случае ошибки выбрасывает Exception с подробным сообщением.
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? username,
  }) async {
    final uri = Uri.parse('$baseUrl/Register');

    final payload = <String, dynamic>{
      'Email': email,
      'Password': password,
      'FirstName': firstName,
      'LastName': lastName,
    };

    if (username != null && username.trim().isNotEmpty) {
      payload['Username'] = username.trim();
    }

    http.Response response;
    try {
      response = await http
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(payload),
          )
          .timeout(_timeout);
    } on TimeoutException catch (_) {
      throw Exception('Превышено время ожидания запроса. Попробуйте ещё раз.');
    } on Exception catch (e) {
      throw Exception('Ошибка соединения: ${e.toString()}');
    }

    final status = response.statusCode;
    final body = response.body;

    if (status >= 200 && status < 300) {
      if (body.trim().isEmpty) {
        throw Exception('Пустой ответ от сервера при регистрации.');
      }
      try {
        final decoded = jsonDecode(body);
        if (decoded is Map<String, dynamic>) {
          final requiredKeys = ['UserId', 'Email', 'FirstName', 'LastName', 'Token'];
          final missing = requiredKeys.where((k) => !decoded.containsKey(k)).toList();
          if (missing.isNotEmpty) {
            throw Exception('Регистрация выполнена, но в ответе отсутствуют поля: ${missing.join(', ')}');
          }
          return Map<String, dynamic>.from(decoded);
        } else {
          throw Exception('Непредвидимый формат ответа от сервера: ожидается JSON-объект.');
        }
      } on FormatException {
        throw Exception('Не удалось распарсить JSON в ответе сервера.');
      }
    } else {
      try {
        final decoded = jsonDecode(body);
        if (decoded is Map && decoded.containsKey('message')) {
          throw Exception('Ошибка регистрации: ${decoded['message']}');
        } else if (decoded is Map && decoded.containsKey('error')) {
          throw Exception('Ошибка регистрации: ${decoded['error']}');
        } else {
          throw Exception('Ошибка регистрации: HTTP ${status}');
        }
      } on FormatException {
        final snippet = body.length > 200 ? '${body.substring(0, 200)}...' : body;
        throw Exception('Ошибка регистрации: HTTP $status. Ответ сервера: $snippet');
      } catch (e) {
        throw Exception('Ошибка регистрации: HTTP $status.');
      }
    }
  }
}