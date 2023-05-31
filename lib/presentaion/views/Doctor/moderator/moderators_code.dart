


import 'package:doctors_app/presentaion/bloc/tdawa/tdawa_cubit.dart';
import 'package:doctors_app/presentaion/bloc/tdawa/tdawa_states.dart';
import 'package:doctors_app/presentaion/const/app_message.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:doctors_app/presentaion/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../Home/dashboard.dart';
import 'mod_view.dart';

 class ModeratorsCodeView extends StatelessWidget {
  const ModeratorsCodeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => TdawaCubit(),
        child: BlocConsumer<TdawaCubit, TdawaStates>(
        listener: (context, state) {

          if(state is AddModSuccessState){
            appMessage(text: 'تم الاضافة بنجاح');
            Get.off(ModView());
          }

    },
    builder: (context, state) {

          TdawaCubit tdawaCubit = TdawaCubit.get(context);

          return Scaffold(
      appBar:AppBar(
        elevation: 0,
        toolbarHeight: 4,
        backgroundColor:ColorsManager.primary,
      ),
            body:Padding(
              padding: const EdgeInsets.all(23.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30,),
                    Container(height: 130,
                    child:Image.asset(AssetsManager.Logo),
                    ),
                    SizedBox(height: 30,),
                    CustomTextFormField(
                      controller:tdawaCubit.nameController,
                      color:Colors.black,
                      hint: "الاسم بالكامل",
                      max: 2,
                      obs: false,
                      obx: false,
                      ontap:(){},
                      type:TextInputType.text,
                    ),
                    const SizedBox(height: 10,),
                    CustomTextFormField(
                      controller:tdawaCubit.codeController,
                      color:Colors.black,
                      hint: "كود المسئول عن حسابك ",
                      max: 2,
                      obs: false,
                      obx: false,
                      ontap:(){},
                      type:TextInputType.text,
                    ),
                    const SizedBox(height: 20,),
                    CustomButton(
                      text: 'اضافة',
                      color1:ColorsManager.primary,
                      color2: Colors.white,
                      onPressed:(){


                        tdawaCubit.addNewMod();
                      },
                    )
                  ],
                ),
              ),
            ),
    );
    }));
  }
}
