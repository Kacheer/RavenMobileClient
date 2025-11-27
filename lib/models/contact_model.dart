// Модель для контакта (для mock-данных)
class ContactModel {
  final String avatarPath; // Аватар
  final String username; // @username
  final String name; // Полное имя (опционально)

  ContactModel({
    required this.avatarPath,
    required this.username,
    required this.name,
  });
}