//
// import 'dart:convert';
//
// import 'package:doctors_app/Data/api_connection/api_connection.dart';
// import 'package:http/http.dart' as http;
// import 'package:doctors_app/domain/models/ap.dart';
// import 'package:doctors_app/domain/models/fav.dart';
// import 'package:doctors_app/domain/models/user.dart';
// import 'package:doctors_app/presentaion/bloc/User/patient_cubit.dart';
// import 'package:doctors_app/presentaion/bloc/User/patient_states.dart';
// import 'package:doctors_app/presentaion/resources/color_manager.dart';
// import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
// import 'package:doctors_app/presentaion/widgets/appointments/appountments.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
// import 'doctor-details_view.dart';
//
// class FavView extends StatefulWidget {
//   @override
//   State<FavView> createState() => _FavViewState();
// }
//
// class _FavViewState extends State<FavView> {
//   @override
//   Widget build(BuildContext context) {
//
//     return BlocProvider(
//         create: (BuildContext context) => PatientCubit()..getUserFav(),
//         child: BlocConsumer<PatientCubit, PatientStates>(
//             listener: (context, state) {},
//             builder: (context, state) {
//               PatientCubit cubit = PatientCubit.get(context);
//
//               return Scaffold(
//                 appBar: AppBar(
//                   toolbarHeight: 6,
//                   backgroundColor: ColorsManager.primary,
//                 ),
//                 body: ListView(
//                   children: [
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     const Custom_Text(
//                       text: ' المفضلة   ',
//                       alignment: Alignment.center,
//                       color: Colors.black,
//                       fontSize: 25,
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     AllDoctorsWidget(cubit.favList,cubit),
//                   ],
//                 ),
//               );
//             }));
//   }
// }
//
// Widget AllDoctorsWidget(List<Favorite> listApp,PatientCubit cubit) {
//
//   print("LIST");
//   print(listApp);
//
//   return SingleChildScrollView(
//     child: Container(
//       height: 1230,
//       color: Colors.grey[100],
//       //width:double.infinity,
//       padding: const EdgeInsets.only(top: 9, left: 7, right: 7),
//       child: ListView.builder(
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: listApp.length,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: InkWell(
//                 child: Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       color: Colors.white70),
//                   child: Directionality(
//                     textDirection: TextDirection.rtl,
//                     child: Column(
//                       children: [
//                         const SizedBox(
//                           height: 12,
//                         ),
//                         Row(
//                           children: [
//                             SizedBox(
//                                 height: 80,
//                                 width: MediaQuery.of(context).size.width * 0.3,
//                                 child: Image.network(
//                                     listApp[index].doctor_image.toString())),
//
//                             const SizedBox(
//                               width: 30,
//                             ),
//
//                             SizedBox(
//                               width: MediaQuery.of(context).size.width * 0.3,
//                               child: Column(
//                                 children: [
//                                   Custom_Text(
//                                     text: listApp[index].doctor_name.toString(),
//                                     color: ColorsManager.black,
//                                     fontSize: 16,
//                                     alignment: Alignment.center,
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   Custom_Text(
//                                     text: listApp[index].doctor_cat.toString(),
//                                     color: ColorsManager.primary,
//                                     fontSize: 16,
//                                     alignment: Alignment.center,
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   Row(
//                                     children: [
//                                       Custom_Text(
//                                         text: 'سعر الكشف '.toString(),
//                                         color: Colors.grey,
//                                         fontSize: 14,
//                                         alignment: Alignment.center,
//                                       ),
//                                       SizedBox(
//                                         width: 12,
//                                       ),
//                                       Custom_Text(
//                                         text: listApp[index].price.toString(),
//                                         color: ColorsManager.primary,
//                                         fontSize: 16,
//                                         alignment: Alignment.center,
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//
//                             SizedBox(
//                                 width: MediaQuery.of(context).size.width * 0.1),
//                             Positioned(
//                               top: MediaQuery.of(context).padding.top,
//                               left: 0,
//                               right: 0,
//                               child: Row(
//                                 children: [
//                                   IconButton(onPressed: (){
//                                     if(cubit.fav){
//                                       //
//                                     //  cubit.deleteFromFavList(listApp[index]);
//
//                                     }
//                                     else{
//                                      // cubit.addToFavList(listApp[index]);
//                                     }
//
//                                   }, icon:
//
//                                   Icon(
//                                     cubit.fav?Icons.bookmark:Icons.bookmark_border_outlined,
//                                     color:ColorsManager.purple2,
//                                   ))
//                                 ],
//                               ),
//                               //
//                             )
//                             //Image.asset('assets/images/vec1.png')
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 12,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 onTap: () {
//                  // Get.to(DoctorDetailsView(listApp[index]));
//                 },
//               ),
//             );
//           }),
//     ),
//   );
// }
//
