import 'dart:convert';

class Cabang {
  final String imageUrl;
  final String gymName;
  final String openingHours;
  final String closingHours;
  final String description;
  final double latitude;
  final double longitude;

  Cabang({
    required this.imageUrl,
    required this.gymName,
    required this.openingHours,
    required this.closingHours,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  // Untuk membuat objek Cabang dari data JSON yang diterima dari API
  factory Cabang.fromRawJson(String str) => Cabang.fromJson(json.decode(str));

  factory Cabang.fromJson(Map<String, dynamic> json) => Cabang(
        imageUrl: json["imageUrl"],
        gymName: json["gymName"],
        openingHours: json["openingHours"],
        closingHours: json["closingHours"],
        description: json["description"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
      );

  // Untuk membuat data JSON dari objek Cabang yang dikirim ke API
  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "imageUrl": imageUrl,
        "gymName": gymName,
        "openingHours": openingHours,
        "closingHours": closingHours,
        "description": description,
        "latitude": latitude,
        "longitude": longitude,
      };
}
