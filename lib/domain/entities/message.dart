class Message {
  String? username;
  String? text;
  int timestamp;

  Message(
      {required this.username, required this.text, required this.timestamp});

  factory Message.fromJson(dynamic json) {
    return Message(
        username: json['username'] as String,
        text: json['text'] as String,
        timestamp: int.parse(json['timestamp']) as int);
  }

  @override
  String toString() {
    return '{ ${this.username}, ${this.text}, ${this.timestamp} }';
  }

  Map<String, dynamic> toJson() {
    return {
      'username': this.username,
      'text': this.text,
      'timestamp': this.timestamp
    };
  }
}
