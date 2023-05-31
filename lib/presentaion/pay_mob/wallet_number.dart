



 import 'package:doctors_app/presentaion/pay_mob/wallet_pay.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/resources/strings_manager.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:doctors_app/presentaion/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/assets_manager.dart';
import 'constants/const.dart';
import 'models/first_token.dart';
import 'network/dio.dart';

class WalletNumView extends StatelessWidget {

  String name,lname,email,phone,price,city,type;
  bool sales,ads,paid;
  int freeAds,days,adsNum;

  WalletNumView({
      required this.name,
      required this.lname,
      required this.email,
    required this.paid,
    required this.adsNum,
      required this.phone,
      required this.price,
      required this.city,
    required this.days,
      required this.sales,
      required this.ads,
      required this.freeAds,
      required this.type,
      });

  TextEditingController controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        toolbarHeight: 3,
        backgroundColor:ColorsManager.primary,
      ),
      body:Padding(
        padding: const EdgeInsets.all(21.0),
        child: ListView(
          children: [
            SizedBox(height: 21,),
            Container(
              height: 168,
              child: Image.asset(AssetsManager.Logo),
            ),
            SizedBox(height: 20,),
            CustomTextFormField(hint:'رقم المحفظة'
                , obx: false
                , ontap:(){}, type:TextInputType.number, obs: false, color:Colors.black
                , controller: controller),
            SizedBox(height: 20,),

            CustomButton(text:'شراء', onPressed:(){
              getFirstToken(price: price, email: email,
                  city: city, fname:name,
                  lname: lname, phonenum:phone,type: 'wallet');

              Future.delayed(Duration(seconds: 3)).then((value) {
                Get.to(WalletPay(sales: sales, ads: ads, days: days, adsNum: adsNum,
                    type: type,paid: paid,
                    freeAds: freeAds,url:url));
                //  Get.to(VisaCard(sales: sales, ads: ads, days: days, adsNum: adsNum, freeAds: freeAds));
              });
            } , color1:ColorsManager.primary
                , color2:Colors.white)
          ],
        ),
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
     "amount_cents":price,
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
   //  "wallet_payment_token":FinalTokenWallet

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


