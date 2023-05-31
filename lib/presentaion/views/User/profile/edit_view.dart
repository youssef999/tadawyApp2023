


 import 'package:doctors_app/presentaion/bloc/patient/patient_cubit.dart';
import 'package:doctors_app/presentaion/bloc/patient/patient_states.dart';
import 'package:doctors_app/presentaion/const/app_message.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_textformfield.dart';
import '../Home/dash_board.dart';

class EditView extends StatefulWidget {
  String name,phone,email;

  EditView({required this.name, required this.phone, required this.email});

  @override
  State<EditView> createState() => _EditViewState();
}


class _EditViewState extends State<EditView> {

  @override
  Widget build(BuildContext context) {


    return  BlocProvider(
        create:(BuildContext context)=>PatientCubit()..getUserData(),
        child: BlocConsumer<PatientCubit,PatientStates>(
        listener:(context,state){

          if(state is UpdateDataSuccessState){

            appMessage(text: 'تم تعديل بياناتك بنجاح');

            Get.offAll(const DashBoardFragment());
          }
    },
    builder:(context,state){

    PatientCubit cubit = PatientCubit.get(context);


    return Scaffold(

      appBar:AppBar(
        elevation: 0,
        toolbarHeight: 5,
        backgroundColor:ColorsManager.primary,
      ),
      body:Padding(
        padding: const EdgeInsets.only(left:30.0,right: 30),
        child: ListView(
          children: [
            const SizedBox(height: 20,),

            Container(
                height: 100,
                child: Image.asset('assets/images/logo2.png')),
            const SizedBox(height: 40,),
            const Custom_Text(
              text: 'البريد الالكتروني ',
              alignment:Alignment.topRight,
            ),
            const SizedBox(height: 10,),
            CustomTextFormField(
              controller:cubit.email ,
              hint: widget.email,
              color:Colors.black,
              obs: false,
              type: TextInputType.text,
              obx: false,
              ontap:(){},
              max: 2,
            ),
            const SizedBox(height: 20,),
            const Custom_Text(
              text: 'الاسم  ',
              alignment:Alignment.topRight,
            ),
            const SizedBox(height: 10,),
            CustomTextFormField(
              controller:cubit.name ,
              hint: widget.name,
              color:Colors.black,
              obs: false,
              type: TextInputType.text,
              obx: false,
              ontap:(){},
              max: 2,
            ),
            const SizedBox(height: 20,),
            const Custom_Text(
              text: 'رقم الهاتف ',
              alignment:Alignment.topRight,
            ),
            const SizedBox(height: 10,),
            CustomTextFormField(
              controller:cubit.phone ,
              hint: widget.phone,
              color:Colors.black,
              obs: false,
              type: TextInputType.text,
              obx: false,
              ontap:(){},
              max: 2,
            ),
            const SizedBox(height: 30,),
            CustomButton(
              text: 'تعديل',
              color1:ColorsManager.primary,
              color2:Colors.white,
              onPressed:(){
                cubit.updateData(
                  widget.email,widget.name,widget.phone
                );
              },
            )
          ],
        ),
      )
    );
    }

        )
    );
  }
}