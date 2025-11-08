import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'http://ravenapp.ru/api/Auth';

  Future<http.Response> register(Map<String, dynamic> data) async {
    try {
      final url = Uri.parse('$baseUrl/register');
      print('🚀 Отправка POST запроса на: $url');
      print('📦 Тело запроса: ${jsonEncode(data)}');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 30));

      print('✅ Статус ответа: ${response.statusCode}');
      print('📨 Тело ответа: ${response.body}');
      print('🔍 Заголовки ответа: ${response.headers}');
      
      return response;
    } catch (e) {
      print('❌ Ошибка при регистрации: $e');
      rethrow;
    }
  }

  Future<http.Response> login(Map<String, dynamic> data) async {
    try {
      final url = Uri.parse('$baseUrl/login');
      print('🚀 Отправка POST запроса на: $url');
      print('📦 Тело запроса: ${jsonEncode(data)}');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 30));

      print('✅ Статус ответа: ${response.statusCode}');
      print('📨 Тело ответа: ${response.body}');
      print('🔍 Заголовки ответа: ${response.headers}');
      
      return response;
    } catch (e) {
      print('❌ Ошибка при входе: $e');
      rethrow;
    }
  }
}