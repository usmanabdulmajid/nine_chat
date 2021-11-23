import 'dart:convert';

class User {
  String? id;
  String? username;
  String? email;
  String? password;
  String? imageUrl;
  bool? online;
  User({
    this.id,
    this.username,
    this.email,
    this.password,
    this.imageUrl,
    this.online,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'imageUrl': imageUrl,
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
      imageUrl: json['imageUrl'],
      online: json['online'],
    );
  }

  factory User.fromSource(String source) => User.fromJson(jsonDecode(source));

  User copywith({
    String? id,
    String? username,
    String? email,
    String? password,
    String? imageUrl,
    bool? online,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      imageUrl: imageUrl ?? this.imageUrl,
      online: online ?? this.online,
    );
  }
}
