


 class Favorite {
  int ? fav_id;
  int ? user_id;
  int ? doctor_id;
  String ? doctor_name;
  String ?doctor_cat;
  String ? doctor_info;
  String ? doctor_degree;
  String ? doctor_phone;
  String ? doctor_image;
  String ? address1;
  String ? address2;
  String ? address3;
 String ? time1;
 String ? time2;
 String ? time3;
  String ?price;
 String ? location1;
 String ? location2;
 String ? location3;




  Favorite ({
    this.fav_id,
    this.doctor_id, this.user_id,this.price,this.doctor_degree,
    this.doctor_name, this.doctor_image, this.doctor_cat, this.doctor_info,
    this.address2, this.address1,this.address3, this.doctor_phone, this.time1,this.time2,this.time3
  });

  factory Favorite .fromJson(Map<String,dynamic>json)=>Favorite(

    fav_id: int.parse(json['fav_id'].toString()),
    user_id: int.parse(json['user_id'].toString()),
    doctor_id: int.parse(json['doctor_id'].toString()),
    doctor_image: json['doctor_image'],
    doctor_name: json['doctor_name'],
    price: json['price'],
    doctor_cat: json["doctor_cat"],
    doctor_degree: json["doctor_degree"],
    doctor_info: json["doctor_info"],
    doctor_phone: json["doctor_phone"],

    address1: json["address1"],
    address2: json["address2"],
    address3: json["address3"],

    time1: json["time1"],
    time2: json["time2"],
    time3: json["time3"],

  );

  // Map<String, dynamic> toJson() => {
  //   'item_id': item_id,
  //   'name': name,
  //   'rating': rating,
  //   'tags': tags,
  //   'sizes': sizes,
  //   'price': price,
  //   'colors': colors,
  //   'description':description,
  //   'image':image
  // };
}
