

 import 'dart:io';

import 'package:doctors_app/domain/models/user.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../booking/book_view.dart';

class DoctorDetailsView extends StatelessWidget {

  DoctorModel doctorData;
  double price;
  DoctorDetailsView(this.doctorData,this.price);

  @override
  Widget build(BuildContext context) {
    final box=GetStorage();
    String currency=box.read('currency')??"";
    return Scaffold(
      backgroundColor:ColorsManager.primaryx,
      appBar:AppBar(
        elevation: 0,
        toolbarHeight: 6,
        backgroundColor:ColorsManager.primary,
      ),
      body:Directionality(
        textDirection:TextDirection.rtl,
        child:

        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              const SizedBox(height: 20,),
              (doctorData.doctor_image!.length>6)?
              SizedBox(
                width: 230,
                child:Image.network
                  (doctorData.doctor_image.toString()),
              ):SizedBox(
                height: 100,
               // width: MediaQuery.of(context).size.width * 0.30,
                child:Image.asset('assets/images/doc.png'),
              ),
              const SizedBox(height: 10,),
             Column(
                children: [
                  Custom_Text(
                    text: doctorData.doctor_name.toString(),
                    color:ColorsManager.black,
                    fontSize: 20,
                    alignment:Alignment.topRight,
                  ),
                  const SizedBox(height: 15,),

                  (doctorData.cat2=='طبيب')?
                  Custom_Text(
                    alignment:Alignment.topRight,
                    text: doctorData.doctor_cat.toString(),
                    color:ColorsManager.primary,
                    fontSize: 20,
                  ):SizedBox()
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Divider(height: 3,color:Colors.black),
              ),

              Row(
                children: [

                  Icon(Icons.phone,color:ColorsManager.primary,),
                  const SizedBox(width: 60,),
                  Column(
                    children: [

                      Custom_Text(text: 'الرقم  ',alignment: Alignment.topRight),
                      SizedBox(height: 10,),
                      Custom_Text(text: doctorData.doctor_phone.toString(),alignment:Alignment.center,
                        fontSize:15,
                        color:ColorsManager.black,
                      ),
                      SizedBox(height: 10,),

                      (doctorData.cat2=='طبيب')?
                      Column(
                        children: [
                          Custom_Text(text: 'رقم  موبيل ',alignment: Alignment.topRight),
                          SizedBox(height: 10,),
                          Custom_Text(text:  doctorData.doctor_phone1.toString(),alignment:Alignment.center,
                            fontSize:15,
                            color:ColorsManager.black,
                          ),
                          SizedBox(height: 10,),
                          Custom_Text(text: 'رقم  واتس ',alignment: Alignment.topRight),
                          SizedBox(height: 10,),
                          Custom_Text(text:  doctorData.doctor_phone2.toString(),alignment:Alignment.center,
                            fontSize:15,
                            color:ColorsManager.black,
                          ),
                          SizedBox(height: 6,),
                        ],
                      ):SizedBox()

                    ],
                  )


                ],
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Divider(height: 3,color:Colors.black),
              ),


             // (doctorData.address.toString()!='')?

              Row(
                children: [
                 Icon(Icons.place,color:ColorsManager.primary,),
                  const SizedBox(width: 20,),

                  (doctorData.address!='')?
                  Container(
                    width: 170,
                    child: Custom_Text(text: doctorData.address.toString(),alignment:Alignment.topRight,
                      fontSize:13,
                      color:ColorsManager.black,
                    ),
                  ):SizedBox(),
                  const SizedBox(width: 10,),
                  Container(
                    child: Column(
                      children: [
                        Custom_Text(text: doctorData.time.toString(),alignment:Alignment.topRight,
                          fontSize:15,
                          color:ColorsManager.black,
                        ),
                        SizedBox(height: 10,),
                        Icon(Icons.arrow_circle_down_outlined,color: ColorsManager.primary,size: 37,),
                        SizedBox(height: 10,),
                        Custom_Text(text: doctorData.time1x.toString(),alignment:Alignment.topRight,
                          fontSize:15,
                          color:ColorsManager.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15,),
              Custom_Text(text: '- - - - - - - - - - - - - - - - -',fontSize: 21,color:ColorsManager.primary,alignment: Alignment.center,),

              const SizedBox(height: 15,),


              (doctorData.delivery=='true')?
              Custom_Text(text: 'متاح خدمة التوصيل   ',
                alignment:Alignment.topRight,
                fontSize:22,
                color:Colors.black,
              ):SizedBox(),


              SizedBox(
                height: 11,
              ),
              (doctorData.fullService=='true')?
              Custom_Text(text: ' متاح خدمة ٢٤ ساعة ',alignment:Alignment.topRight,
                fontSize:15,
                color:Colors.grey,
              ):SizedBox(),

              (doctorData.lat==null)?
              InkWell(
                child: Row(
                  children:  [

                    Icon(Icons.maps_ugc_sharp,color:ColorsManager.primary,),
                    SizedBox(width: 20,),
                    Custom_Text(text: 'الموفع  علي الخريطة    -  ',alignment:Alignment.topRight,
                      fontSize:15,
                      color:Colors.grey,
                    ),
                    SizedBox(width: 10,),

                  ],
                ),
                onTap:(){

                  print(doctorData.lat);
                  url(doctorData.lat!,doctorData.lng!);

                },
              ):SizedBox(height: 1,),


              (doctorData.address2.toString()!='')?

              Row(
                children: [

            Icon(Icons.place,color:ColorsManager.primary,),
                  const SizedBox(width: 20,),
                  Container(
                    width: 170,
                    child: Custom_Text(text: doctorData.address2.toString(),alignment:Alignment.topRight,
                      fontSize:15,
                      color:ColorsManager.black,
                    ),
                  ),
                  const SizedBox(width: 50,),
                  Column(
                    children: [
                      Custom_Text(text: doctorData.time2.toString(),alignment:Alignment.topRight,
                        fontSize:15,
                        color:ColorsManager.black,
                      ),
                      Icon(Icons.arrow_circle_down_outlined,color: ColorsManager.primary,size: 37,),
                      SizedBox(height: 10,),
                      Custom_Text(text: doctorData.time2x.toString(),alignment:Alignment.topRight,
                        fontSize:15,
                        color:ColorsManager.black,
                      ),
                    ],
                  ),

                ],
              ) :const SizedBox(
                height: 1,
              ),


              const SizedBox(height: 6,),
              if(doctorData.location2!='')
              InkWell(
                child: Row(
                  children:  [
                    SizedBox(width: 60,),
                    Icon(Icons.maps_ugc_sharp,color:ColorsManager.primary,),
                    SizedBox(width: 20,),
                    Custom_Text(text: doctorData.location2! ,alignment:Alignment.center,
                      fontSize:15,
                      color:Colors.grey,
                    ),
                    SizedBox(width: 10,),
                  ],
                ),
                onTap:(){
                  print(doctorData);
                  url(doctorData.lat!,doctorData.lng!);
                },
              ),

              const SizedBox(height: 15,),
              (doctorData.address3.toString()!='')?

              Row(
                children: [

                Icon(Icons.place,color:ColorsManager.primary,),
                  const SizedBox(width: 20,),
                  Custom_Text(text: doctorData.address3.toString(),alignment:Alignment.topRight,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                  const SizedBox(width: 10,),
                  Custom_Text(text: doctorData.time2.toString(),alignment:Alignment.topRight,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                ],
              ) :const SizedBox(),

              const SizedBox(height: 15,),
                 const SizedBox(height: 25,),

              (doctorData.price!.length>1&&doctorData.price!='')?
              Row(
                children: [
                 Icon(Icons.price_change,color:ColorsManager.primary,),
                  const SizedBox(width: 20,),
                  const Custom_Text(text: 'السعر   -  ',alignment:Alignment.topRight,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                  const SizedBox(width: 10,),
                  //(double.parse(listApp[index].price!)/price).toStringAsFixed(1)+" " +currency,
                  Custom_Text(text: (double.parse(doctorData.price!)/price).toStringAsFixed(1)+" "+currency,alignment:Alignment.topRight,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),

                ],
              ):SizedBox(),
              const SizedBox(height: 25,),



              const Padding(
                padding: EdgeInsets.only(left:36.0,right:36.0),
                child: Divider(
                  height:6,
                  color:Colors.black,
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                children: [

                  Container(
                    child: Image.asset('assets/images/profile.png'),
                  ),
                  const SizedBox(width: 20,),
                  const Custom_Text(text: ' معلوماتي  ',alignment:Alignment.topRight,
                    fontSize:24,
                    color:ColorsManager.black,
                  ),
                  
                  const SizedBox(width: 10,),



                ],
              ),
              const SizedBox(height: 15,),




              Custom_Text(text: doctorData.doctor_info.toString(),alignment:Alignment.center,
                fontSize:15,
                color:ColorsManager.black,
              ),
              const SizedBox(height: 22,),
              (doctorData.image1!='' && doctorData.image1!=null)?
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
            width: 70,
                    child:Image.network(doctorData.image1!,)
                ),
              ):SizedBox(height: 1,),
              const SizedBox(height: 22,),

              (doctorData.doctor_degree.toString().length>1)?
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        child: Image.asset('assets/images/grade.png'),
                      ),
                      const SizedBox(width: 20,),
                      const Custom_Text(text: ' الدرجة العلمية ',alignment:Alignment.topRight,
                        fontSize:24,
                        color:ColorsManager.black,
                      ),
                      const SizedBox(width: 10,),
                      const SizedBox(height: 12,),

                      Custom_Text(text: doctorData.doctor_degree.toString(),alignment:Alignment.center,
                        fontSize:15,
                        color:ColorsManager.black,
                      ),
                    ],
                  ),

                ],
              ):SizedBox(),



              const SizedBox(height: 20,),
              (doctorData.image2!=''&&doctorData.image2!=null)?
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                   width: 70,
                  //  height: 100,
                    child:Image.network(doctorData.image2!,
                    fit:BoxFit.fill,
                    )
                ),
              ):SizedBox(height: 1,),
              const SizedBox(height: 20,),



              (doctorData.image2.toString()!='')?
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  //   width: 100,
                  height: 140,
                  child: Image.network(doctorData.image2.toString(),fit:BoxFit.fill),
                ),
              ):SizedBox(),
              const SizedBox(height: 12,),
              Custom_Text(text: doctorData.doctor_degree.toString(),alignment:Alignment.center,
                fontSize:15,
                color:ColorsManager.black,
              ),
              const SizedBox(height: 22,),
              ( doctorData.clink_name2!.isNotEmpty)?
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Divider(height: 2,thickness: 2,color:Colors.grey,),
                  ),
                  SizedBox(height: 10,),
                  Custom_Text(text: 'مكان عملك الاخر',alignment:Alignment.center,
                    fontSize:22,
                    color:ColorsManager.black,
                  ),
                  SizedBox(height: 10,),

                  Custom_Text(text: doctorData.clink_name2.toString(),alignment:Alignment.center,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                  SizedBox(height: 10,),
                  Custom_Text(text: doctorData.address2.toString(),alignment:Alignment.center,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                  SizedBox(height: 10,),
                  Custom_Text(text: 'رقم  ارضي ',alignment: Alignment.topRight),
                  //  SizedBox(height: 6,),
                  Custom_Text(text: doctorData.clink_phone4.toString(),alignment:Alignment.center,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                  SizedBox(height: 6,),
                  Custom_Text(text: 'رقم  موبيل ',alignment: Alignment.topRight),
                  //  SizedBox(height: 6,),
                  Custom_Text(text: doctorData.clink_phone5.toString(),alignment:Alignment.center,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                  SizedBox(height: 6,),
                  Custom_Text(text: 'رقم  واتس ',alignment: Alignment.topRight),
                  //  SizedBox(height: 6,),
                  Custom_Text(text: doctorData.clink_phone6.toString(),alignment:Alignment.center,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                  SizedBox(height: 6,),
                  Custom_Text(text: 'المنصب ',alignment: Alignment.topRight),
                  //   SizedBox(height: 6,),
                  Custom_Text(text: doctorData.clink_p2.toString(),alignment:Alignment.center,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                ],
              ):SizedBox(height: 1,),

              ( doctorData.clink_name3!.isNotEmpty)?
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Divider(height: 2,thickness: 2,color:Colors.grey,),
                  ),
                  SizedBox(height: 10,),
                  Custom_Text(text: 'مكان عملك الاخر',alignment:Alignment.center,
                    fontSize:22,
                    color:ColorsManager.black,
                  ),
                  SizedBox(height: 10,),

                  Custom_Text(text: doctorData.clink_name3.toString(),alignment:Alignment.center,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                  SizedBox(height: 10,),
                  Custom_Text(text:doctorData.address3.toString(),alignment:Alignment.center,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                  SizedBox(height: 10,),
                  Custom_Text(text: 'رقم  ارضي ',alignment: Alignment.topRight),
                  //  SizedBox(height: 6,),
                  Custom_Text(text: doctorData.clink_phone7.toString(),alignment:Alignment.center,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                  SizedBox(height: 6,),
                  Custom_Text(text: 'رقم  موبيل ',alignment: Alignment.topRight),
                  //  SizedBox(height: 6,),
                  Custom_Text(text: doctorData.clink_phone8.toString(),alignment:Alignment.center,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                  SizedBox(height: 6,),
                  Custom_Text(text: 'رقم  واتس ',alignment: Alignment.topRight),
                  //  SizedBox(height: 6,),
                  Custom_Text(text:doctorData.clink_phone9.toString(),alignment:Alignment.center,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                  SizedBox(height: 6,),
                  Custom_Text(text: 'المنصب ',alignment: Alignment.topRight),
                  //   SizedBox(height: 6,),
                  Custom_Text(text:doctorData.clink_p3.toString(),alignment:Alignment.center,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),

                ],
              ):SizedBox(height: 1,),



              SizedBox(height: 12,),

              CustomButton(
                text: "احجز الان ",
                color1:ColorsManager.primary,
                color2:Colors.white,
                onPressed:(){

                  print("d="+doctorData.days.toString());
                  Get.to( BookingView(
                    doctorId: doctorData.doctor_id.toString(),
                    days: doctorData.days.toString(),
                    doctorToken: doctorData.token.toString(),
                  ));

                  },
              )
            ],
          ),
        ),
      ),
    );
  }
}
  url(String lat,String lng) async {
   // var l1 = 37.43296265331129;
   // var l2 = -122.08832357078792;
  String link='https://www.google.com/maps/search/?api=1&query=$lat,$lng';
//  String link2='https://www.google.com/maps/search/?api=1&query=37.43296265331129,-122.08832357078792';
   if (Platform.isAndroid) {

       await canLaunch(link)?launch(link) :launch(link); // new line
   } else {
     // add the [https]
     await canLaunch(link)?launch(link) :launch(link); // new line
   }

 }