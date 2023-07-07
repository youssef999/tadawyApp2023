


class  DoctorModel {

  String ?doctor_id;
  String? doctor_email;
  String ?doctor_name;
  String ?doctor_password;
  String ?doctor_image;
  String ?image1;
  String ?image;
  String ?doctor_phone;
  String ?doctor_phone1;
  String ?clink_name1;
  String ?clink_name2;
  String ?clink_name3;
  String ?clink_p1;
  String ?clink_p2;
  String ?clink_p3;
  String ?clink_phone1;
  String ?clink_phone2;
  String ?clink_phone3;
  String ?clink_phone4;
  String ?clink_phone5;
  String ?clink_phone6;
  String ?clink_phone7;
  String ?clink_phone8;
  String ?clink_phone9;






  String ?doctor_phone2;
  String ?doctor_phone3;
  String ?doctor_cat;
  String ?cat2;
  String ?place;
  String ?place2;
  String ?doctor_info;
  String ?doctor_degree;
  String ?position;
  String ?price;
  String ? days;
  String ? token;
  int ?days2;
  String ?country;
  String ?paid;

  String ?image2;
  String ? lat;
  String ? lng;
  String ?address;
  String ?address2;
  String ?address3;
  String ?time;
  String ?time2;
  String ?time3;
  String ?location;
  String ?location2;
  String ?location3;
  String ?time1x;
  String ?time2x;
  String ?time3x;
  int ? rate;
  int ? freeAds;

  DoctorModel({

    this.doctor_id, this.doctor_email, this.doctor_name,this.place,this.place2,
    this.doctor_phone,this.doctor_cat,this.country,this.days2,
    this.doctor_degree,this.cat2,this.days,this.rate,this.image1,this.image2,
    this.doctor_phone1,this.doctor_phone2,this.doctor_phone3,
    this.address,this.address2,this.address3,
    this.time1x,this.time2x,this.time3x,
    this.time,this.time2,this.time3,this.freeAds,
    this.lat,this.lng,this.paid,this.token,
this.clink_name1,this.clink_name2,this.clink_name3,
this.clink_p1,this.clink_p2,this.clink_p3,
this.clink_phone1,this.clink_phone2,this.clink_phone3,
this.clink_phone4,this.clink_phone5,this.clink_phone6,
this.clink_phone7,this.clink_phone8,this.clink_phone9,
    this.location,this.location2,this.location3,
    this.doctor_info,this.position,this.price,
    this.doctor_password,this.doctor_image
  });

  factory DoctorModel.fromJson(Map<String,dynamic>json)=>DoctorModel(

      doctor_id:json['doctor_id']??'',
      paid:json["paid"]??"",
      lat: json['lat']??"",
      lng: json['lng']??"",
      time1x: json['time1x']??'',
      time2x: json['time2x']??'',
      time3x: json['time3x']??'',
      image1:json['image1']??'',
      image2:json['image2']??'',
      clink_name1: json['clink_name1']??'',
      clink_name2: json['clink_name2']??"",
      clink_name3: json['clink_name3']??'',
      clink_p1: json['clink_p1']??"",
      clink_p2: json['clink_p2']??'',
      clink_p3: json['clink_p3']??'',
      token:json['token']??"",
      clink_phone1: json['clink_phone1']??'',
      clink_phone2: json['clink_phone2']??'',
      clink_phone3: json['clink_phone3']??'',
      clink_phone4: json['clink_phone4']??'',
      clink_phone5: json['clink_phone5']??'',
      clink_phone6: json['clink_phone6']??'',
      clink_phone7: json['clink_phone7']??'',
      clink_phone8: json['clink_phone8']??'',
      clink_phone9: json['clink_phone9']??'',

      //int.parse(json['doctor_id'].toString()),
     doctor_email: json['doctor_email']??"",
     doctor_name: json['doctor_name']??'',
        country: json['country']??"",
      place:json['palce']??"",
      place2:json["place2"]??'',
      rate:int.parse(json['rate']),
      days2: int.parse(json['ads_days'])??0,
      freeAds:int.parse(json['free_ads'])??0,
      days:json["days"]??'',
      doctor_password:json['doctor_password']??'',
      doctor_cat: json["doctor_cat"]??'',
      cat2:json["cat2"]??'',
      doctor_degree: json["doctor_degree"]??'',
      doctor_info: json["doctor_info"]??'',
      doctor_phone: json["doctor_phone"]??'',
      doctor_phone1: json["doctor_phone1"]??'',
      doctor_phone2: json["doctor_phone2"]??'',
      doctor_phone3: json["doctor_phone3"]??"",
      doctor_image:json['doctor_image']??'',
      position:json['position']??'',
      price:json['price']??'',
     address: json["address1"]??'',
     address2: json["address2"]??'',
     address3: json["address3"]??'',
     time: json["time1"]??"",
     time2: json["time2"]??'',
     time3: json["time3"]??'',
     location: json['location1']??'',
     location2: json['location2']??"",
     location3: json['location3']??"",

  );

  // Map<String, dynamic> toJson() => {
  //   //'user_id': user_id,
  //   'doctor_email': user_email,
  //   'doctor_name': user_name,
  //   'doctor_password': user_password,
  //    'doctor_image':doctor_image
  // };
}
