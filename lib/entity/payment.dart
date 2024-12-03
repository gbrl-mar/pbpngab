import 'dart:convert';

class Payment {
  final String date; // Tanggal pembayaran
  final String idMember; // ID anggota yang melakukan pembayaran

  Payment({
    required this.date,
    required this.idMember,
  });

  // Untuk membuat objek Payment dari data JSON yang diterima dari API
  factory Payment.fromRawJson(String str) => Payment.fromJson(json.decode(str));

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        date: json["date"],
        idMember: json["idMember"],
      );

  // Untuk membuat data JSON dari objek Payment yang dikirim ke API
  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "date": date,
        "idMember": idMember,
      };
}
