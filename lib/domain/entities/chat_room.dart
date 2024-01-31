import 'package:mini_project_bsi_chat/domain/entities/message.dart';

class ChatRoom {
  List<Message>? messages;

  ChatRoom({required this.messages});

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'messages': List<Message> messages} => ChatRoom(messages: messages),
      _ => throw const FormatException('Gagal membuat chat')
    };
  }

  Map<String, dynamic> toJson() {
    return {'messages': this.messages};
  }
}
