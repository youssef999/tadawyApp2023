


 import 'dart:io';

import 'package:doctors_app/domain/models/booking.dart';
import 'package:doctors_app/presentaion/bloc/booking/booking_cubit.dart';
import 'package:doctors_app/presentaion/bloc/booking/booking_states.dart';
import 'package:doctors_app/presentaion/const/app_message.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class UserBookingView extends StatelessWidget {
  const UserBookingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (BuildContext context) => BookingCubit()..getUserBooking(),
        child: BlocConsumer<BookingCubit, BookingStates>(
            listener: (context, state) {

            },
            builder: (context, state) {
              BookingCubit cubit =BookingCubit.get(context);
              return Scaffold(
                backgroundColor: ColorsManager.primaryx,
                appBar: AppBar(
                  toolbarHeight: 6,
                  elevation: 0,
                  backgroundColor: ColorsManager.primary,
                ),
                body: Container(
                  color:Colors.white,
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:30.0,right:30),
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius:BorderRadius.circular(20),
                            color:ColorsManager.primary
                          ),
                          padding: const EdgeInsets.all(12),
                          child: const Custom_Text(
                            text: ' الحجوزات   ',
                            alignment: Alignment.center,
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BookingWidget(cubit.bookingList,cubit),
                    ],
                  ),
                ),
              );
            }));
  }
}




Widget BookingWidget(List<Booking> listApp,BookingCubit cubit) {


   print("LIST");
   print(listApp);

   if(listApp.isNotEmpty){
     return SingleChildScrollView(
       child: Container(
         height: 121000,
         color: Colors.white,
         //width:double.infinity,
         padding: const EdgeInsets.only(top: 9, left: 7, right: 7),
         child: ListView.builder(
             physics: const NeverScrollableScrollPhysics(),
             itemCount: listApp.length,
             itemBuilder: (context, index) {
               return Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Card(
                   color:ColorsManager.primary,
                   child: InkWell(
                     child: Container(
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(15),
                           color: Colors.white70
                       ),
                       child: Directionality(
                         textDirection: TextDirection.rtl,
                         child: Column(
                           children: [
                             const SizedBox(
                               height: 12,
                             ),
                             Row(
                               children: [

                                 (listApp[index].doctor_image!.length>5)?
                                 SizedBox(
                                     height: 80,
                                     width: MediaQuery.of(context).size.width * 0.23,
                                     child: Image.network(
                                         listApp[index].doctor_image.toString())):
                                 SizedBox(
                                     height: 80,
                                     width: MediaQuery.of(context).size.width * 0.23,
                                     child: Image.asset(
                                         'assets/images/doc4.png')),

                                 const SizedBox(
                                   width: 30,
                                 ),

                                 SizedBox(
                                   width: MediaQuery.of(context).size.width * 0.32,
                                   child: Column(
                                     children: [
                                       Custom_Text(
                                         text: listApp[index].doctor_name.toString(),
                                         color: ColorsManager.black,
                                         fontSize: 16,
                                         alignment: Alignment.center,
                                       ),
                                       const SizedBox(
                                         height: 10,
                                       ),
                                       Custom_Text(
                                         text: listApp[index].doctor_cat.toString(),
                                         color: ColorsManager.primary,
                                         fontSize: 16,
                                         alignment: Alignment.center,
                                       ),
                                       const SizedBox(
                                         height: 10,
                                       ),
                                       Row(
                                         children: [
                                           const SizedBox(
                                             width: 10,
                                           ),
                                           Custom_Text(
                                             text: listApp[index].date.toString(),
                                             color: Colors.grey,
                                             fontSize: 12,
                                             alignment: Alignment.center,
                                           ),
                                           const SizedBox(
                                             width: 6,
                                           ),
                                           Custom_Text(
                                             text: listApp[index].day.toString(),
                                             color: ColorsManager.primary,
                                             fontSize: 12,
                                             alignment: Alignment.center,
                                           ),
                                         ],
                                       ),


                                       const SizedBox(
                                         height: 10,
                                       ),
                                       Custom_Text(
                                         text: listApp[index].time.toString(),
                                         color: ColorsManager.primary,
                                         fontSize: 15,
                                         alignment: Alignment.center,
                                       ),
                                       const SizedBox(
                                         height: 10,
                                       ),
                                       Row(
                                         children: [
                                           Custom_Text(
                                             text: 'سعر الكشف '.toString(),
                                             color: Colors.grey,
                                             fontSize: 14,
                                             alignment: Alignment.center,
                                           ),
                                           const SizedBox(
                                             width: 12,
                                           ),
                                           Custom_Text(
                                             text: listApp[index].price.toString(),
                                             color: ColorsManager.primary,
                                             fontSize: 16,
                                             alignment: Alignment.center,
                                           ),
                                           const SizedBox(height:10,),
                                         ],
                                       ),
                                       SizedBox(height: 10,),
                                       (listApp[index].status!='')?
                                       Column(
                                         children: [
                                           Custom_Text(
                                             text: 'حالة الحجز ',
                                             color: Colors.black,
                                             fontSize: 21,
                                             alignment: Alignment.center,
                                           ),
                                           SizedBox(height: 10,),
                                           Custom_Text(
                                             text: listApp[index].status.toString(),
                                             color: Colors.red,
                                             fontSize: 21,
                                             alignment: Alignment.center,
                                           ),
                                         ],
                                       ):
                                       SizedBox(height: 1,),
                                       SizedBox(height: 11,)
                                     ],
                                   ),
                                 ),
                                 SizedBox(
                                     width: MediaQuery.of(context).size.width * 0.08),

                                 InkWell(
                                   child:  SizedBox(
                                     height: 40,
                                     child:Image.asset('assets/images/wh3.png')
                                   ),
                                   onTap:(){
                                     print(listApp[index].doctor_phone.toString());
                                     sendWhatsApp(listApp[index].doctor_phone.toString(),'');

                                   },
                                 )

                               ],
                             ),

                             const SizedBox(
                               height: 12,
                             ),

                           ],
                         ),
                       ),
                     ),
                     onTap: () {

                     },
                   ),
                 ),
               );
             }),
       ),
     );

   }
   else{

     return Container(
       color: Colors.white,
       child: Column(
         children: [
           const SizedBox(height: 30,),
           SizedBox(
             height:290,
             child:Image.asset("assets/images/data.png"),
           ),
           const SizedBox(height: 11,),
           const Custom_Text(
             text: ' لم تقم باي حجز حتي الان  ',
             fontSize: 22,
             color:Colors.black,
             alignment:Alignment.center,
           ),
           const SizedBox(height: 170,),
         ],
       ),
     );

   }

 }
//  String url(String phone) {
//
//    if (Platform.isAndroid) {
//      // add the [https]
//      return "https://wa.me/$phone/?text=${Uri.parse('')}"; // new line
//    } else {
//      // add the [https]
//      return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse('')}"; // new line
//    }
// }

 sendWhatsApp(String phone,String msg)async{

   String url(){
     if(Platform.isAndroid){
       return 'whatsapp://send?phone=$phone&text=$msg';
       //  return 'whatsapp://wa.me/$phone/?text=${Uri.parse(msg)}';
     }
     else{
       return 'whatsapp://send?phone=$phone&text=$msg';
       //  return 'whatsapp://send?$phone=phone&text=$msg';
       //   return 'whatsapp://wa.me/$phone&text=$msg';
     }
   }
   await canLaunch(url())?launch(url()) :launch(url());
   //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('there is no whats app in your device')));
 }