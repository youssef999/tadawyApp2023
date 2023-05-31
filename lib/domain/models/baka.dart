// To parse this JSON data, do
//
//     final appointment = appointmentFromJson(jsonString);

import 'dart:convert';

List<BakaSub> appointmentFromJson(String str) => List<BakaSub>.from(json.decode(str).map((x) => BakaSub.fromJson(x)));

//String bakaToJson(List<Baka> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BakaSub {
  BakaSub({
    required this.id,
    required this.name,
    required this.details,
    required this.des,
    required this.days,
    required this.price,
    required this.adv,
    required this.freeAds,
  });

  int id;
  String name;
  String details;
  String des;
  int days;
  int freeAds;
  String adv;
  double price;

  factory BakaSub.fromJson(Map<String, dynamic> json) => BakaSub(
    id: int.parse(json["id"]),
    days: int.parse(json["days"])??0,
    freeAds: int.parse(json["free_ads"])??0,
    name: json["name"],
    details: json["details"]??"",
    des: json["des"]??'',
    adv: json["adv"]??'',
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
