import 'dart:io';
import 'package:doctors_app/presentaion/bloc/patient/patient_cubit.dart';
import 'package:doctors_app/presentaion/bloc/patient/patient_states.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../domain/models/ads.dart';
import '../../../resources/color_manager.dart';
import '../../../widgets/Custom_button.dart';
import '../booking/book_view.dart';

class DoctorDatadocWithId extends StatelessWidget {

String id;
Ads ad;
DoctorDatadocWithId({super.key,required this.id,required this.ad});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create:(BuildContext context)=>PatientCubit()
          ..getDoctorData(id),


        child: BlocConsumer<PatientCubit,PatientStates>(
        listener:(context,state){

    },
    builder:(context,state){

    PatientCubit cubit = PatientCubit.get(context);
    final box=GetStorage();
    String currency=box.read('currency')??"";
    return Scaffold(
      appBar: AppBar(
        backgroundColor:ColorsManager.primary,
      ),
      body:      Directionality(
        textDirection:TextDirection.rtl,
        child:

        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              SizedBox(height: 21,),
              Container(
                height: 140,
                child:Image.network(ad.image),
              ),
              SizedBox(height: 21,),
             Custom_Text(text: ad.name,
             fontSize:22,alignment: Alignment.center,
             ),
              SizedBox(height: 21,),
              Custom_Text(text: ad.details,
                fontSize:22,alignment: Alignment.center,
              ),
              const SizedBox(height: 20,),
              (cubit.doc.doctor_image!=null &&
                  cubit.doc.doctor_image!.length>5)?
              SizedBox(
                width: 230,
                child:Image.network
                  (cubit.doc.doctor_image.toString()),
              ):SizedBox(
                height: 100,
                // width: MediaQuery.of(context).size.width * 0.30,
                child:Image.asset('assets/images/doc.png'),
              ),
              const SizedBox(height: 20,),
              Column(
                children: [
                  Custom_Text(
                    text: cubit.doc.doctor_name.toString(),
                    color:ColorsManager.black,
                    fontSize: 20,
                    alignment:Alignment.center,
                  ),
                  const SizedBox(height: 15,),

                  (cubit.doc.cat2=='طبيب')?
                  Custom_Text(
                    alignment:Alignment.center,
                    text: cubit.doc.doctor_cat.toString(),
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
                      Custom_Text(text: cubit.doc.doctor_phone.toString(),alignment:Alignment.center,
                        fontSize:15,
                        color:ColorsManager.black,
                      ),
                      SizedBox(height: 10,),

                      (cubit.doc.cat2=='طبيب')?
                      Column(
                        children: [
                          (cubit.doc.doctor_phone1!=null&&cubit.doc.doctor_phone1!.length>2)?
                          Column(
                            children: [
                              Custom_Text(text: 'رقم  موبيل ',alignment: Alignment.topRight),
                              SizedBox(height: 10,),
                              Custom_Text(text:  cubit.doc.doctor_phone1.toString(),alignment:Alignment.center,
                                fontSize:15,
                                color:ColorsManager.black,
                              ),
                            ],
                          ):SizedBox(),

                          SizedBox(height: 10,),
                          (cubit.doc.doctor_phone2!=null&&cubit.doc.doctor_phone2!.length>3)?
                          Column(
                            children: [
                              Custom_Text(text: 'رقم  واتس ',alignment: Alignment.topRight),

                              SizedBox(height: 10,),
                              Custom_Text(text:  cubit.doc.doctor_phone2.toString(),alignment:Alignment.center,
                                fontSize:15,
                                color:ColorsManager.black,
                              ),
                            ],
                          ):SizedBox(),

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


              // (cubit.doc.address.toString()!='')?

              (cubit.doc.address!=null&& cubit.doc.address!.length>3)?
              Row(
                children: [
                  Icon(Icons.place,color:ColorsManager.primary,),
                  const SizedBox(width: 20,),

                  (cubit.doc.address!='')?
                  Container(
                    width: 170,
                    child: Custom_Text(text: cubit.doc.address.toString(),alignment:Alignment.topRight,
                      fontSize:13,
                      color:ColorsManager.black,
                    ),
                  ):SizedBox(),
                  const SizedBox(width: 10,),
                  Container(
                    child: Column(
                      children: [
                        Custom_Text(text: cubit.doc.time.toString(),alignment:Alignment.topRight,
                          fontSize:15,
                          color:ColorsManager.black,
                        ),
                        SizedBox(height: 10,),
                        Icon(Icons.arrow_circle_down_outlined,color: ColorsManager.primary,size: 37,),
                        SizedBox(height: 10,),
                        Custom_Text(text: cubit.doc.time1x.toString(),alignment:Alignment.topRight,
                          fontSize:15,
                          color:ColorsManager.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ):SizedBox(),
              const SizedBox(height: 15,),
              Custom_Text(text: '- - - - - - - - - - - - - - - - -',fontSize: 21,color:ColorsManager.primary,alignment: Alignment.center,),

              const SizedBox(height: 15,),


              (cubit.doc.delivery=='true')?
              Custom_Text(text: 'متاح خدمة التوصيل   ',
                alignment:Alignment.topRight,
                fontSize:22,
                color:Colors.black,
              ):SizedBox(),


              SizedBox(
                height: 11,
              ),
              (cubit.doc.fullService=='true')?
              Custom_Text(text: ' متاح خدمة ٢٤ ساعة ',alignment:Alignment.topRight,
                fontSize:15,
                color:Colors.grey,
              ):SizedBox(),

              (cubit.doc.lat==null)?
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

                  print(cubit.doc.lat);
                  url(cubit.doc.lat!,cubit.doc.lng!);

                },
              ):SizedBox(height: 1,),


              (cubit.doc.address2.toString()!='')?

              Row(
                children: [

                  Icon(Icons.place,color:ColorsManager.primary,),
                  const SizedBox(width: 20,),
                  Container(
                    width: 170,
                    child: Custom_Text(text: cubit.doc.address2.toString(),alignment:Alignment.topRight,
                      fontSize:15,
                      color:ColorsManager.black,
                    ),
                  ),
                  const SizedBox(width: 50,),
                  Column(
                    children: [
                      Custom_Text(text: cubit.doc.time2.toString(),alignment:Alignment.topRight,
                        fontSize:15,
                        color:ColorsManager.black,
                      ),
                      Icon(Icons.arrow_circle_down_outlined,color: ColorsManager.primary,size: 37,),
                      SizedBox(height: 10,),
                      Custom_Text(text: cubit.doc.time2x.toString(),alignment:Alignment.topRight,
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
              if(cubit.doc.location2!='')
                InkWell(
                  child: Row(
                    children:  [
                      SizedBox(width: 60,),
                      Icon(Icons.maps_ugc_sharp,color:ColorsManager.primary,),
                      SizedBox(width: 20,),
                      (cubit.doc.location2!=null)?
                      Custom_Text(text: cubit.doc.location2.toString() ,alignment:Alignment.center,
                        fontSize:15,
                        color:Colors.grey,
                      ):SizedBox(),
                      SizedBox(width: 10,),
                    ],
                  ),
                  onTap:(){
                    print(cubit.doc);
                    url(cubit.doc.lat!,cubit.doc.lng!);
                  },
                ),

              const SizedBox(height: 15,),
              (cubit.doc.address3.toString()!='')?

              Row(
                children: [
                  Icon(Icons.place,color:ColorsManager.primary,),
                  const SizedBox(width: 20,),
                  Custom_Text(text: cubit.doc.address3.toString(),alignment:Alignment.topRight,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                  const SizedBox(width: 10,),
                  Custom_Text(text: cubit.doc.time2.toString(),alignment:Alignment.topRight,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                ],
              ) :const SizedBox(),

              const SizedBox(height: 15,),
              const SizedBox(height: 25,),

              (cubit.doc.price!=null)?
              Row(
                children: [
                  Icon(Icons.price_change,color:ColorsManager.primary,),
                  const SizedBox(width: 20,),
                  const Custom_Text(text: 'السعر   -  ',alignment:Alignment.topRight,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                  const SizedBox(width: 10,),

                 // (double.parse(listApp[index].price!)/price).toStringAsFixed(1)+" " +currency,

                  Custom_Text
                    (text: cubit.doc.price!+" "+currency,
      alignment:Alignment.topRight,
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




              Custom_Text(text: cubit.doc.doctor_info.toString(),alignment:Alignment.center,
                fontSize:15,
                color:ColorsManager.black,
              ),
              const SizedBox(height: 22,),
              (cubit.doc.image1!='' && cubit.doc.image1!=null)?
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    width: 70,
                    child:Image.network(cubit.doc.image1!,)
                ),
              ):SizedBox(height: 1,),
              const SizedBox(height: 22,),

              (cubit.doc.doctor_degree.toString().length>1)?
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

                      Custom_Text(text: cubit.doc.doctor_degree.toString(),alignment:Alignment.center,
                        fontSize:15,
                        color:ColorsManager.black,
                      ),
                    ],
                  ),

                ],
              ):SizedBox(),



              const SizedBox(height: 20,),
              (cubit.doc.image2!=''&&cubit.doc.image2!=null)?
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    width: 70,
                    //  height: 100,
                    child:Image.network(cubit.doc.image!,
                      fit:BoxFit.fill,
                    )
                ),
              ):SizedBox(height: 1,),
              const SizedBox(height: 20,),



              (cubit.doc.image2.toString()!='')?
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  //   width: 100,
                  height: 140,
                  child: Image.network(cubit.doc.image2.toString(),fit:BoxFit.fill),
                ),
              ):SizedBox(),
              const SizedBox(height: 12,),
              Custom_Text(text: cubit.doc.doctor_degree.toString(),alignment:Alignment.center,
                fontSize:15,
                color:ColorsManager.black,
              ),
              const SizedBox(height: 22,),
              ( cubit.doc.clink_name2!=null)?
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

                  Custom_Text(text: cubit.doc.clink_name2.toString(),alignment:Alignment.center,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                  SizedBox(height: 10,),
                  Custom_Text(text: cubit.doc.address2.toString(),alignment:Alignment.center,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                  SizedBox(height: 10,),
                  Custom_Text(text: 'رقم  ارضي ',alignment: Alignment.topRight),
                  //  SizedBox(height: 6,),
                  Custom_Text(text: cubit.doc.clink_phone4.toString(),alignment:Alignment.center,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                  SizedBox(height: 6,),
                  Custom_Text(text: 'رقم  موبيل ',alignment: Alignment.topRight),
                  //  SizedBox(height: 6,),
                  Custom_Text(text: cubit.doc.clink_phone5.toString(),alignment:Alignment.center,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                  SizedBox(height: 6,),
                  Custom_Text(text: 'رقم  واتس ',alignment: Alignment.topRight),
                  //  SizedBox(height: 6,),
                  Custom_Text(text: cubit.doc.clink_phone6.toString(),alignment:Alignment.center,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                  SizedBox(height: 6,),
                  Custom_Text(text: 'المنصب ',alignment: Alignment.topRight),
                  //   SizedBox(height: 6,),
                  Custom_Text(text: cubit.doc.clink_p2.toString(),alignment:Alignment.center,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                ],
              ):SizedBox(height: 1,),

              ( cubit.doc.clink_name3!=null)?
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

                  Custom_Text(text: cubit.doc.clink_name3.toString(),alignment:Alignment.center,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                  SizedBox(height: 10,),
                  Custom_Text(text:cubit.doc.address3.toString(),alignment:Alignment.center,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                  SizedBox(height: 10,),
                  Custom_Text(text: 'رقم  ارضي ',alignment: Alignment.topRight),
                  //  SizedBox(height: 6,),
                  Custom_Text(text: cubit.doc.clink_phone7.toString(),alignment:Alignment.center,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                  SizedBox(height: 6,),
                  Custom_Text(text: 'رقم  موبيل ',alignment: Alignment.topRight),
                  //  SizedBox(height: 6,),
                  Custom_Text(text: cubit.doc.clink_phone8.toString(),alignment:Alignment.center,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                  SizedBox(height: 6,),
                  Custom_Text(text: 'رقم  واتس ',alignment: Alignment.topRight),
                  //  SizedBox(height: 6,),
                  Custom_Text(text:cubit.doc.clink_phone9.toString(),alignment:Alignment.center,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                  SizedBox(height: 6,),
                  Custom_Text(text: 'المنصب ',alignment: Alignment.topRight),
                  //   SizedBox(height: 6,),
                  Custom_Text(text:cubit.doc.clink_p3.toString(),alignment:Alignment.center,
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
                  print("d="+cubit.doc.days.toString());
                  Get.to( BookingView(
                    doctorId: cubit.doc.doctor_id.toString(),
                    days: cubit.doc.days.toString(),
                    doctorToken: cubit.doc.token.toString(),
                  ));

                },
              )
            ],
          ),
        ),
      ),
    );
    }

        )
    );
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
}

