//
//
//
//
// import 'package:doctors_app/domain/models/user.dart';
// import 'package:doctors_app/presentaion/bloc/admin/admin_cubit.dart';
// import 'package:doctors_app/presentaion/bloc/admin/admin_state.dart';
// import 'package:doctors_app/presentaion/resources/color_manager.dart';
// import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
// import '../../../../domain/models/ads.dart';
// import '../../../widgets/Custom_button.dart';
// import '../../User/Ads/ads_details_view.dart';
// import '../../User/doctors/doctor-details_view.dart';
// import 'ads_details_view.dart';
//
//
// class AllAdsView extends StatelessWidget {
//
//
//   const  AllAdsView( {super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return BlocProvider(
//         create: (BuildContext context) => AdminCubit()..getAllAds(),
//         child: BlocConsumer<AdminCubit, AdminStates>(
//
//             listener: (context, state) {
//
//             },
//
//             builder: (context, state) {
//
//               AdminCubit cubit = AdminCubit.get(context);
//
//               return Scaffold(
//                 appBar: AppBar(
//                   toolbarHeight: 6,
//                   elevation: 0,
//                   backgroundColor: ColorsManager.primary,
//                 ),
//                 body: Container(
//                   color: Colors.grey[200],
//                   child: ListView(
//                     children: [
//
//
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       AllAdsWidget(cubit.adsList,cubit),
//                     ],
//                   ),
//                 ),
//               );
//
//             }));
//   }
// }
//
// Widget AllAdsWidget(List<Ads> listApp, AdminCubit cubit) {
//
//
//   List<DoctorModel>list=[];
//   if(listApp.isNotEmpty){
//     return SingleChildScrollView(
//       child: Container(
//         height:9130,
//         color: Colors.grey[200],
//         //width:double.infinity,
//         padding: const EdgeInsets.only(top: 9, left: 7, right: 7),
//         child:
//         ListView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: listApp.length,
//             itemBuilder: (context, index) {
//
//              // list.add(listApp[index]);
//
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: InkWell(
//                   child: Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                         color: Colors.white),
//                     child: Directionality(
//                       textDirection: TextDirection.rtl,
//                       child: Column(
//                         children: [
//                           const SizedBox(
//                             height: 12,
//                           ),
//                           Row(
//                             children: [
//                               SizedBox(
//                                   height: 90,
//                                   width: MediaQuery.of(context).size.width * 0.35,
//                                   child: Image.network(
//                                       listApp[index].image.toString())),
//
//                               const SizedBox(
//                                 width: 23,
//                               ),
//
//                               SizedBox(
//                                 // width: MediaQuery.of(context).size.width * 0.3,
//                                 child: Column(
//                                   children: [
//                                     Custom_Text(
//                                       text: listApp[index].name.toString(),
//                                       color: ColorsManager.black,
//                                       fontSize: 16,
//                                       alignment: Alignment.center,
//                                     ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     Custom_Text(
//                                       text: listApp[index].country.toString(),
//                                       color: ColorsManager.primary,
//                                       fontSize: 16,
//                                       alignment: Alignment.center,
//                                     ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     Custom_Text(
//                                       text:'تاريخ انتهاء الاعلان',
//                                       color: Colors.grey,
//                                       fontSize: 13,
//                                       alignment: Alignment.center,
//                                     ),
//                                     const SizedBox(
//                                       height: 4,
//                                     ),
//                                     Custom_Text(
//                                       text: listApp[index].date_end.toString().replaceAll('00:00:00.000', ''),
//                                       color: Colors.grey,
//                                       fontSize: 13,
//                                       alignment: Alignment.center,
//                                     ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//
//                                     Row(
//                                       children: [
//                                         const SizedBox(
//                                           width: 21,
//                                         ),
//                                         Custom_Text(
//                                           text: 'سعر الكشف '.toString(),
//                                           color: Colors.grey,
//                                           fontSize: 14,
//                                           alignment: Alignment.center,
//                                         ),
//                                         const SizedBox(
//                                           width: 12,
//                                         ),
//                                         Custom_Text(
//                                           text: listApp[index].price.toString(),
//                                           color: ColorsManager.primary,
//                                           fontSize: 16,
//                                           alignment: Alignment.center,
//                                         ),
//                                       ],
//                                     ),
//
//                                   ],
//                                 ),
//                               ),
//
//
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 12,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   onTap: () {
//
//                     Get.to(AdminAdDetailsView(ad:listApp[index],));
//                   //  Get.to(DoctorDetailsView(listApp[index]));
//                   },
//                 ),
//               );
//             }),
//       ),
//     );
//   }
//
//   else{
//     return     Container(
//       color:Colors.white,
//       child:
//
//       Center(
//         child:
//
//         Column(
//           mainAxisAlignment:MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//
//             SizedBox(
//               height:260,
//               child:Image.asset("assets/images/data.png"),
//             ),
//             const SizedBox(height: 11,),
//             const Custom_Text(
//               text: 'القسم لا يحتوي علي بيانات الان ',
//               fontSize: 22,
//               color:Colors.black,
//               alignment:Alignment.center,
//             ),
//             const SizedBox(height: 400,),
//
//           ],
//         ),
//       ),
//     );
//   }
//
// }
