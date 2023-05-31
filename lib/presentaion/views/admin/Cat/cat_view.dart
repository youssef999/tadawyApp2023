//
// import 'package:doctors_app/presentaion/bloc/admin/admin_cubit.dart';
// import 'package:doctors_app/presentaion/bloc/admin/admin_state.dart';
// import 'package:doctors_app/presentaion/const/app_message.dart';
// import 'package:doctors_app/presentaion/resources/color_manager.dart';
// import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
// import '../../../../domain/models/cat.dart';
// import '../../../widgets/Custom_button.dart';
// import '../admin_view.dart';
// import 'add_new_cat.dart';
//
//
// class CatView extends StatelessWidget {
//
//
//   const  CatView( {super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return BlocProvider(
//         create: (BuildContext context) => AdminCubit()..getAllCat(),
//         child: BlocConsumer<AdminCubit, AdminStates>(
//
//             listener: (context, state) {
//               if(state is DeleteCatSuccessState){
//                 appMessage(text: 'تم الحذف بنجاح');
//                 Get.offAll(AdminView());
//               }
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
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       CustomButton(text: 'اضافة', onPressed: (){
//
//                         Get.to(AddNewCat());
//                       }, color1: ColorsManager.primary, color2:Colors.white),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       AllAdsWidget(cubit.catList,cubit),
//                     ],
//                   ),
//                 ),
//               );
//
//             }));
//   }
// }
//
// Widget AllAdsWidget(List<Cat> listApp, AdminCubit cubit) {
//
//
//   if(listApp.isNotEmpty){
//     return SingleChildScrollView(
//       child: Container(
//         height:9130,
//         color: Colors.grey[200],
//         //width:double.infinity,
//         padding: const EdgeInsets.only(top: 9, left: 7, right: 7),
//         child:     ListView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: listApp.length,
//             itemBuilder: (context, index) {
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
//                                       text: listApp[index].cat2.toString(),
//                                       color: ColorsManager.primary,
//                                       fontSize: 16,
//                                       alignment: Alignment.center,
//                                     ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//
//
//                                     SizedBox(height: 12,),
//
//
//                                     SizedBox(height: 12,),
//                                     CustomButton(text: 'حذف', onPressed: (){
//
//                                       cubit.deleteCat(listApp[index].id.toString());
//
//                                     }, color1: ColorsManager.primary, color2: Colors.white),
//                                   ],
//                                 ),
//                               ),
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
//                     //Get.to(AdminAdDetailsView(ad:listApp[index],));
//                     //  Get.to(DoctorDetailsView(listApp[index]));
//                   },
//                 ),
//               );
//             }),
//         // Container(
//         //   height: 1000,
//         //   child: Column(
//         //     children: [
//         //
//         //       SizedBox(height: 10,),
//         //       CustomButton(text: 'اضافة', onPressed: (){
//         //
//         //       }, color1:ColorsManager.primary, color2: Colors.white)
//         //     ],
//         //   ),
//         // ),
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
