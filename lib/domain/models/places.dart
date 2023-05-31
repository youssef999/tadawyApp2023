

class  Places {

  String ?id;
  String?country;
  String ?name;


  Places({

    this.id, this.name, this.country,

  });

  factory Places.fromJson(Map<String,dynamic>json)=>Places(
    id:json['id'],
   country: json['country'],
    name: json['name'],
  );

// Map<String, dynamic> toJson() => {
//   //'user_id': user_id,
//   'doctor_email': user_email,
//   'doctor_name': user_name,
//   'doctor_password': user_password,
//    'doctor_image':doctor_image
// };
}
