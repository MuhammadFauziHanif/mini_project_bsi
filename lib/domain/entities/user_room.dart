class UserRoom {
  String? username;
  List? room;

  UserRoom({required this.username, required this.room});

  factory UserRoom.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'username': String username,
        'room': List room,
      } =>
        UserRoom(username: username, room: room),
      _ => throw const FormatException('Gagal membuat user room')
    };
  }

  Map<String, dynamic> toJson() {
    return {'username': this.username, 'room': this.room};
  }
}
