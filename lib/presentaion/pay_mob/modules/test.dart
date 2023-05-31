

 import 'package:doctors_app/presentaion/pay_mob/constants/const.dart';
import 'package:doctors_app/presentaion/pay_mob/models/first_token.dart';
import 'package:doctors_app/presentaion/pay_mob/network/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'payment/cubit/visacard.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30,),
          InkWell(
            child: Text("TEST"),
            onTap:(){
              getFirstToken(price: '55555', email: 'youssefmak2020@gmail.co,',
                  city: 'cairo', fname: 'youssef', lname: 'omar', phonenum: '+201097970465');
              Future.delayed(Duration(seconds: 4)).then((value) {
                // Get.to(VisaCard(
                //                    name:'youssef',
                //                    email: 'youssefmak2020@gmail.com',
                //                    code: '111'??"",
                //                    d_app: ''??"",
                //                   from: '',
                //                   nsba_offer: '',
                //                  num: '32111',
                //                phone: '+201097970465',
                //                point: '',
                //                status: '',
                //                to: '',
                //                total: '11111',
                //                trip: '',
                //
                //              ));
              });
            },
          )
        ],
      ),
    );
  }
}


 FirstToken ? firstToken;

 Future getFirstToken ({required String price,required String email,
   required String city,required String fname,required String lname,required String phonenum})
 async
 {
   print("FIRST...........");
   DioHelperPayment.postData(url:'auth/tokens',data:{
     'api_key':paymobApiKey,

   } ).then((value) {
     print("VALUE");
     print(value.data.toString());
       firstToken=FirstToken.fromJson(value.data);
        paymobFirstToken=value.data['token'];
     //
     //   //firstToken.token.toString();
     //   print("First token ="+paymobFirstToken.toString());
      getOrderId(price,email,city,fname,lname,phonenum);

   }).catchError((error){
     print(" ERROR =  "+error.toString());

   });

 }


 Future getOrderId(String price,String email,String city,String fname,String lname,String phonenum)async{

   print("GET ORDER ID");
   DioHelperPayment.postData(url:'ecommerce/orders',data:{
     'auth_token':paymobFirstToken,
     'delivery_needed':'false',
     'amount_cents': price,
     "items": [
       {
         "name": "trip",
         "amount_cents": "$price",
         "description": "from$city",
         "quantity": "1"
       },
       // {
       //   "name": "ERT6565",
       //   "amount_cents": "200000",
       //   "description": "Power Bank",
       //   "quantity": "1"
       // }
     ],
     "currency": "EGP",


   } ).then((value) {

     print("tt");
     //  firstToken=FirstToken.fromJson(value.data);
     orderId=value.data['id'].toString();

     //firstToken.token.toString();
     print(" order id ="+orderId.toString());
     getFinalTokenCard(price,email,city,fname,lname,phonenum);
     getFinalTokenKiosk(price);



   }).catchError((error){
     print("ERROR = "+error.toString());
   });
 }

 Future getFinalTokenCard(String price,String email,String city, String fname,String lname,String phonenum , )async{

   DioHelperPayment.postData(url:'acceptance/payment_keys',data:

   {
     "auth_token":paymobFirstToken,
     "amount_cents": price,
     "expiration": 3600,
     "order_id": orderId,
     "billing_data": {
       "apartment": "NA",
       "email": email,
       "floor": "NA",
       "first_name": fname,
       "street": "NA",
       "building": "NA",
       "phone_number": phonenum,
       "shipping_method": "NA",
       "postal_code": "NA",
       "city": city,
       "country": "NA",
       "last_name": lname,
       "state": "NA"
     },
     "currency": "EGP",
     "integration_id": integrationIdCard,
     "lock_order_when_paid": "false"
   }


   ).then((value) {

     print("tt");
     //  firstToken=FirstToken.fromJson(value.data);
     FinalTokenCard=value.data['token'].toString();

     //firstToken.token.toString();
     print(" Final Token  ="+FinalTokenCard.toString());



   }).catchError((error){
     print("Error = "+error.toString());

   });

 }

 Future getFinalTokenKiosk(String price)async{

   DioHelperPayment.postData(url:'acceptance/payment_keys',data:

   {
     "auth_token":paymobFirstToken,
     "amount_cents": price,
     "expiration": 3600,
     "order_id": orderId,
     "billing_data": {
       "apartment": "803",
       "email": "claudette09@exa.com",
       "floor": "42",
       "first_name": "Clifford",
       "street": "Ethan Land",
       "building": "8028",
       "phone_number": "+86(8)9135210487",
       "shipping_method": "PKG",
       "postal_code": "01898",
       "city": "Jaskolskiburgh",
       "country": "CR",
       "last_name": "Nicolas",
       "state": "Utah"
     },
     "currency": "EGP",
     "integration_id": itegrationIdKiosk,
     "lock_order_when_paid": "false"
   }


   ).then((value) {

     print("tt");
     //  firstToken=FirstToken.fromJson(value.data);
     FinalTokenKiosk=value.data['token'].toString();

     //firstToken.token.toString();
     print(" Final Token kiosk  ="+FinalTokenKiosk.toString());
     getRefCode();



   }).catchError((error){
     print("ttxxx"+error.toString());

   });

 }

 Future getRefCode()async{

   DioHelperPayment.postData(url:'acceptance/payments/pay',data:


   {
     "source": {
       "identifier": "AGGREGATOR",
       "subtype": "AGGREGATOR"
     },
     "payment_token": FinalTokenKiosk
   }

   ).then((value) {

     print("tt");
     //  firstToken=FirstToken.fromJson(value.data);
     RefCode=value.data['id'].toString();

     //firstToken.token.toString();
     print(" Ref  code  ="+RefCode.toString());



   }).catchError((error){
     print("ERROR =   "+error.toString());

   });

 }