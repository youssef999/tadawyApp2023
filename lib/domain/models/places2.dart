

class  Places2 {

  String ?id;
  String?place;
  String ?name;


  Places2({

    this.id, this.name, this.place,

  });

  factory Places2.fromJson(Map<String,dynamic>json)=>Places2(
    id:json['id'],
   place: json['place'],
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
