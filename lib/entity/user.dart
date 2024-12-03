import 'dart:convert';

class User {
  final String username;
  final String email;
  final DateTime birthdate;
  final String gender;
  final String password;
  final double? weight;
  final double? height;

  User({
    required this.username,
    required this.email,
    required this.birthdate,
    required this.gender,
    required this.password,
    this.weight,
    this.height,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        email: json["email"],
        birthdate: DateTime.parse(json["birthdate"]),
        gender: json["gender"],
        password: json["password"],
        weight: json["weight"] != null ? json["weight"].toDouble() : null,
        height: json["height"] != null ? json["height"].toDouble() : null,
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "birthdate": birthdate.toIso8601String(),
        "gender": gender,
        "password": password,
        "weight": weight,
        "height": height,
      };
}
