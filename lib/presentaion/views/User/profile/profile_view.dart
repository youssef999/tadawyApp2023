

import 'package:doctors_app/presentaion/bloc/patient/patient_cubit.dart';
import 'package:doctors_app/presentaion/bloc/patient/patient_states.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../resources/assets_manager.dart';
import '../../../widgets/Custom_Text.dart';
import 'edit_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int x=0;

    return BlocProvider(
        create: (BuildContext context) => PatientCubit()..getUserData(),
        child: BlocConsumer<PatientCubit, PatientStates>(
            listener: (context, state) {

              if(state is getUserDataSuccessState){
                x=1;
              }
            },
            builder: (context, state) {
              PatientCubit cubit = PatientCubit.get(context);

              if(x==1){
                return Scaffold(
                  backgroundColor: Colors.white,
                    appBar: AppBar(
                      toolbarHeight: 8,
                      elevation: 0,
                      backgroundColor: ColorsManager.primary,
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: ListView(
                          children: [
                            const SizedBox(
                              height: 4,
                            ),

                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: ColorsManager.primaryx),
                              child: Image.asset(AssetsManager.Logo),
                            ),

                            SizedBox(
                              height: 70,
                            ),
                            const Custom_Text(
                              text: 'الاسم',
                              fontSize: 21,
                              color: Colors.black,
                              alignment: Alignment.topRight,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Custom_Text(
                              text: cubit.user.name.toString(),
                              fontSize: 15,
                              color: Colors.grey,
                              alignment: Alignment.topRight,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 30.0, right: 30),
                              child: Divider(
                                thickness: 0.9,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Custom_Text(
                              text: 'البريد الخاص بك',
                              fontSize: 21,
                              color: Colors.black,
                              alignment: Alignment.topRight,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Custom_Text(
                              text: cubit.user.email.toString(),
                              fontSize: 15,
                              color: Colors.grey,
                              alignment: Alignment.topRight,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 30.0, right: 30),
                              child: Divider(
                                thickness: 0.9,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Custom_Text(
                              text: 'رقم الهاتف',
                              fontSize: 21,
                              color: Colors.black,
                              alignment: Alignment.topRight,
                            ),
                            const SizedBox(
                              height: 15,
                            ),

                            Custom_Text(
                              text: cubit.user.phone.toString(),
                              fontSize: 15,
                              color: Colors.grey,
                              alignment: Alignment.topRight,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            CustomButton(
                              text: 'تعديل',
                              color1: ColorsManager.primary,
                              color2: Colors.white,
                              onPressed: () {
                                Get.to(EditView(
                                  name: cubit.user.name.toString(),
                                  phone: cubit.user.phone.toString(),
                                  email: cubit.user.email.toString(),
                                ));
                              },
                            )
                          ],
                        ),
                      ),
                    ));
              }else{
                return Center(child: CircularProgressIndicator());
              }

            }));
  }
}
