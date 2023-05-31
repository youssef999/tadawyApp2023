

 import 'package:doctors_app/presentaion/bloc/auth/auth_states.dart';
import 'package:doctors_app/presentaion/const/app_message.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/views/sales/sales_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../bloc/auth/auth_cubit.dart';
import '../../resources/assets_manager.dart';
import '../../widgets/Custom_button.dart';
import '../../widgets/custom_textformfield.dart';

class SalesSystem extends StatelessWidget {
  const SalesSystem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {

          if(state is SalesSystemSuccessState){
            appMessage(
              text: 'تم الحجز بنجاح'
            );
            Get.offAll(SalesView());
          }

    },
    builder: (context, state) {
    AuthCubit cubit = AuthCubit.get(context);
    return Scaffold(
      appBar:AppBar(
        toolbarHeight: 1,
        backgroundColor: ColorsManager.primary,
      ),
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 20,),
            CircleAvatar(
              backgroundColor:Colors.white,
              radius: 100,
              child:Image.asset(AssetsManager.Logo),
            ),
            SizedBox(height: 30,),
            CustomTextFormField(
              controller: cubit.nameController,
              obx: false,
              obs: false,
              ontap:(){},
              hint: 'اسم الطبيب',
              type:TextInputType.name,
              input: false,
              color:Colors.black,
            ),
            SizedBox(height: 30,),
            CustomTextFormField(
              controller: cubit.phoneController,
              obx: false,
              obs: false,
              ontap:(){},
              hint: 'هاتف الطبيب',
              type:TextInputType.name,
              input: false,
              color:Colors.black,
            ),
            SizedBox(height: 30,),
            CustomTextFormField(
              controller: cubit.priceController,
              obx: false,
              obs: false,
              ontap:(){},
              hint: 'التكلفة',
              type:TextInputType.number,
              input: false,
              color:Colors.black,
            ),
            SizedBox(height: 30,),
            CustomTextFormField(
              controller: cubit.notesController,
              obx: false,
              obs: false,
              ontap:(){},
              hint: 'الملاحظات',
              type:TextInputType.name,
              input: false,
              color:Colors.black,
            ),
            SizedBox(height: 40,),
            CustomButton(
              text: 'حجز',
              color1:ColorsManager.primary,
              color2:Colors.white,
              onPressed:(){
                cubit.systemBooking();
              },
            )
          ],
        ),
      ),
    );
    }));
  }
}