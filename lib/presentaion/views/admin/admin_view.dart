//
//
//
//  import 'package:doctors_app/presentaion/views/admin/Booking/booking_view.dart';
// import 'package:doctors_app/presentaion/views/admin/Country_admin/countries_view.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../resources/color_manager.dart';
// import '../../widgets/Custom_button.dart';
// import 'Ads/all_ads_view.dart';
// import 'BAKA/baka_view.dart';
// import 'Cat/cat_view.dart';
// import 'doctors/doctors_view.dart';
//
// class AdminView extends StatelessWidget {
//   const AdminView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:AppBar(
//         toolbarHeight: 6,
//         elevation: 0,
//         backgroundColor:ColorsManager.primary,
//       ),
//       body:SingleChildScrollView(
//         child:Center(
//           child: Column(
//             children: [
//               SizedBox(height: 10,),
//               Container(
//                 height:240,
//                 child:Image.asset('assets/images/admin.png',fit:BoxFit.fill,),),
//               SizedBox(height: 20,),
//               CustomButton(
//                 text: 'الاطباء و المراكز الطبية ',
//                 color1:ColorsManager.primary,
//                 color2:Colors.white,
//                 onPressed:(){
//
//                   Get.to(DoctorsView());
//
//                   },
//               ),
//               SizedBox(height: 20,),
//               CustomButton(
//                 text: 'الاعلانات ',
//                 color1:ColorsManager.primary,
//                 color2:Colors.white,
//                 onPressed:(){
//
//                   Get.to(AllAdsView());
//
//                 },
//               ),
//               SizedBox(height: 20,),
//               CustomButton(
//                 text:  ' الاشتراكات  ',
//                 color1:ColorsManager.primary,
//                 color2:Colors.white,
//                 onPressed:(){
//
//                   Get.to( AllBookingView());
//
//                 },
//               ),
//               SizedBox(height: 20,),
//               CustomButton(
//                 text:  'الباقات   ',
//                 color1:ColorsManager.primary,
//                 color2:Colors.white,
//                 onPressed:(){
//
//                   Get.to(  AllBakaView());
//
//                 },
//               ),
//               SizedBox(height: 20,),
//               CustomButton(
//                 text:  ' الاصناف    ',
//                 color1:ColorsManager.primary,
//                 color2:Colors.white,
//                 onPressed:(){
//
//                   Get.to( CatView());
//
//                 },
//               ),
//               SizedBox(height: 20,),
//               CustomButton(
//                 text:  ' البلاد    ',
//                 color1:ColorsManager.primary,
//                 color2:Colors.white,
//                 onPressed:(){
//
//                   Get.to( AdminCountryView());
//
//                 },
//               ),
//               const SizedBox(height: 20,),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
