
import 'package:doctors_app/domain/models/bouquet.dart';
import 'package:doctors_app/presentaion/const/app_message.dart';
import 'package:doctors_app/presentaion/pay_mob/choose.dart';
import 'package:doctors_app/presentaion/pay_mob/constants/const.dart';
import 'package:doctors_app/presentaion/pay_mob/models/first_token.dart';
import 'package:doctors_app/presentaion/pay_mob/modules/payment/doctor_sub_payment/easy_data_view.dart';
import 'package:doctors_app/presentaion/pay_mob/network/dio.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/views/Doctor/doctor_ads/create_ad_view.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class BakaWidget extends StatelessWidget {

  List<Baka> bakaList;
  bool sales;
  int numAds;
  String type;
  BakaWidget({required this.bakaList,required this.type,required this.numAds,required this.sales});

  @override
  Widget build(BuildContext context) {


    return  Container(
      height: 630,

      child: ListView.builder(
        scrollDirection: Axis.horizontal,
         // physics: const NeverScrollableScrollPhysics(),
          itemCount: bakaList.length,
          itemBuilder: (context, index) {
            return
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width:MediaQuery.of(context).size.width*0.43,
                  decoration:BoxDecoration(
                      borderRadius:BorderRadius.circular(20),
                      color:ColorsManager.white
                  ),
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 10,),
                          Custom_Text(text: bakaList[index].name.toString(),
                            fontSize:19,
                            color:Colors.black,
                            alignment:Alignment.center,
                          ),
                          const SizedBox(height: 50,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Custom_Text(text: bakaList[index].details.toString(),
                              fontSize:19,
                              color:Colors.black,
                              alignment:Alignment.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Custom_Text(text: bakaList[index].description.toString(),
                              fontSize:14,
                              color:ColorsManager.primary,
                              alignment:Alignment.center,
                            ),
                          ),
                          const SizedBox(height: 60,),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Custom_Text(text: 'سعر الباقة',
                              fontSize:17,
                              color:Colors.black,
                              alignment:Alignment.center,
                            ),
                          ),
                          Card(
                            color:ColorsManager.primary,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Custom_Text(
                                text: bakaList[index].price.toString(),
                                fontSize:20,
                                color:Colors.white,
                                alignment:Alignment.center,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30,),
                          const Divider(
                            color:Colors.grey,
                            height: 6,
                          ),

                         Padding(
                            padding: const EdgeInsets.only(right: 20.0,top:20),
                            child: Column(
                              children: [
                                const Custom_Text(text: 'مميزات الباقة : ',
                                color:Colors.black,
                                  alignment:Alignment.topRight,
                                  fontSize:20,
                                ),
                                const SizedBox(height: 10,),
                                Container(
                                  height: 90,
                                  child: Custom_Text(text:bakaList[index].adv,
                                    color:ColorsManager.primary,
                                    alignment:Alignment.topRight,
                                    fontSize:14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30,),
                          CustomButton(
                            text: 'اختار الباقة',
                            color1:ColorsManager.primary,
                            color2:Colors.white,
                            onPressed:(){
                              final box=GetStorage();
                              String docEmail = box.read('docEmail2')??'x';
                              if(sales==true){
                                Get.to(
                                    CreateAdView(days:bakaList[index].days,  sales: sales,
                                        free: false, numOfAds: bakaList[index].freeAds,
                                     type:type
                                    )
                                );
                              }
                              else if(docEmail!='x') {
                                String docName=box.read('docName2')??"maged";
                                String docName2=box.read('docName3')??"tdaway";
                                String city=box.read('city')??"cairo";
                                String phone=box.read('city')??"+201120007266";
                                appMessage(text: 'قيد التحميل ');

                                // getFirstToken(price: (bakaList[index].price*100).toString(),
                                //     email: docEmail,
                                //     city: city, fname:docName
                                //     , lname: docName2, phonenum: phone);


                                Future.delayed(Duration(seconds: 4)).then((value) {

                                  Get.to(
                                      ChoosePaymentView(
                                        email:docEmail,
                                        price: (bakaList[index].price*100).toString(),
                                        city:city,
                                        name:docName,
                                        name2:docName2,
                                        phone:phone,
                                        sales: false,
                                        paid: false,
                                        type: type,
                                        ads: true,
                                        days:bakaList[index].days,
                                        adsNum: bakaList[index].freeAds,
                                        freeAds: numAds,
                                      )
                                  );
                                  // Get.to(VisaCard(
                                  //   sales: false,
                                  //   ads: true,
                                  //   days: bakaList[index].days,
                                  //   adsNum: bakaList[index].freeAds,
                                  //   freeAds:numAds
                                  // ));
                                });

                              } else{

                                if(sales==true){
                                  Get.to(
                                    CreateAdView(days:bakaList[index].days,  sales: sales,type: type,
                                        free: false, numOfAds: bakaList[index].freeAds)
                                  );
                                }
                                else{
                                  Get.to
                                    (EasyDataView(price:  (bakaList[index].price*100).toString(), ads: true,
                                    days: bakaList[index].days,
                                    paid: false,
                                    type: type,
                                    adsNum: bakaList[index].freeAds,
                                    freeAds: numAds,
                                  ));
                                }


                              }


                              // Get.to( CreateAdView(
                              //   days: bakaList[index].days,
                              //   sales:sales
                              // ));



                            },
                          )
                        ],
                      ),
                    ),
                    onTap:(){
                    },
                  ),
                ),
              );
          }),
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