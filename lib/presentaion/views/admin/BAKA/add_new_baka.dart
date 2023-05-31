//
//
// import 'package:doctors_app/presentaion/bloc/admin/admin_cubit.dart';
// import 'package:doctors_app/presentaion/bloc/admin/admin_state.dart';
// import 'package:doctors_app/presentaion/resources/color_manager.dart';
// import 'package:doctors_app/presentaion/widgets/custom_textformfield.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
// import '../../../const/app_message.dart';
// import '../../../widgets/Custom_button.dart';
// import '../admin_view.dart';
//
// class AddNewBaka extends StatelessWidget {
//   const AddNewBaka({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (BuildContext context) => AdminCubit()..getAllCat(),
//         child: BlocConsumer<AdminCubit, AdminStates>(
//
//             listener: (context, state) {
//               if(state is AddBakaSuccessState){
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
//                 SingleChildScrollView(
//                   child:
//                   Padding(
//                     padding: const EdgeInsets.all(14.0),
//                     child: Column(
//                       children:  [
//                         const SizedBox(height: 20,),
//                         Image.asset('assets/images/logo2.png'),
//                         const SizedBox(height: 20,),
//                         CustomTextFormField(
//                           controller:cubit.nameController,
//                           color:Colors.black,
//                           hint: "الاسم ",
//                           max: 2,
//                           obs: false,
//                           obx: false,
//                           ontap:(){},
//                           type:TextInputType.text,
//                         ),
//                         const SizedBox(height: 10,),
//                         CustomTextFormField(
//                           controller:cubit.detailsController,
//                           color:Colors.black,
//                           hint: "تفاصيل",
//                           max:4,
//                           obs: false,
//                           obx: false,
//                           ontap:(){},
//                           type:TextInputType.text,
//                         ),
//
//                         const SizedBox(height: 10,),
//                         CustomTextFormField(
//                           controller:cubit.desController,
//                           color:Colors.black,
//                           hint: "وصف",
//                           max: 4,
//                           obs: false,
//                           obx: false,
//                           ontap:(){},
//                           type:TextInputType.text,
//                         ),
//                         const SizedBox(height: 10,),
//                         CustomTextFormField(
//                           controller:cubit.price,
//                           color:Colors.black,
//                           hint: "السعر",
//                           max: 2,
//                           obs: false,
//                           obx: false,
//                           ontap:(){},
//                           type:TextInputType.number
//                         ),
//                         const SizedBox(height: 10,),
//                         CustomTextFormField(
//                             controller:cubit.adv,
//                             color:Colors.black,
//                             hint: "المميزات ",
//                             max: 5,
//                             obs: false,
//                             obx: false,
//                             ontap:(){},
//                             type:TextInputType.text
//                         ),
//                         const SizedBox(height: 10,),
//                         CustomTextFormField(
//                             controller:cubit.days,
//                             color:Colors.black,
//                             hint: "عدد الايام ",
//                             max: 5,
//                             obs: false,
//                             obx: false,
//                             ontap:(){},
//                             type:TextInputType.number
//                         ),
//
//                         const SizedBox(height: 10,),
//
//
//                         CustomButton(text: "اضافة",
//                             onPressed: (){
//
//                           cubit.addNewBaka();
//
//
//                             }, color1:ColorsManager.primary,
//                             color2: Colors.white),
//                         const SizedBox(height: 30,),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }));
//   }
//
// }