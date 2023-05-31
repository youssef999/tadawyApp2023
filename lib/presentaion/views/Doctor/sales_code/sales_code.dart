import 'package:doctors_app/presentaion/pay_mob/modules/payment/doctor_sub_payment/baka_view.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/views/splash/splash_screen.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../bloc/auth/auth_cubit.dart';
import '../../../bloc/auth/auth_states.dart';
import '../../../widgets/Custom_button.dart';

class SalesCode extends StatelessWidget {


 // TextEditingController code = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AuthCubit(),
        child:
        BlocConsumer<AuthCubit, AuthStates>(
            listener: (context, state) {}, builder: (context, state) {
          AuthCubit authCubit = AuthCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 3,
              backgroundColor: ColorsManager.primary,
            ),
            body: Padding(
              padding: const EdgeInsets.all(21.0),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Custom_Text(text: 'ادخل كود المندوب المسئول عن تسجيلك',
                  fontSize:21,alignment:Alignment.center,
                    color:ColorsManager.primary,
                  ),
                  SizedBox(height: 20,),
                  CustomTextFormField(hint: 'كود المندوب',
                      obx: false,
                      ontap: () {},
                      type: TextInputType.text,
                      obs: false,
                      color: ColorsManager.primary,
                      controller:authCubit.salesCode),
                  SizedBox(height: 50,),
                  CustomButton(text: 'تفعيل', onPressed: () {

                    //authCubit.  salesLogin();

                    authCubit.SalesCoins('login');

                    Future.delayed(Duration(seconds: 2)).then((value) {
                      Get.offAll(SplashView());

                    });
                  }, color1: ColorsManager.primary, color2: Colors.white)
                ],
              ),
            ),
          );
        }));
  }
}