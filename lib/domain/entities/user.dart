class User {
  String? username;

  User({required this.username});

  factory User.fromJson(dynamic json) {
    return User(
      username: json['username'] as String,
    );
  }

  @override
  String toString() {
    return '{ ${this.username} }';
  }

  Map<String, dynamic> toJson() {
    return {
      'username': this.username,
    };
  }
}
