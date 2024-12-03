import 'dart:convert';

class Equipment {
  final String imageUrl;
  final String name;
  final String description;

  Equipment({
    required this.imageUrl,
    required this.name,
    required this.description,
  });

  factory Equipment.fromRawJson(String str) => Equipment.fromJson(json.decode(str));

  factory Equipment.fromJson(Map<String, dynamic> json) => Equipment(
        imageUrl: json["imageUrl"],
        name: json["name"],
        description: json["description"],
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "imageUrl": imageUrl,
        "name": name,
        "description": description,
      };
}
