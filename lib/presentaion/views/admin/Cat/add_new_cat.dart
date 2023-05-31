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
// class AddNewCat extends StatelessWidget {
//    const AddNewCat({Key? key}) : super(key: key);
//
//    @override
//    Widget build(BuildContext context) {
//      return BlocProvider(
//          create: (BuildContext context) => AdminCubit()..getAllCat(),
//          child: BlocConsumer<AdminCubit, AdminStates>(
//
//          listener: (context, state) {
//        if(state is AddCatSuccessState){
//          appMessage(text: 'تم الاضافة بنجاح');
//          Get.offAll(AdminView());
//        }
//      },
//
//      builder: (context, state) {
//
//      AdminCubit cubit = AdminCubit.get(context);
//      return Scaffold(
//        appBar:AppBar(
//          elevation: 0,
//          toolbarHeight: 5,
//          backgroundColor:ColorsManager.primary,
//        ),
//        body:
//        Column(
//          children:  [
//            const SizedBox(height: 20,),
//            Image.asset('assets/images/logo2.png'),
//
//
//
//            const SizedBox(height: 20,),
//            cubit.pickedImageXFile != null?
//            InkWell(
//              child: Container(
//                height:  MediaQuery.of(context).size.width*0.6,
//                width: MediaQuery.of(context).size.width*0.8,
//                decoration:BoxDecoration(
//                    image: DecorationImage(
//                        image:FileImage(
//                            File(cubit.pickedImageXFile!.path)),
//                        fit:BoxFit.fill
//                    )
//                ),
//              ),
//              onTap:(){
//                cubit.showDialogBox(context);
//              },
//            ):InkWell(
//              child: Column(
//                children: [
//
//                  CircleAvatar(
//                    radius: 100,
//                    child:Image.asset('assets/images/doc2.png'),
//                  ),
//                  const SizedBox(height: 10,),
//                  const Custom_Text(text: 'اضف صورة الاعلان',color:Colors.black,
//                    fontSize:21,alignment:Alignment.center,
//                  ),
//                ],
//              ),
//              onTap:(){
//                cubit.showDialogBox(context);
//              },
//            ),
//            const SizedBox(height: 20,),
//            CustomTextFormField(
//              controller:cubit.nameController,
//              color:Colors.black,
//              hint: "الاسم ",
//              max: 2,
//              obs: false,
//              obx: false,
//              ontap:(){},
//              type:TextInputType.text,
//            ),
//            const SizedBox(height: 10,),
//            CustomTextFormField(
//              controller:cubit.catController,
//              color:Colors.black,
//              hint: "التصنيف",
//              max: 2,
//              obs: false,
//              obx: false,
//              ontap:(){},
//              type:TextInputType.text,
//            ),
//
//
//
//            const SizedBox(height: 20,),
//            CustomButton(text: "اضافة",
//                onPressed: (){
//
//              cubit.addNewCat();
//
//                }, color1:ColorsManager.primary,
//                color2: Colors.white),
//            const SizedBox(height: 30,),
//          ],
//        ),
//      );
//      }));
//    }
// }