class ChatModel {
  final String id;
  final String name;
  final String? lastMessage;
  final String? lastMessageTime;
  final String? avatarUrl;
  final bool isGroup;
  final int unreadCount;

  ChatModel({
    required this.id,
    required this.name,
    this.lastMessage,
    this.lastMessageTime,
    this.avatarUrl,
    this.isGroup = false,
    this.unreadCount = 0,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Unknown Chat',
      lastMessage: json['lastMessage']?.toString(),
      lastMessageTime: json['lastMessageTime']?.toString(),
      avatarUrl: json['avatarUrl']?.toString(),
      isGroup: json['isGroup'] ?? false,
      unreadCount: json['unreadCount'] ?? 0,
    );
  }
}