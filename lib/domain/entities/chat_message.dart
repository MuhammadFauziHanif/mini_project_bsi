import 'dart:convert';

import 'package:mini_project_bsi_chat/domain/entities/message.dart';

class ChatMessage {
  List users;
  List<Message>? messages;

  ChatMessage({required this.users, required this.messages});

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      users: json["users"] == null
          ? []
          : List<String>.from(json["users"]!.map((x) => x)),
      messages: json["messages"] == null
          ? []
          : List<Message>.from(
              json["messages"]!.map((x) => Message.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "users": users?.map((x) => x).toList(),
        "messages": messages?.map((x) => x?.toJson()).toList(),
      };
}
