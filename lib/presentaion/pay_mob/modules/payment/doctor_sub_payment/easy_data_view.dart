


 import 'package:doctors_app/presentaion/bloc/auth/auth_cubit.dart';
import 'package:doctors_app/presentaion/bloc/auth/auth_states.dart';
import 'package:doctors_app/presentaion/const/app_message.dart';
import 'package:doctors_app/presentaion/pay_mob/choose.dart';
import 'package:doctors_app/presentaion/pay_mob/constants/const.dart';
import 'package:doctors_app/presentaion/pay_mob/models/first_token.dart';
import 'package:doctors_app/presentaion/pay_mob/network/dio.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:doctors_app/presentaion/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinput/pinput.dart';

import '../../../../resources/assets_manager.dart';
import '../cubit/refcode.dart';

class EasyDataView extends StatelessWidget {

  String price;
  bool paid;
  bool ads;
  int days;
  String type;
  int adsNum;
  int freeAds;
  EasyDataView({required this.price,required this.type,required this.paid,required this.ads,required this.days,required this.adsNum,required this.freeAds});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AuthCubit(),
        child:
        BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
          if (state is UserLoginLoadingState) {
            print("LOADING");
          }
        }, builder: (context, state) {
          AuthCubit authCubit = AuthCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: ColorsManager.primary,
              toolbarHeight: 1,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Container(
                        height: 140,
                        child: Image.asset(AssetsManager.Logo),),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),

                            const SizedBox(
                              height: 20,
                            ),
                            const Custom_Text(
                              text: ' بيانات اساسية للاشتراك  ',
                              fontSize: 24,
                              alignment: Alignment.center,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              height: 50,
                            ),


                            Container(
                              width: 350,
                              child: CustomTextFormField(
                                controller: authCubit.nameController,
                                color: Colors.black,
                                hint: " اسمك الاول  ",
                                obs: false,
                                obx: false,
                                ontap: () {},
                                type: TextInputType.text,
                              ),
                            ),

                            const SizedBox(
                              height: 40,
                            ),
                            Container(
                              width: 350,
                              child: CustomTextFormField(
                                controller: authCubit.nameController2,
                                color: Colors.black,
                                hint: " الاسم الاخير    ",
                                obs: false,
                                obx: false,
                                ontap: () {},
                                type: TextInputType.text,
                              ),
                            ),

                            const SizedBox(
                              height: 40,
                            ),
                            Container(
                              width: 350,
                              child: CustomTextFormField(
                                controller: authCubit.emailController,
                                color: Colors.black,
                                hint: " البريد الالكتروني   ",
                                obs: false,
                                obx: false,
                                ontap: () {},
                                type: TextInputType.text,
                              ),
                            ),


                            const SizedBox(
                              height: 40,
                            ),
                            Container(
                              width: 350,
                              child: CustomTextFormField(
                                controller: authCubit.phoneController,
                                color: Colors.black,
                                hint: " رقم الهاتف   ",
                                obs: false,
                                obx: false,
                                ontap: () {},
                                type: TextInputType.phone,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Container(
                              width: 350,
                              child: CustomTextFormField(
                                controller: authCubit.cityController,
                                color: Colors.black,
                                hint: " المدينة   ",
                                obs: false,
                                obx: false,
                                ontap: () {},
                                type: TextInputType.text,
                              ),
                            ),

                            const SizedBox(
                              height: 40,
                            ),
                            CustomButton(
                                text: " اشتراك  ",
                                onPressed: () {


                                  if(authCubit.emailController.text.contains('@')&&
                                  authCubit.cityController.length>2&&authCubit.nameController.text.length>1&&
                                  authCubit.nameController2.text.length>1&&authCubit.phoneController.text.length>7
                                  ){
                                    final box=GetStorage();
                                    box.write('docEmail2',authCubit.emailController.text);
                                    box.write('docName2',authCubit.nameController.text);
                                    box.write('docName3',authCubit.nameController2.text);
                                    box.write('city',authCubit.cityController.text);
                                    box.write('phone',authCubit.phoneController.text);
                                  //  appMessage(text: 'قيد التحميل ');

                                    // getFirstToken(price: price, email: authCubit.emailController.text,
                                    //     city: authCubit.cityController.text, fname:authCubit.nameController.text
                                    //     , lname: authCubit.nameController2.text, phonenum: authCubit.phoneController.text);


                                    Future.delayed(Duration(seconds: 1)).then((value) {

                                      //ref & visa
                                     // Get.to(RefCode2());
                                      Get.to(
                                          ChoosePaymentView(
                                            paid:paid,
                                            email:authCubit.emailController.text,
                                            price:price,
                                            city:authCubit.cityController.text,
                                            name:authCubit.nameController.text,
                                            name2:authCubit.nameController2.text,
                                            phone:authCubit.phoneController.text,
                                            sales: false,
                                            ads: ads,
                                            days:days,
                                            type: type,
                                            adsNum: adsNum,
                                            freeAds: freeAds,
                                          )
                                      );
                                      // Get.to(VisaCard(
                                      //   sales: false,
                                      //   ads: ads,
                                      //   days:days,
                                      //   adsNum: adsNum,
                                      //   freeAds: freeAds,
                                      // ));

                                    });
                                  }else{
                                    appMessage(text: 'ادخل البيانات بشكل سليم');
                                  }


                                  // tdawaCubit.dispalyFirst();
                                  // tdawaCubit. getDocotorAppointments();
                                },
                                color1: ColorsManager.primary,
                                color2: Colors.white),
                            const SizedBox(
                              height: 30,
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
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

     ],
     "currency": "EGP",


   } ).then((value) {

     print("tt");
     //  firstToken=FirstToken.fromJson(value.data);
     orderId=value.data['id'].toString();

     //firstToken.token.toString();
     print(" order id ="+orderId.toString());
     getFinalTokenCard(price,email,city,fname,lname,phonenum);
     getFinalTokenWallet(price,email,city,fname,lname,phonenum);
     getFinalTokenKiosk(price,email,city,fname,lname,phonenum);



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

 Future getFinalTokenKiosk(String price,String email,String city, String fname,String lname,String phonenum)async{

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
     "integration_id": itegrationIdKiosk,
     "lock_order_when_paid": "false"
   }



   ).then((value) {

     print("tt ref code ");
     //  firstToken=FirstToken.fromJson(value.data);
     FinalTokenKiosk=value.data['token'].toString();

     //firstToken.token.toString();
     print(" Final Token kiosk  ="+FinalTokenKiosk.toString());
     getRefCode();



   }).catchError((error){
     print("ttxxx ERROR ===== "+error.toString());

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

     print(" tt red 2");
     //  firstToken=FirstToken.fromJson(value.data);
     RefCode=value.data['id'].toString();

     //firstToken.token.toString();
     print(" Ref  code  ="+RefCode.toString());



   }).catchError((error){
     print("ERROR =   "+error.toString());

   });

 }


 Future getFinalTokenWallet(String price,String email,String city, String fname,String lname,String phonenum )async{

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
   ).then((value) {
     print("tt"+value.toString());
     //  firstToken=FirstToken.fromJson(value.data);
     FinalTokenWallet = value.data['token'].toString();
     redirect_url = value.data['redirect_url'].toString();
     //firstToken.token.toString();
     print(" Final Token Wallet   ="+FinalTokenWallet.toString());
     print(" Final url   ="+redirect_url.toString());
     //getRefCode();
     //emit((paymentRequestTokenKioskSate()));

   }).catchError((error){
     print("ttxxx"+error.toString());
   //  emit(paymentRequestTokenKioskErrorSate());
   });
 }

