


 import 'package:doctors_app/presentaion/const/app_message.dart';
import 'package:doctors_app/presentaion/pay_mob/modules/payment/cubit/visacard.dart';
import 'package:doctors_app/presentaion/pay_mob/wallet_number.dart';
import 'package:doctors_app/presentaion/pay_mob/wallet_pay.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/resources/strings_manager.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/assets_manager.dart';
import 'constants/const.dart';
import 'models/first_token.dart';
import 'network/dio.dart';

class ChoosePaymentView extends StatelessWidget {
  bool sales;
  bool paid;
  bool ads;
  int days;
  String type;
  int adsNum;
  int freeAds;
  String email,city,name,name2,phone,price;

  ChoosePaymentView({required this.sales,required this.type,required this.ads,required this.days,required this.adsNum,required this.price,
    required this.email,required this.name,required this.paid,required this.name2,required this.city,required this.phone,
    required this.freeAds});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        toolbarHeight: 1,
        backgroundColor: ColorsManager.primary,
      ),
      body:ListView(
        children: [
          SizedBox(height: 10,),
          Container(
            height: 120,
            child:Image.asset(AssetsManager.Logo),
          ),
          SizedBox(height: 12,),

           InkWell(
            child: Padding(
              padding: const EdgeInsets.all(26.0),
              child: Container(
                decoration:BoxDecoration(
                  borderRadius:BorderRadius.circular(12),
                  color:ColorsManager.primary4
                ),
                child: Column(
                  children: [

                    Container(
                     width: 250,
                      child:Image.asset('assets/images/card3.jpg',
                      fit:BoxFit.fill
                      ),
                    ),
                    CustomButton(text: 'الدفع عن طريق البطاقات ', onPressed: (){






                    }, color1: ColorsManager.primary4, color2: Colors.white),
                  ],
                ),
              ),
            ),
             onTap:(){
               getFirstToken(price: price, email: email,
                   city: city, fname:name,
                   lname: name2, phonenum:phone,type:"visa");

               appMessage(text: 'قيد التحميل');

               //  if(FinalTokenCard!=''){gg
               Future.delayed(Duration(seconds: 3)).then((value) {

                 Get.to(VisaCard(sales: sales, ads: ads, days: days, adsNum: adsNum, freeAds: freeAds,
                   paid:paid,type: type,
                   finalToken: FinalTokenCard,
                 ));
               });
               //   }


             },
          ),


          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(26.0),
              child: Container(
                decoration:BoxDecoration(
                    borderRadius:BorderRadius.circular(12),
                    color:ColorsManager.primary4
                ),
                child: Column(
                  children: [
                    //SizedBox(height: 12,),
                    Container(width: 250,
                      child:  Image.asset('assets/images/wallet3.jpg',fit:BoxFit.fill),
                    ),
                    CustomButton(text: 'الدفع عن طريق المحافظ الالكترونية ', onPressed: () {
                      //Get.to();
                      }, color1: ColorsManager.primary4, color2: Colors.white),
                  ],
                ),
              ),
            ),
            onTap:(){

              Get.to(

                  WalletNumView
                (name: name, lname: name2, email: email, adsNum:
              adsNum, phone: phone, price: price,
                  paid: paid,
                  city: city, days: days, sales: sales, ads: ads, freeAds: freeAds,
                  type: type));

              // getFirstToken(price: price, email: email,
              //     city: city, fname:name,
              //     lname: name2, phonenum:phone,type: 'wallet');
              //
              // Future.delayed(Duration(seconds: 3)).then((value) {
              //   Get.to(WalletPay(sales: sales, ads: ads, days: days, adsNum: adsNum,
              //       type: type,
              //       freeAds: freeAds,url:url));
                //  Get.to(VisaCard(sales: sales, ads: ads, days: days, adsNum: adsNum, freeAds: freeAds));
          //    });
            },
          )
        ],
      ),
    );
  }
}

 FirstToken ? firstToken;

 Future getFirstToken ({required String price,required String email,required String type,
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

     print("PAYMOB FIRST==="+paymobFirstToken);
     getOrderId(price,email,city,fname,lname,phonenum,type);

   }).catchError((error){

     print(" ERROR =  "+error.toString());

   });

 }


 Future getOrderId(String price,String email,String city,String fname,String lname,String phonenum,String type)async{

   print("GET ORDER ID");

   DioHelperPayment.postData(url:'ecommerce/orders',data:{
     'auth_token':paymobFirstToken,
     'delivery_needed':'false',
     'amount_cents': price,
     "items": [
       {
         "name":  AppStrings.APPNAME,
         "amount_cents": "$price",
         "description": "from$city",
         "quantity": "1"
       },
     ],
     "currency": "EGP",


   } ).then((value) {

     print("tt");
     //  firstToken=FirstToken.fromJson(value.data);
     orderId=value.data['id'].toString();

     //firstToken.token.toString();
     print(" order id ="+orderId.toString());
     if(type=='visa'){

       print("VISA");
       getFinalTokenCard(price,email,city,fname,lname,phonenum,type);
     }

     else{

       print("WALLLET PAY");
       getFinalTokenWallet(price,email,city,fname,lname,phonenum,type);

     }
    // getFinalTokenWallet(price,email,city,fname,lname,phonenum);
   //  getFinalTokenKiosk(price,email,city,fname,lname,phonenum);

   }).catchError((error){
     print("ERROR = "+error.toString());
   });
 }



 Future getFinalTokenCard(String price,String email,String city, String fname,String lname,String phonenum ,String type )async{

   print("f="+paymobApiKey);
   print("f="+orderId);

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
     print(" Final Token  ="+ FinalTokenCard.toString());

    // getFinalTokenWallet(price,email,city,fname,lname,phonenum);
  //   getWallet();


   }).catchError((error){
     print("Error = "+error.toString());

   });
 }

 Future getFinalTokenWallet(String price,String email,String city, String fname,String lname,String phonenum,String type )async{

   print('WALLET');
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
     "integration_id":itegrationIdWallet,
     "lock_order_when_paid": "false"
   }

   // {
   //   "auth_token":paymobFirstToken,
   //   "amount_cents": price,
   //   "expiration": 3600,
   //   "order_id": orderId,
   //   "billing_data": {
   //     "apartment": "NA",
   //     "email": email,
   //     "floor": "NA",
   //     "first_name": fname,
   //     "street": "NA",
   //     "building": "NA",
   //     "phone_number": phonenum,
   //     "shipping_method": "NA",
   //     "postal_code": "NA",
   //     "city": city,
   //     "country": "NA",
   //     "last_name": lname,
   //     "state": "NA"
   //   },
   //   "currency": "EGP",
   //   "integration_id":itegrationIdWallet,
   //   "lock_order_when_paid": "false"
   // }



   ).then((value) {

     print("vvv walet=========="+value.toString());
     FinalTokenWallet=value.data['token'].toString();
     getWallet();
   }).catchError((error){
     print("ttxxx"+error.toString());
   });
 }

 Future getWallet()async{
   
   print("GET WALLET");

   DioHelperPayment.postData(url:'acceptance/payments/pay',data:


   {
     "source": {
       "identifier": '01010101010',
       //itegrationIdWallet,
       "subtype": "WALLET"
     },
     "payment_token":FinalTokenWallet,
     //paymobFirstToken,
     "wallet_payment_token":FinalTokenWallet

   }

   ).then((value) {

     print("VVV======="+value.data.toString());


     print("VVV======="+value.data['pending'].toString());
     
     RefWallet=value.data['id'].toString();

      url=value.data['redirect_url'].toString();
      //iframe_redirection_url
     String url2=value.data['redirect_url'].toString();

     print(" Ref  wallet   ="+RefWallet.toString());
     print(" Ref  wallet  url  ="+ url.toString());
     print(" Ref  wallet  url22222  ="+ url2.toString());

   }).catchError((error){
     print("ERROR  in wallet=   "+ error.toString());

   });

 }


