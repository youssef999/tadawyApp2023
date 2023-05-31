
import 'package:doctors_app/presentaion/bloc/auth/auth_cubit.dart';
import 'package:doctors_app/presentaion/bloc/auth/auth_states.dart';
import 'package:doctors_app/presentaion/const/app_message.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/views/User/user_auth/user_login_view.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:doctors_app/presentaion/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Home/dash_board.dart';
import 'Login.dart';



 class UserRegisterView extends StatelessWidget {
 String cat;


 UserRegisterView({required this.cat});

 static String verify="";

  @override
  Widget build(BuildContext context) {
    final box=GetStorage();
    String countryCode=box.read("countryCode")??"+20";


    if (cat == 'user')

    {
      return BlocProvider(
          create: (BuildContext context) => AuthCubit(),
          child: BlocConsumer<AuthCubit, AuthStates>(
              listener: (context, state) {

                if (state is UserLoginSuccessState) {
                  // Get.offAll(UserLoginView(
                  //   cat: 'user',
                  // ));
                  appMessage(text: 'تم انشاء الحساب بنجاح');

                }

                if (state is UserLoginSuccessState2) {

                  Get.offAll(DashBoardFragment());

                  appMessage(text: 'تم انشاء الحساب بنجاح');

                }

                if (state is UserRegisterErrorState) {
                  appMessage(text: 'خطا في انشاء الحساب');
                }


              },
              builder: (context, state) {
                AuthCubit authCubit = AuthCubit.get(context);
                return Scaffold(
                  backgroundColor: Colors.white,
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
                              const SizedBox(height: 20,),

                              const SizedBox(height: 10,),
                              const Custom_Text(text: 'انشاء حساب جديد',
                                fontSize: 24,
                                alignment: Alignment.center,
                                color: Colors.black,
                              ),
                              const SizedBox(height: 20,),

                              const Custom_Text(text:

                              'ادخل البيانات التالية حتى تتمكن من انشاء الحساب والوصول الى اقرب طبيب اليك',
                                fontSize: 17,
                                alignment: Alignment.center,
                                color:  Colors.black54,
                              ),


                              const SizedBox(height: 40,),


                              CustomTextFormField(
                                controller: authCubit.nameController,
                                color: Colors.black,
                                hint: "الاسم بالكامل",
                                max: 1,
                                obs: false,
                                obx: false,
                                ontap: () {},
                                type: TextInputType.text,
                              ),
                              const SizedBox(height: 10,),
                              CustomTextFormField(
                                controller: authCubit.emailController,
                                color: Colors.black,
                                hint: "البريد الالكتروني ",
                                max: 1,
                                obs: false,
                                obx: false,
                                ontap: () {},
                                type: TextInputType.text,
                              ),
                              const SizedBox(height: 20,),

                              Container(
                                padding: const EdgeInsets.only(right: 16,bottom: 20,left:14,top: 20),
                                decoration:BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color:Colors.white
                                ),
                                child: TextFormField(
                                  controller: authCubit.phoneController,
                                  decoration: InputDecoration(
                                      suffixIcon: Text(countryCode),
                                    hintText: 'رقم الهاتف '
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20,),
                              CustomTextFormField(
                                controller: authCubit.passwordController,
                                color: Colors.black,
                                hint: "كلمة المرور ",
                                obs: true,
                                obx: true,
                                ontap: () {},
                                type: TextInputType.text,
                              ),
                              const SizedBox(height: 30,),

                              CustomButton(text: "انشاء الحساب ",
                                  onPressed: () {

                                authCubit.validateUserEmail();
                                 // authCubit.userRegister(
                                 //   countryCode: countryCode
                                 // );
                                 //
                                 // authCubit. registerInFireBase(type: 'user',
                                 // countryCode:countryCode
                                 // );
                                    //authCubit.userRegister();
                                  }, color1: ColorsManager.primary,
                                  color2: Colors.white),
                              
                              SizedBox(height: 16,),
                              Row(
                                children: [
                                  SizedBox(width: 70,),
                                  Custom_Text(text: 'امتلك جساب ؟ ',fontSize:16,color:Colors.grey,),
                                  SizedBox(width: 50,),
                                  Custom_Text(text: 'تسجيل دخول ',fontSize:18,color:ColorsManager.primary,),
                                ],
                              ),
                              const SizedBox(height: 20,),
                              (authCubit.option==true)?
                              Container(
                                width: 250,
                                child: CustomButton(text: " دخول  مباشر للتطبيق بالبريد المسجل  ",
                                    onPressed: () {
                                  authCubit.autoLogin2(authCubit.emailController.text, authCubit.passwordController.text);

                                    }, color1: ColorsManager.primary,
                                    color2: Colors.white),
                              ):SizedBox(),
                              
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }));
    }

    else {
      return BlocProvider(
          create: (BuildContext context) => AuthCubit(),
          child: BlocConsumer<AuthCubit, AuthStates>(
              listener: (context, state) {
                if (state is UserRegisterSuccessState) {

                  Get.to(UserLoginView(
                    cat: 'doctor',
                  ));
                  appMessage(text: 'تم انشاء الحساب بنجاح');
                }

                if (state is UserRegisterErrorState) {
                  appMessage(text: 'خطا في انشاء الحساب');
                }
              },
              builder: (context, state) {
                AuthCubit authCubit = AuthCubit.get(context);
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
                              const SizedBox(height: 20,),

                              const SizedBox(height: 10,),
                              const Custom_Text(text: 'انشاء حساب جديد',
                                fontSize: 24,
                                alignment: Alignment.center,
                                color: Colors.black,
                              ),
                              const SizedBox(height: 20,),

                              const Custom_Text(text:

                              'ادخل البيانات التالية حتى تتمكن من انشاء الحساب والوصول الى اقرب طبيب اليك',
                                fontSize: 17,
                                alignment: Alignment.center,
                                color: Colors.black54,
                              ),


                              const SizedBox(height: 40,),


                              CustomTextFormField(
                                controller: authCubit.nameController,
                                color: Colors.black,
                                hint: "الاسم بالكامل",
                                max: 2,
                                obs: false,
                                obx: false,
                                ontap: () {},
                                type: TextInputType.text,
                              ),
                              const SizedBox(height: 10,),
                              CustomTextFormField(
                                controller: authCubit.emailController,
                                color: Colors.black,
                                hint: "البريد الالكتروني ",
                                max: 2,
                                obs: false,
                                obx: false,
                                ontap: () {},
                                type: TextInputType.text,
                              ),
                              const SizedBox(height: 10,),
                              CustomTextFormField(
                                controller: authCubit.phoneController,
                                color: Colors.black,
                                hint: "رقم الهاتف  ",
                                max: 2,
                                obs: false,
                                obx: false,
                                ontap: () {},
                                type: TextInputType.phone,
                              ),


                              const SizedBox(height: 20,),
                              CustomTextFormField(
                                controller: authCubit.passwordController,
                                color: Colors.black,
                                hint: "كلمة المرور ",
                                obs: true,
                                obx: true,
                                ontap: () {},
                                type: TextInputType.text,
                              ),
                              const SizedBox(height: 30,),

                              // CustomButton(text: "انشاء الحساب ",
                              //     onPressed: () {
                              //       authCubit.registerAndSaveUserRecord(
                              //         selectedOption: sele
                              //       );
                              //     }, color1: ColorsManager.primary,
                              //     color2: Colors.white),

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
}
