

class  User {

  String ?id;
  String? email;
  String ?name;
  String ?password;
  String ?image;
  String ?phone;



  User({

    this.id, this.email, this.name,
    this.password,this.image,this.phone

  });

  factory User.fromJson(Map<String,dynamic>json)=>User(

   id:json['user_id']??"",
   //int.parse(json['id'].toString()),
    email: json['email']??"",
    name: json['name']??"",
    password:json['password']??'',
    image: json["image"]??'',
    phone: json["phone"]??'',
  );

// Map<String, dynamic> toJson() => {
//   //'user_id': user_id,
//   'doctor_email': user_email,
//   'doctor_name': user_name,
//   'doctor_password': user_password,
//    'doctor_image':doctor_image
// };
}
