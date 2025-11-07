import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'http://ravenapp.ru/api/Auth';

  Future<http.Response> register(Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/register');
    print('Отправка POST запроса на: $url');
    print('Тело запроса: ${jsonEncode(data)}');

    final headers = {'Content-Type': 'application/json'};
    print('Заголовки запроса: ${headers}');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    print('Статус ответа: ${response.statusCode}');
    print('Тело ответа: ${response.body}');
    return response;
  }

  Future<http.Response> login(Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/login');
    print('Отправка POST запроса на: $url');
    print('Тело запроса: ${jsonEncode(data)}');

    final headers = {'Content-Type': 'application/json'};
    print('Заголовки запроса: ${headers}');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    print('Статус ответа: ${response.statusCode}');
    print('Тело ответа: ${response.body}');
    return response;
  }
}