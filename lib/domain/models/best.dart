// To parse this JSON data, do
//
//     final appointment = appointmentFromJson(jsonString);

import 'dart:convert';

List<Best> adsFromJson(String str) => List<Best>.from(json.decode(str).map((x) => Best.fromJson(x)));

//String AdsToJson(List<Ads> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Best {
  Best({
    required this.id,
    required this.name,
    required this.details,
    required this.image,
    required this.offerImage,
    required this.day,
    required this.date_end,
    required this.country,
    required this.doctor_name,
    required this.doctor_email,
    this.doctor_id,
    this.doctor_phone,this.doctor_cat,
    this.doctor_degree,this.cat2,
    this.address,this.address2,this.address3,
    this.time,this.time2,this.time3,
    this.location,this.location2,this.location3,
    this.doctor_info,this.position,this.price,
    this.doctor_password,this.doctor_image

  });

  int id;
  String name;
  String offerImage;
  String day;
  String details;
  String country;
  DateTime date_end;
  String image;
  String doctor_name;
  String doctor_email;
  int ?doctor_id;
  String ?doctor_password;
  String ?doctor_image;
  String ?doctor_phone;
  String ?doctor_cat;
  String ?cat2;
  String ?doctor_info;
  String ?doctor_degree;
  String ?position;
  String ?price;

  String ?address;
  String ?address2;
  String ?address3;
  String ?time;
  String ?time2;
  String ?time3;
  String ?location;
  String ?location2;
  String ?location3;

  factory Best.fromJson(Map<String, dynamic> json) => Best(
    id: int.parse(json["id"]),
    name: json["name"]??"",
    country: json["country"]??"",
    date_end: DateTime.parse(json["date_end"]),
    details: json["details"]??"",
    image: json["image"]??"",
    offerImage: json["offer_image"]??"",
    doctor_id:int.parse(json['doctor_id'].toString()),
    doctor_email: json['doctor_email']??'',
    doctor_name: json['doctor_name']??'',
    doctor_password:json['doctor_password']??"",
    doctor_cat: json["doctor_cat"]??"",
    cat2:json["cat2"]??"",
    day:json["days"]??"",
    doctor_degree: json["doctor_degree"]??"",
    doctor_info: json["doctor_info"]??"",
    doctor_phone: json["doctor_phone"]??"",
    doctor_image:json['doctor_image']??"",
    position:json['position']??"",
    price:json['price']??"",
    address: json["address1"]??"",
    address2: json["address2"]??"",
    address3: json["address3"]??"",

    time: json["time1"]??"",
    time2: json["time2"]??"",
    time3: json["time3"]??"",

    location: json['location1']??"",
    location2: json['location2']??"",
    location3: json['location3']??"",



  );


// Map<String, dynamic> toJson() => {
//   "id": id,
//   "doctor_name": doctorName,
//   "user_name": userName,
//   "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
//   "time": time,
// };
}
