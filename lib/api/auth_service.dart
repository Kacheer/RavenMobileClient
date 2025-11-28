import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class AuthService {
  // БАЗОВЫЙ URL
  final String baseUrl = 'http://ravenapp.ru/api/Auth';
  final Duration _timeout = const Duration(seconds: 10);

  // РЕГИСТРАЦИЯ
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? username,
  }) async {
    final uri = Uri.parse('$baseUrl/Register');
    final payload = {
      'Email': email,
      'Password': password,
      'FirstName': firstName,
      'LastName': lastName,
      if (username != null && username.trim().isNotEmpty) 'Username': username.trim(),
    };

    print('Запрос на регистрацию: $payload');

    http.Response response;
    try {
      response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      ).timeout(_timeout);
    } on TimeoutException {
      throw Exception('Превышено время ожидания.');
    } on Exception catch (e) {
      throw Exception('Ошибка соединения: $e');
    }

    print('Статус: ${response.statusCode}');
    print('Тело ответа: ${response.body}');
    print('Заголовки: ${response.headers}');

    final status = response.statusCode;
    final body = response.body;

    if (status >= 200 && status < 300) {
      if (body.trim().isEmpty) {
        return {'warning': 'Пустой ответ'};
      }

      try {
        final decoded = jsonDecode(body);
        if (decoded is Map<String, dynamic>) {
          final result = Map<String, dynamic>.from(decoded);

          // Ищем токен везде
          String? token = _extractToken(result, response.headers);
          if (token != null) {
            result['Token'] = token;
          } else {
            result['warning'] = 'Токен не найден в ответе';
          }

          return result;
        } else {
          return {'raw': body, 'warning': 'Не JSON'};
        }
      } on FormatException catch (e) {
        print('Ошибка парсинга JSON: $e');
        throw Exception('Не удалось распарсить JSON: $e');
      }
    } else {
      _handleError(status, body);
    }
  }

  // ВХОД
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final uri = Uri.parse('$baseUrl/Login');
    final payload = {'Email': email, 'Password': password};

    print('Запрос на вход: $payload');

    http.Response response;
    try {
      response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      ).timeout(_timeout);
    } on TimeoutException {
      throw Exception('Превышено время ожидания.');
    } on Exception catch (e) {
      throw Exception('Ошибка соединения: $e');
    }

    print('Статус: ${response.statusCode}');
    print('Тело ответа: ${response.body}');
    print('Заголовки: ${response.headers}');

    final status = response.statusCode;
    final body = response.body;

    if (status >= 200 && status < 300) {
      if (body.trim().isEmpty) {
        throw Exception('Пустой ответ');
      }

      try {
        final decoded = jsonDecode(body);
        if (decoded is Map<String, dynamic>) {
          final result = Map<String, dynamic>.from(decoded);

          String? token = _extractToken(result, response.headers);
          if (token != null) {
            result['Token'] = token;
          } else {
            result['warning'] = 'Токен не найден в ответе';
          }

          return result;
        } else {
          throw Exception('Ответ не JSON');
        }
      } on FormatException {
        throw Exception('Не удалось распарсить JSON');
      }
    } else {
      _handleError(status, body);
    }
  }

  // Вспомогательная функция: ищем токен
  String? _extractToken(Map<String, dynamic> data, Map<String, String> headers) {
    // Варианты в теле
    if (data['Token'] != null) return data['Token'].toString();
    if (data['token'] != null) return data['token'].toString();
    if (data['accessToken'] != null) return data['accessToken'].toString();
    if (data['jwt'] != null) return data['jwt'].toString();
    if (data['Settings']?['Token'] != null) return data['Settings']['Token'].toString();

    // В заголовке
    final auth = headers['authorization'] ?? headers['Authorization'];
    if (auth != null && auth.startsWith('Bearer ')) {
      return auth.substring(7);
    }

    return null;
  }

  // Обработка ошибок
  Never _handleError(int status, String body) {
    try {
      final decoded = jsonDecode(body);
      final msg = decoded['message'] ?? decoded['error'] ?? 'Ошибка $status';
      throw Exception(msg);
    } on FormatException {
      throw Exception('HTTP $status: $body');
    }
  }
}