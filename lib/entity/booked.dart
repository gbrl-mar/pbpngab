import 'dart:convert';

class Booked {
  final String idUser;       // ID pengguna yang melakukan booking
  final String idTrainer;    // ID pelatih yang dipesan
  final String idEquipment;   // ID peralatan yang dipesan

  Booked({
    required this.idUser,
    required this.idTrainer,
    required this.idEquipment,
  });

  // Untuk membuat objek Booked dari data JSON yang diterima dari API
  factory Booked.fromRawJson(String str) => Booked.fromJson(json.decode(str));

  factory Booked.fromJson(Map<String, dynamic> json) => Booked(
        idUser: json["idUser"],
        idTrainer: json["idTrainer"],
        idEquipment: json["idEquipment"],
      );

  // Untuk membuat data JSON dari objek Booked yang dikirim ke API
  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "idUser": idUser,
        "idTrainer": idTrainer,
        "idEquipment": idEquipment,
      };
}
