class Chat {
  String? id;
  String? username;
  String? text;

  Chat({required this.id, required this.username, required this.text});

  factory Chat.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'username': String username,
        'text': String text,
      } =>
        Chat(id: id, username: username, text: text),
      _ => throw const FormatException('Gagal membuat chat')
    };
  }

  Map<String, dynamic> toJson() {
    return {'id': this.id, 'username': this.username, 'text': this.text};
  }
}
