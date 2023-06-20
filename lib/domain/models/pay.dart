

class  Pay{

  String ?id;
  String?doctor_id;
  String ?total;
  String ?type;
  String ?order_id;
  String ?status;


  Pay({

    this.id, this.doctor_id, this.total,
    this.type,this.order_id,this.status

  });

  factory Pay.fromJson(Map<String,dynamic>json)=>Pay(
    id:json['id'],
    doctor_id: json['doctor_id'],
    total: json['total'],
    type:json['type'],
    order_id: json['order_id'],
    status: json['status']
  );

// Map<String, dynamic> toJson() => {
//   //'user_id': user_id,
//   'doctor_email': user_email,
//   'doctor_name': user_name,
//   'doctor_password': user_password,
//    'doctor_image':doctor_image
// };
}
