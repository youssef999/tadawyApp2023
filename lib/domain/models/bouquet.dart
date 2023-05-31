// To parse this JSON data, do
//
//     final appointment = appointmentFromJson(jsonString);

import 'dart:convert';

List<Baka> appointmentFromJson(String str) => List<Baka>.from(json.decode(str).map((x) => Baka.fromJson(x)));

//String bakaToJson(List<Baka> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Baka {
  Baka({
    required this.id,
    required this.name,
    required this.details,
    required this.description,
    required this.days,
    required this.freeAds,
    required this.price,
    required this.adv,
  });

  int id;
  String name;
  String details;
  String description;
 int days;
 int freeAds;
  String adv;
  double price;

  factory Baka.fromJson(Map<String, dynamic> json) => Baka(
    id: int.parse(json["id"]),
    days: int.parse(json["days"]),
    freeAds: int.parse(json["free_ads"]),
    name: json["name"],
    details: json["details"],
    description: json["description"],
    adv: json["advantages"],
    price: double.parse(json["price"]),
  );

// Map<String, dynamic> toJson() => {
//   "id": id,
//   "doctor_name": doctorName,
//   "user_name": userName,
//   "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
//   "time": time,
// };
}
