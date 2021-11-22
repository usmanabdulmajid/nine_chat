import 'dart:convert';

class User {
  String? id;
  String? username;
  String? email;
  String? password;
  bool? online;
  User({
    this.id,
    this.username,
    this.email,
    this.password,
    this.online,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'online': online,
    };
  }

  @override
  String toString() => jsonEncode(toString());

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        password: json['password'],
        online: json['online']);
  }

  factory User.fromSource(String source) => User.fromJson(jsonDecode(source));

  User copywith({
    String? id,
    String? username,
    String? email,
    String? password,
    bool? online,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      online: online ?? this.online,
    );
  }
}
