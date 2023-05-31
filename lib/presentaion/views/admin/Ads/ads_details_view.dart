//
//
//
// import 'dart:io';
// import 'package:doctors_app/domain/models/ads.dart';
// import 'package:doctors_app/presentaion/const/app_message.dart';
// import 'package:doctors_app/presentaion/resources/color_manager.dart';
// import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
// import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../../bloc/admin/admin_cubit.dart';
// import '../../../bloc/admin/admin_state.dart';
// import '../admin_view.dart';
//
//
//
// class AdminAdDetailsView extends StatelessWidget {
//
//   Ads ad;
//
//   AdminAdDetailsView({required this.ad});
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return BlocProvider(
//         create: (BuildContext context) => AdminCubit(),
//         child: BlocConsumer<AdminCubit, AdminStates>(
//
//         listener: (context, state) {
//
//           if(state is AddCatSuccessState){
//             appMessage(text: 'تمت الاضافة لافضل الاعلانات بنجاح');
//             Get.offAll(AdminView());
//           }
//     },
//
//     builder: (context, state) {
//
//     AdminCubit cubit = AdminCubit.get(context);
//     return Scaffold(
//       appBar:AppBar(
//         toolbarHeight: 1,
//         elevation: 0,
//         backgroundColor:ColorsManager.primary,
//       ),
//       body:Container(
//         color:Colors.white,
//         padding: const EdgeInsets.all(20.0),
//         child: ListView(
//           children:[
//
//             Container(
//               decoration:  BoxDecoration(
//                   borderRadius:BorderRadius.all(Radius.circular(30)),
//                   color:ColorsManager.primary
//               ),
//               child:Column(
//                 children: [
//                   const SizedBox(height: 20,),
//                   Custom_Text(
//                     text: ad.name.toString(),
//                     fontSize:25,
//                     color:Colors.white,
//                     alignment:Alignment.center,
//                   ),
//
//                   const SizedBox(height: 10,),
//                   Container(
//                     height: 320,
//                     decoration:BoxDecoration(
//                         borderRadius:BorderRadius.circular(30),
//                         color:ColorsManager.primary
//                     ),
//                     width: MediaQuery.of(context).size.width*0.8,
//                     child:Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Image.network(ad.image.toString(),fit:BoxFit.cover,),
//                     ),
//                   ),
//                   const SizedBox(height: 10,),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Custom_Text(
//                       text: ad.details.toString(),
//                       fontSize:16,
//                       color:Colors.white,
//                       alignment:Alignment.center,
//                     ),
//                   ),
//                   const SizedBox(height: 20,),
//                 ],
//               ),
//             ),
//
//
//             const SizedBox(height: 5,),
//             Container(
//               height: 1000,
//               padding: const EdgeInsets.all(20.0),
//               child: ListView(
//                 physics:const NeverScrollableScrollPhysics(),
//                 children: [
//                   const SizedBox(height: 20,),
//                   Row(
//                     children: [
//                       Custom_Text(
//                         text: ad.doctor_name.toString(),
//                         color:ColorsManager.black,
//                         fontSize: 20,
//                         alignment:Alignment.topRight,
//                       ),
//                       SizedBox(width: MediaQuery.of(context).size.width*0.49,),
//                       Custom_Text(
//                         alignment:Alignment.topRight,
//                         text: ad.doctor_cat.toString(),
//                         color:ColorsManager.primary,
//                         fontSize: 20,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20,),
//                   Container(
//                     decoration:BoxDecoration(
//                         borderRadius:BorderRadius.circular(22),
//                         color:ColorsManager.primary
//                     ),
//                     height: 200,
//                     child:Image.network(ad.doctor_image.toString()),
//                   ),
//                   const SizedBox(height: 30,),
//
//
//
//                   Row(
//                     children: [
//
//                      Icon(Icons.phone,color:ColorsManager.primary,),
//                       const SizedBox(width: 20,),
//                       Custom_Text(text:ad.doctor_phone.toString(),alignment:Alignment.topRight,
//                         fontSize:15,
//                         color:ColorsManager.black,
//                       ),
//
//                     ],
//                   ),
//                   const SizedBox(height: 15,),
//
//
//                   (ad.address.toString()!='')?
//
//                   Row(
//                     children: [
//
//                        Icon(Icons.place,color:ColorsManager.primary,),
//                       const SizedBox(width: 20,),
//                       Custom_Text(text: ad.address.toString(),alignment:Alignment.topRight,
//                         fontSize:15,
//                         color:ColorsManager.black,
//                       ),
//                       const SizedBox(width: 10,),
//                       Custom_Text(text: ad.time.toString(),alignment:Alignment.topRight,
//                         fontSize:15,
//                         color:ColorsManager.black,
//                       ),
//
//                     ],
//                   ) :const SizedBox(),
//                   const SizedBox(height: 15,),
//                   InkWell(
//                     child: Row(
//                       children:  [
//                         SizedBox(width: 60,),
//                         Icon(Icons.maps_ugc_sharp,color:ColorsManager.primary,),
//                         SizedBox(width: 20,),
//                         Custom_Text(text: 'موقع الطبيب  علي الخريطة    -  ',alignment:Alignment.center,
//                           fontSize:15,
//                           color:Colors.grey,
//                         ),
//                         SizedBox(width: 10,),
//
//                       ],
//                     ),
//                     onTap:(){
//
//                       url(ad.location.toString());
//                     },
//                   ),
//
//
//                   const SizedBox(height: 10,),
//                   (ad.address2.toString()!='')?
//
//                   Row(
//                     children: [
//
//                        Icon(Icons.place,color:ColorsManager.primary,),
//                       const SizedBox(width: 20,),
//                       Custom_Text(text: ad.address2.toString(),alignment:Alignment.topRight,
//                         fontSize:15,
//                         color:ColorsManager.black,
//                       ),
//                       const SizedBox(width: 10,),
//                       Custom_Text(text: ad.time2.toString(),alignment:Alignment.topRight,
//                         fontSize:15,
//                         color:ColorsManager.black,
//                       ),
//
//                     ],
//                   ) :const SizedBox(),
//
//
//                   const SizedBox(height: 15,),
//                   if(ad.location2!='')
//                     InkWell(
//                       child: Row(
//                         children:  [
//                           SizedBox(width: 60,),
//                           Icon(Icons.maps_ugc_sharp,color:ColorsManager.primary,),
//                           SizedBox(width: 20,),
//                           Custom_Text(text: 'موقع الطبيب  علي الخريطة    -  ',alignment:Alignment.center,
//                             fontSize:15,
//                             color:Colors.grey,
//                           ),
//                           SizedBox(width: 10,),
//
//                         ],
//                       ),
//                       onTap:(){
//                         url(ad.location2.toString());
//                       },
//                     ),
//
//
//                   const SizedBox(height: 15,),
//                   (ad.address3.toString()!='')?
//
//                   Row(
//                     children: [
//
//                     Icon(Icons.place,color:ColorsManager.primary,),
//                       const SizedBox(width: 20,),
//                       Custom_Text(text: ad.address3.toString(),alignment:Alignment.topRight,
//                         fontSize:15,
//                         color:ColorsManager.black,
//                       ),
//                       const SizedBox(width: 10,),
//                       Custom_Text(text:ad.time2.toString(),alignment:Alignment.topRight,
//                         fontSize:15,
//                         color:ColorsManager.black,
//                       ),
//                     ],
//                   ) :const SizedBox(),
//
//                   const SizedBox(height: 15,),
//                   if(ad.location3!='')
//                     InkWell(
//                       child: Row(
//                         children:  [
//                           SizedBox(width: 60,),
//                           Icon(Icons.maps_ugc_sharp,color:ColorsManager.primary,),
//                           SizedBox(width: 20,),
//                           Custom_Text(text: 'موقع الطبيب  علي الخريطة    -  ',alignment:Alignment.center,
//                             fontSize:15,
//                             color:Colors.grey,
//                           ),
//                           SizedBox(width: 10,),
//
//                         ],
//                       ),
//                       onTap:(){
//                         url(ad.location3.toString());
//                       },
//                     ),
//
//                   const SizedBox(height: 25,),
//                   Row(
//                     children: [
//
//                     Icon(Icons.price_change,color:ColorsManager.primary,),
//                       const SizedBox(width: 20,),
//                       const Custom_Text(text: 'السعر   -  ',alignment:Alignment.topRight,
//                         fontSize:15,
//                         color:ColorsManager.black,
//                       ),
//                       const SizedBox(width: 10,),
//                       Custom_Text(text: ad.price.toString(),alignment:Alignment.topRight,
//                         fontSize:15,
//                         color:ColorsManager.black,
//                       ),
//
//                     ],
//                   ),
//                   const SizedBox(height: 25,),
//
//
//
//                   const Padding(
//                     padding: EdgeInsets.only(left:36.0,right:36.0),
//                     child: Divider(
//                       height:6,
//                       color:Colors.black,
//                     ),
//                   ),
//                   const SizedBox(height: 15,),
//                   Row(
//                     children: [
//
//                       Container(
//                         child: Image.asset('assets/images/profile.png'),
//                       ),
//                       const SizedBox(width: 20,),
//                       const Custom_Text(text: ' معلوماتي  ',alignment:Alignment.topRight,
//                         fontSize:24,
//                         color:ColorsManager.black,
//                       ),
//                       const SizedBox(width: 10,),
//
//
//                     ],
//                   ),
//                   const SizedBox(height: 15,),
//
//                   Custom_Text(text: ad.doctor_info.toString(),alignment:Alignment.center,
//                     fontSize:15,
//                     color:ColorsManager.black,
//                   ),
//                   const SizedBox(height: 22,),
//                   Row(
//                     children: [
//
//                       Container(
//                         child: Image.asset('assets/images/grade.png'),
//                       ),
//                       const SizedBox(width: 20,),
//                       const Custom_Text(text: ' الدرجة العلمية ',alignment:Alignment.topRight,
//                         fontSize:24,
//                         color:ColorsManager.black,
//                       ),
//                       const SizedBox(width: 10,),
//
//
//                     ],
//                   ),
//
//                   const SizedBox(height: 12,),
//                   Custom_Text(text: ad.doctor_degree.toString(),alignment:Alignment.center,
//                     fontSize:15,
//                     color:ColorsManager.black,
//                   ),
//
//                   const SizedBox(height: 20,),
//
//                   CustomButton(
//                     text: " حذف ",
//                     color1:ColorsManager.primary,
//                     color2:Colors.white,
//                     onPressed:(){
//
//                       cubit.deleteAd(ad.id.toString());
//
//                     },
//                   ),
//
//
//                   const SizedBox(height: 20,),
//
//                   (ad.best=='true')?Custom_Text(text: 'من افضل الاعلانات',fontSize: 21,alignment:Alignment.center,):
//                   CustomButton(text: 'اضافة لافضل الاعلانات', onPressed:(){
//                     cubit.addToBestAds(ad.id.toString());
//                   }, color1:ColorsManager.primary, color2: Colors.white)
//                 ],
//               ),
//             ),
//
//
//           ],
//         ),
//       ),
//     );
//     }));
//   }
// }
//    url(String url)async{
//
//   String url(){
//     if(Platform.isAndroid){
//       return url.toString();
//       //  return 'whatsapp://wa.me/$phone/?text=${Uri.parse(msg)}';
//     }
//     else{
//       return url.toString();
//       //  return 'whatsapp://send?$phone=phone&text=$msg';
//       //   return 'whatsapp://wa.me/$phone&text=$msg';
//     }
//   }
//
//   await canLaunch(url())?launch(url()) :launch(url());
//   // appMessage(text: 'هناك خطا');
//   //await canLaunch(url())?launch(url());
//
//   //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('there is no whats app in your device')));
// }