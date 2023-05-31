// To parse this JSON data, do
//
//     final appointment = appointmentFromJson(jsonString);

import 'dart:convert';

List<Coins> catFromJson(String str) => List<Coins>.from(json.decode(str).map((x) => Coins.fromJson(x)));

//String AdsToJson(List<Ads> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Coins{
  Coins({
   this.id,
   this.system,
   this.ads,

  this.login,

  });

  int ?id;
  int ?system;
  int ?ads;
  int ?login;


  factory Coins.fromJson(Map<String, dynamic> json) => Coins (

    id: int.parse(json["id"]),
    system: int.parse(json["system"]),
    ads: int.parse(json["ads"]),
    login:int.parse( json["login"]),

  );

// Map<String, dynamic> toJson() => {
//   "id": id,
//   "doctor_name": doctorName,
//   "user_name": userName,
//   "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
//   "time": time,
// };
}
