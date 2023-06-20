import 'package:doctors_app/presentaion/bloc/auth/auth_cubit.dart';
import 'package:doctors_app/presentaion/bloc/auth/auth_states.dart';
import 'package:doctors_app/presentaion/const/app_message.dart';
import 'package:doctors_app/presentaion/pay_mob/modules/payment/doctor_sub_payment/baka_view.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/views/Doctor/moderator/mod_login_view.dart';
import 'package:doctors_app/presentaion/views/User/user_auth/user_register_view.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:doctors_app/presentaion/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../Doctor/Home/dashboard.dart';
import '../../Doctor/Payment/all_payments.dart';
import '../Home/dash_board.dart';

class UserLoginView extends StatefulWidget {
  String cat;

  UserLoginView({required this.cat});

  @override
  State<UserLoginView> createState() => _UserLoginViewState();
}

class _UserLoginViewState extends State<UserLoginView> {
  int toogleIndex=0;
  Color toogleColor = ColorsManager.primary;
  Color toogleColorInActive = Colors.blue;

  @override
  Widget build(BuildContext context) {

    final box=GetStorage();
    String countryCode=box.read('countryCode');
    if (widget.cat == 'user') {

      return BlocProvider(
          create: (BuildContext context) => AuthCubit(),
          child:
          BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
            if (state is UserLoginSuccessState ) {
              Get.offAll(const DashBoardFragment());
              appMessage(text: 'تم تسجيل الدخول بنجاح');
            }

            if (state is UserLoginErrorState) {
              appMessage(text: 'خطا في تسجيل دخول');
            }

            if (state is UserLoginLoadingState) {
              print("LOADING");
            }
          }, builder: (context, state) {
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Column(
                          children: [

                            const SizedBox(
                              height: 20,
                            ),
                            const Custom_Text(
                              text: ' قم بتسجيل دخول ',
                              fontSize: 24,
                              alignment: Alignment.center,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: Container(
                                child:Row(
                                  mainAxisAlignment:MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child:Container(
                                        width: 120,
                                        height: 60,
                                        child: Card(
                                          color:toogleColor,
                                          child:Custom_Text(text: 'بالبريد',color:Colors.white,
                                              alignment:Alignment.center
                                              ,fontSize: 22),
                                        ),
                                      ),
                                      onTap:(){
                                        setState(() {
                                          toogleColor=ColorsManager.primary;
                                          toogleColorInActive= Colors.blue;
                                          toogleIndex=0;
                                        });
                                      },
                                    ),
                                    InkWell(
                                      child:Container(
                                        width: 120,
                                        height: 60,
                                        child: Card(
                                          color:toogleColorInActive,
                                          child:Custom_Text(text: 'بالهاتف',color:Colors.white,
                                              alignment:Alignment.center
                                              ,fontSize: 22),
                                        ),
                                      ),
                                      onTap:(){
                                        setState(() {
                                          toogleColor= Colors.blue;
                                          toogleColorInActive=ColorsManager.primary;
                                          toogleIndex=1;
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            (toogleIndex==0)?
                            Container(
                              width: 350,
                              child: CustomTextFormField(
                                controller: authCubit.emailController,
                                color: Colors.black,
                                hint: "البريد الالكتروني ",
                                max: 2,
                                obs: false,
                                obx: false,
                                ontap: () {},
                                type: TextInputType.text,
                              ),
                            ):  Padding(
                              padding: const EdgeInsets.only(left:25.0,right: 25,top:10,bottom: 5),
                              child: Container(
                                padding: const EdgeInsets.only(right: 16,bottom: 20,left:16,top: 20),
                                decoration:BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    border: Border.all(color:Colors.grey[200]!,),
                                    color:Colors.white),
                                child: TextFormField(
                                  keyboardType:TextInputType.phone,
                                  controller: authCubit.phoneController,
                                  decoration: InputDecoration(
                                      suffixIcon: Text(countryCode,style:TextStyle(color:Colors.black,fontSize: 20)),
                                      hintText: 'رقم الهاتف '
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),

                            Container(
                              width: 350,
                              child: CustomTextFormField(
                                controller: authCubit.passwordController,
                                color: Colors.black,
                                hint: "كلمة المرور ",
                                obs: true,
                                obx: true,
                                ontap: () {},
                                type: TextInputType.text,
                              ),
                            ),

                            const SizedBox(
                              height: 30,
                            ),
                            CustomButton(
                                text: "تسجيل الدخول ",
                                onPressed: () {

                                  if(toogleIndex==0){

                                    authCubit.userLogin();
                                  }

                                  else{

                                    authCubit.userLoginWithPhone();

                                  }
                                },
                                color1: ColorsManager.primary,
                                color2: Colors.white),

                            SizedBox(height: 40,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Container(
                                    width: 140,
                                    child: Divider(height:3,color:Colors.black,)),
                                SizedBox(width: 10,),
                                Custom_Text(text: 'ا و',fontSize: 20,alignment:Alignment.center),
                                SizedBox(width: 10,),
                                Container(
                                    width: 140,
                                    child: Divider(height:3,color:Colors.black,)),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              splashColor: ColorsManager.primary,
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  color:Colors.grey[100],
                                  borderRadius:BorderRadius.circular(12)
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width: 40,),
                                    Container(
                                        height: 30,
                                        width: 30,
                                        child: Image.asset('assets/images/g.png')),
                                    SizedBox(width: 100,),
                                    Custom_Text(text: '  جوجل',fontSize: 23,alignment: Alignment.center,color:Colors.black,)
                                  ],
                                ),
                              ),
                              onTap:(){
                                print("GOOGLE");
                                authCubit.googleValidateUserEmail();
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              splashColor: ColorsManager.primary,
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                    color:Colors.grey[100],
                                    borderRadius:BorderRadius.circular(12)
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width: 40,),
                                    Container(
                                        height: 30,
                                        width: 30,
                                        child: Image.asset('assets/images/f.png')),
                                    SizedBox(width: 100,),
                                    Custom_Text(text: ' الفيس بوك',fontSize: 23,alignment: Alignment.center,color:Colors.black,)
                                  ],
                                ),
                              ),
                              onTap:(){

                                print("facebook");
                                authCubit.FaceValidateUserEmail ();
                                //   authCubit.loginFaceBook();
                                //authCubit.googleValidateUserEmail();
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              child: Row(
                                children: [
                                  SizedBox(width: 30,),
                                  Custom_Text(text: 'بالاستمرار فانت توافق علي ',
                                  fontSize:16,
                                    color:ColorsManager.black,
                                    alignment: Alignment.topRight,
                                  ),
                                  Custom_Text(text: 'الشروط والاحكام',
                                  fontSize:16,
                                    color:ColorsManager.primary,
                                    alignment: Alignment.topRight,
                                  ),


                                ],
                              ),
                              onTap:(){

                              },
                            ),
                            SizedBox(height: 20,),
                            InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Custom_Text(
                                      text: 'ليس لديك حساب ؟ ',
                                      fontSize: 17,
                                      color: Colors.grey),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Custom_Text(
                                      text: 'انشاء حساب  ',
                                      fontSize: 15,
                                      color: ColorsManager.primary),
                                ],
                              ),
                              onTap: () {
                                Get.to(UserRegisterView(
                                  cat: 'user',
                                ));
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }));
    } else {
      return BlocProvider(
          create: (BuildContext context) => AuthCubit(),
          child:
          BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
            if (state is LoginSuccessState) {
              Get.offAll(DashBoardDoctorView(
                type: 'doctor',
              ));

              appMessage(text: 'تم تسجيل الدخول بنجاح');
            }

            if (state is LoginErrorState) {
              appMessage(text: 'خطا في تسجيل دخول');
            }

            if (state is LoginSuccessState) {
              Get.offAll(DashBoardDoctorView(
                type: 'doctor',
              ));

              appMessage(text: 'تم تسجيل الدخول بنجاح');
            }

            if (state is LoginErrorState) {
              appMessage(text: 'خطا في تسجيل دخول');
            }
            if (state is LoginLoadingState) {
              print("LOADING");
            }
          }, builder: (context, state) {
            AuthCubit authCubit = AuthCubit.get(context);
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: ColorsManager.primary,
                toolbarHeight: 60,
                leading: IconButton(icon: Icon(Icons.arrow_back_ios),
                onPressed:(){
                  Get.back();
                },
                ),
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
                          const SizedBox(
                            height: 20,
                          ),
                          const Custom_Text(
                            text: ' خاص بالأطباء و الجهات الطبية فقط  ',
                            fontSize: 24,
                            alignment: Alignment.center,
                            color: Colors.black,
                          ),

                          SizedBox(height: 20,),
                          // InkWell(
                          //   child: Container(
                          //     child: Custom_Text(
                          //       text: 'عمليات الدفع',
                          //       alignment: Alignment.center,
                          //       fontSize: 25,
                          //       color:Colors.black,
                          //     ),
                          //   ),
                          //   onTap:(){
                          //     Get.to(AllPaymentsView());
                          //   },
                          // ),
                          SizedBox(height: 20,),
                          Container(
                            height: 190,
                            child:Image.asset('assets/images/obj2.png'),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Container(
                              child:Row(
                                mainAxisAlignment:MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    child:Container(
                                      width: 120,
                                      height: 60,
                                      child: Card(
                                        color:toogleColor,
                                        child:Custom_Text(text: 'بالبريد',color:Colors.white,
                                            alignment:Alignment.center
                                            ,fontSize: 22),
                                      ),
                                    ),
                                    onTap:(){
                                      setState(() {
                                        toogleColor=ColorsManager.primary;
                                        toogleColorInActive= Colors.blue;
                                        toogleIndex=0;
                                      });
                                    },
                                  ),
                                  InkWell(
                                    child:Container(
                                      width: 120,
                                      height: 60,
                                      child: Card(
                                        color:toogleColorInActive,
                                        child:Custom_Text(text: 'بالهاتف',color:Colors.white,
                                            alignment:Alignment.center
                                            ,fontSize: 22),
                                      ),
                                    ),
                                    onTap:(){
                                      setState(() {
                                        toogleColor= Colors.blue;
                                        toogleColorInActive=ColorsManager.primary;
                                        toogleIndex=1;
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          (toogleIndex == 0)
                              ? Container(
                            width: 350,
                                child: CustomTextFormField(
                            controller: authCubit.emailController,
                            color: Colors.black,
                            hint: "البريد الالكتروني ",
                            max: 2,
                            obs: false,
                            obx: false,
                            ontap: () {},
                            type: TextInputType.text,
                          ),
                              )

                              :       Padding(
                            padding: const EdgeInsets.only(left:25.0,right: 25,top:10,bottom: 5),
                            child: Container(
                              padding: const EdgeInsets.only(right: 16,bottom: 20,left:16,top: 20),
                              decoration:BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(color:Colors.grey[200]!,),
                                  color:Colors.white),
                              child: TextFormField(
                                keyboardType:TextInputType.phone,
                                controller: authCubit.phoneController,
                                decoration: InputDecoration(
                                    suffixIcon: Text(countryCode,style:TextStyle(color:Colors.black,fontSize: 20)),
                                    hintText: 'رقم الهاتف '
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: 350,
                            child: CustomTextFormField(
                              controller: authCubit.passwordController,
                              color: Colors.black,
                              hint: "كلمة المرور ",
                              obs: true,
                              obx: true,
                              ontap: () {},
                              type: TextInputType.text,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                              text: "تسجيل الدخول ",
                              onPressed: () {
                                if(toogleIndex==0){
                                  authCubit.login();
                                }else{
                                  authCubit.loginDoctorWithPhone();
                                }},
                              color1: ColorsManager.primary,
                              color2: Colors.white),


                          const SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Custom_Text(text: 'بالاستمرار فانت توافق علي ',
                                  fontSize:16,
                                  color:Colors.grey,
                                  alignment: Alignment.topRight,
                                ),
                                Custom_Text(text: 'الشروط والاحكام',
                                  fontSize:16,
                                  color:ColorsManager.primary,
                                  alignment: Alignment.topRight,
                                ),


                              ],
                            ),
                            onTap:(){

                            },
                          ),



                          const SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Custom_Text(
                                    text: 'ليس لديك حساب ؟ ',
                                    fontSize: 17,
                                    color: Colors.grey),
                                SizedBox(
                                  width: 10,
                                ),
                                Custom_Text(
                                    text: 'انشاء حساب  ',
                                    fontSize: 15,
                                    color: ColorsManager.primary),
                              ],
                            ),
                            onTap: () {

                              // Get.to(RegisterView(
                              //   sales: false,
                              // ));

                              Get.to( BakaView(sales: false,
                              type: 'doctor',
                              ));


                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Custom_Text(
                                    text: 'انت احد مديري حساب لطبيب ',
                                    fontSize: 14,
                                    color: Colors.grey),
                                SizedBox(
                                  width: 2,
                                ),
                                Custom_Text(
                                    text: 'تسجيل كمدير حساب  ',
                                    fontSize: 14,
                                    color: ColorsManager.primary),
                              ],
                            ),
                            onTap: () {
                              Get.to(ModLoginView());
                            },
                          )
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
