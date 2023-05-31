import 'package:doctors_app/presentaion/bloc/tdawa/tdawa_cubit.dart';
import 'package:doctors_app/presentaion/bloc/tdawa/tdawa_states.dart';
import 'package:doctors_app/presentaion/const/app_message.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:doctors_app/presentaion/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../Home/dashboard.dart';


class ModLoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => TdawaCubit(),
        child:
            BlocConsumer<TdawaCubit, TdawaStates>(listener: (context, state) {
          if (state is ModLoginSuccessState) {

            Get.offAll( DashBoardDoctorView(type: 'mod',));
            appMessage(text: 'تم تسجيل الدخول بنجاح');

          }

          if (state is ModLoginErrorState) {

            appMessage(text: 'خطا في تسجيل دخول');

          }

          if (state is ModLoginLoadingState) {
            print("LOADING");
          }
        }, builder: (context, state) {
          TdawaCubit cubit = TdawaCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              elevation: 0,
              backgroundColor: ColorsManager.primary,
              toolbarHeight: 1,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 150,
                          child: Image.asset('assets/images/logo2.png'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Custom_Text(
                          text: ' قم تسجيل دخول ',
                          fontSize: 24,
                          alignment: Alignment.center,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 50,
                        ),

                        CustomTextFormField(
                          controller: cubit.nameController,
                          color: Colors.black,
                          hint: "الاسم ",
                          max: 2,
                          obs: false,
                          obx: false,
                          ontap: () {},
                          type: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextFormField(
                          controller: cubit.codeController,
                          color: Colors.black,
                          hint: " الكود الخاص بك  ",
                          obs: true,
                          obx: true,
                          ontap: () {},
                          type: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        CustomButton(
                            text: "تسجيل الدخول ",
                            onPressed: () {
                              cubit.modLogin();
                            },
                            color1: ColorsManager.primary,
                            color2: Colors.white),
                        const SizedBox(
                          height: 30,
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
