// contact_model.dart
class ContactModel {
  final String? avatarPath; // Аватар (может быть null для реальных контактов)
  final String name; // Имя контакта
  final String phoneNumber; // Номер телефона
  final bool isRegistered; // Зарегистрирован ли в приложении

  ContactModel({
    this.avatarPath,
    required this.name,
    required this.phoneNumber,
    this.isRegistered = false,
  });
}