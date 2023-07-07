


import 'package:doctors_app/domain/models/moderator.dart';
import 'package:doctors_app/presentaion/bloc/tdawa/tdawa_cubit.dart';
import 'package:doctors_app/presentaion/bloc/tdawa/tdawa_states.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../const/app_message.dart';
import '../../../resources/color_manager.dart';
import '../Home/dashboard.dart';
import 'moderators_code.dart';

class ModView extends StatelessWidget {
  const ModView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => TdawaCubit()..getAllMod(),
        child: BlocConsumer<TdawaCubit, TdawaStates>(
            listener: (context, state) {

              if(state is DeleteModSuccessState){
                appMessage(text: 'تم الحذف بنجاح');
                Get.offAll(DashBoardDoctorView(type: 'doctor',));
              }
            },
            builder: (context, state) {
              TdawaCubit tdawaCubit = TdawaCubit.get(context);
              return Scaffold(
                appBar: AppBar(
                  toolbarHeight: 50,
                  backgroundColor: ColorsManager.primary,
                  leading: IconButton(icon: Icon(Icons.arrow_back_ios,size: 21,color:ColorsManager.white,
                  ),onPressed:(){
                    Get.back();
                  },),
                ),
                body:Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ListView(
                    children: [
                      SizedBox(height: 30,),
                      Container(height: 130,
                        child:Image.asset('assets/images/logo2.png'),
                      ),
                      SizedBox(height: 30,),
                     CustomButton(text: 'اضافة مسئول جديد ',
                         onPressed: (){
                           Get.to(ModeratorsCodeView());
                         }, color1: ColorsManager.primary, color2: Colors.white),

                      SizedBox(height: 20,),
                      ModWidget(tdawaCubit.modList,tdawaCubit)

                    ],
                  ),
                ),
              );
            }));
  }
}

Widget ModWidget(List<Mod> listApp,TdawaCubit cubit) {

  return SingleChildScrollView(
    child: Container(
      height:9130,
      color: Colors.grey[200],
      //width:double.infinity,
      padding: const EdgeInsets.only(top: 9, left: 7, right: 7),
      child:
      ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listApp.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white70),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            children: [
                              Custom_Text(
                                text: listApp[index].name.toString(),
                                color: ColorsManager.black,
                                fontSize: 21,
                                alignment: Alignment.center,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 60,
                                child: Custom_Text(
                                  text: listApp[index].code.toString(),
                                  color: Colors.grey,
                                  fontSize: 14,
                                  alignment: Alignment.topRight,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomButton(text: 'حذف',
                                color1:ColorsManager.primary,
                                color2:Colors.white,
                                onPressed:(){
                                cubit.deleteMod(listApp[index].id.toString());
                                },

                              )

                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {


                },
              ),
            );
          }),
    ),
  );
}
