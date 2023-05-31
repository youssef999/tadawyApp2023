

class  Sales {

  String ?id;
  String ? coins;
  String ?name;
  String ?email;

  Sales({
    this.id, this.name, this.coins,this.email
  });

  factory Sales.fromJson(Map<String,dynamic>json)=>Sales(
    id:json['id'],
   coins:(json['coins']),
   //int.parse(json['coins'].toString()),
    name: json['name'],
    email:json["email"]
  );

// Map<String, dynamic> toJson() => {
//   //'user_id': user_id,
//   'doctor_email': user_email,
//   'doctor_name': user_name,
//   'doctor_password': user_password,
//    'doctor_image':doctor_image
// };
}
