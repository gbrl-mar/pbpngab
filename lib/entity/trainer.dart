import 'dart:convert';

class Trainer {
  final String name;
  final String specialization;
  final double rating;
  final String imageUrl;

  Trainer({
    required this.name,
    required this.specialization,
    required this.rating,
    required this.imageUrl,
  });

  // Untuk membuat objek Trainer dari data JSON yang diterima dari API
  factory Trainer.fromRawJson(String str) => Trainer.fromJson(json.decode(str));

  factory Trainer.fromJson(Map<String, dynamic> json) => Trainer(
        name: json["name"],
        specialization: json["specialization"],
        rating: json["rating"].toDouble(),
        imageUrl: json["imageUrl"],
      );

  // Untuk membuat data JSON dari objek Trainer yang dikirim ke API
  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "name": name,
        "specialization": specialization,
        "rating": rating,
        "imageUrl": imageUrl,
      };
}
