import 'dart:convert';

class Membership {
  final String packageName;
  final String price;
  final String description;
  final String imageUrl;

  Membership({
    required this.packageName,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  // Untuk membuat objek Membership dari data JSON yang diterima dari API
  factory Membership.fromRawJson(String str) => Membership.fromJson(json.decode(str));

  factory Membership.fromJson(Map<String, dynamic> json) => Membership(
        packageName: json["packageName"],
        price: json["price"],
        description: json["description"],
        imageUrl: json["imageUrl"],
      );

  // Untuk membuat data JSON dari objek Membership yang dikirim ke API
  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "packageName": packageName,
        "price": price,
        "description": description,
        "imageUrl": imageUrl,
      };
}
