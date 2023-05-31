// To parse this JSON data, do
//
//     final appointment = appointmentFromJson(jsonString);

import 'dart:convert';

List<Cat> catFromJson(String str) => List<Cat>.from(json.decode(str).map((x) => Cat.fromJson(x)));

//String AdsToJson(List<Ads> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cat {
 Cat({
    required this.id,
    required this.name,
    required this.cat2,

    required this.image,

  });

  int id;
  String name;
  String cat2;
  String image;


  factory Cat.fromJson(Map<String, dynamic> json) => Cat (

    id: int.parse(json["id"]),
    name: json["name"]??"",
    image: json["image"]??"",
    cat2: json["cat2"]??"",

  );

// Map<String, dynamic> toJson() => {
//   "id": id,
//   "doctor_name": doctorName,
//   "user_name": userName,
//   "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
//   "time": time,
// };
}
