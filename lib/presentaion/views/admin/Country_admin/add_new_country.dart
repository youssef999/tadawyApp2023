//
//
//
//
//
// import 'dart:io';
// import 'package:doctors_app/presentaion/bloc/admin/admin_cubit.dart';
// import 'package:doctors_app/presentaion/bloc/admin/admin_state.dart';
// import 'package:doctors_app/presentaion/resources/color_manager.dart';
// import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
// import 'package:doctors_app/presentaion/widgets/custom_textformfield.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
// import '../../../const/app_message.dart';
// import '../../../widgets/Custom_button.dart';
// import '../admin_view.dart';
//
//
//  class AddNewCountry extends StatelessWidget {
//   const AddNewCountry({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (BuildContext context) => AdminCubit()..getAllCat(),
//         child: BlocConsumer<AdminCubit, AdminStates>(
//
//             listener: (context, state) {
//               if(state is AddCountrySuccessState){
//                 appMessage(text: 'تم الاضافة بنجاح');
//                 Get.offAll(AdminView());
//               }
//             },
//
//             builder: (context, state) {
//
//               AdminCubit cubit = AdminCubit.get(context);
//               return Scaffold(
//                 appBar:AppBar(
//                   elevation: 0,
//                   toolbarHeight: 5,
//                   backgroundColor:ColorsManager.primary,
//                 ),
//                 body:
//                 Column(
//                   children:  [
//                     const SizedBox(height: 20,),
//                     Image.asset('assets/images/logo2.png'),
//                     const SizedBox(height: 50,),
//
//                     Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: CustomTextFormField(
//                         controller:cubit.nameController,
//                         color:Colors.black,
//                         hint: "الاسم ",
//                         max: 2,
//                         obs: false,
//                         obx: false,
//                         ontap:(){},
//                         type:TextInputType.text,
//                       ),
//                     ),
//
//                     const SizedBox(height: 20,),
//                     CustomButton(text: "اضافة",
//                         onPressed: (){
//
//                           cubit.addNewCountry();
//
//                         }, color1:ColorsManager.primary,
//                         color2: Colors.white),
//                     const SizedBox(height: 30,),
//                   ],
//                 ),
//               );
//             }));
//   }
// }