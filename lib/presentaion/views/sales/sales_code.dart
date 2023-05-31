 import 'package:doctors_app/presentaion/bloc/auth/auth_cubit.dart';
import 'package:doctors_app/presentaion/bloc/auth/auth_states.dart';
import 'package:doctors_app/presentaion/const/app_message.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/views/sales/sales_view.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:doctors_app/presentaion/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SalesCodeView extends StatelessWidget {
  const SalesCodeView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {

      if(state is  SalesLoginSuccessState){
        appMessage(text: 'تم تسجيل الدخول بنجاح ');
        Get.offAll(const SalesView());
      }

      if(state is SalesLoginErrorState){

        appMessage(text: 'حدث خطا ربما ادخلت بيانات بشكل خاطئ');


      }
    },
    builder: (context, state) {
    AuthCubit cubit = AuthCubit.get(context);
    return Scaffold(
      appBar:AppBar(
        toolbarHeight: 3,
        elevation: 0,
        backgroundColor:ColorsManager.primary,
      ),
      body:Column(
        children:  [
          //const SizedBox(height: 20,),
          Container(
            height: 220,
            width: 700,
            decoration: BoxDecoration(
              color:ColorsManager.primary,
              borderRadius:BorderRadius.circular(1)
            ),
            child: Image.asset('assets/images/logo.png'),
          ),
          const SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomTextFormField(
              controller: cubit.code,
              color:Colors.black,
              obx: false,
              obs: false,
              type:TextInputType.text,
              hint: ' كود المندوبين  ',
              ontap:(){},
              max: 2,
              input: false,
            ),
          ),
          const SizedBox(height: 20,),
          CustomButton(
            text: 'التالي',
            color1:ColorsManager.primary,
            color2:Colors.white,
            onPressed:(){
              cubit.salesLogin();
            },
          )
        ],
      ),
    );
    }));
  }
}
