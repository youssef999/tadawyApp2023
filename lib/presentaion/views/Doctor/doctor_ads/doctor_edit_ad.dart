
import 'dart:io';

import 'package:doctors_app/presentaion/bloc/tdawa/tdawa_cubit.dart';
import 'package:doctors_app/presentaion/const/app_message.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/views/Doctor/Home/dashboard.dart';
import 'package:doctors_app/presentaion/views/Doctor/Home/home_view.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../bloc/tdawa/tdawa_states.dart';
import '../../../widgets/custom_textformfield.dart';

class DoctorEditView extends StatefulWidget {
  String name,details,image,adId;


  DoctorEditView({required this.name, required this.details, required this.image,required this.adId});

  @override
  State<DoctorEditView> createState() => _EditViewState();
}


class _EditViewState extends State<DoctorEditView> {

  @override
  Widget build(BuildContext context) {


    return  BlocProvider(
        create:(BuildContext context)=>TdawaCubit(),
        child: BlocConsumer<TdawaCubit,TdawaStates>(
            listener:(context,state){

              if(state is UpdateDoctorAdsSuccessState)

              {
                appMessage(text: 'تم تعديل بياناتك بنجاح');

                Get.offAll( DashBoardDoctorView(type: 'doctor',));
              }
            },
            builder:(context,state){

              TdawaCubit cubit = TdawaCubit.get(context);


              return Scaffold(

                  appBar:AppBar(
                    toolbarHeight: 5,
                    elevation: 0,
                    backgroundColor:ColorsManager.primary,
                  ),
                  body:Padding(
                    padding: const EdgeInsets.all(10.0),
                    child:

                    ListView(
                      children: [

                        const SizedBox(height: 10,),

                        cubit.pickedImageXFile != null?
                        InkWell(
                          child:
                          Container(
                            height:  MediaQuery.of(context).size.width*0.6,
                            width: MediaQuery.of(context).size.width*0.8,
                            decoration:BoxDecoration(
                                image: DecorationImage(
                                    image:FileImage(
                                        File(cubit.pickedImageXFile!.path)),
                                    fit:BoxFit.fill
                                )
                            ),
                          ),
                          onTap:(){
                            cubit.showDialogBox(context);
                          },
                        ):InkWell(
                          child: Column(
                            children: [
                              Container(
                                height:  MediaQuery.of(context).size.width*0.6,
                                width: MediaQuery.of(context).size.width*0.8,
                                decoration:BoxDecoration(

                                ),
                                child:Image.network(widget.image,
                                    fit:BoxFit.fill
                                ),
                              ),
                             // Container(
                             //   height: 190,
                             //   decoration: BoxDecoration(
                             //     borderRadius:BorderRadius.circular(20),
                             //     color:ColorsManager.primary
                             //
                             //   ),
                             //
                             //    child:Image.network(widget.image),
                             //  ),
                              const SizedBox(height: 20,),
                              const Custom_Text(text: 'تعديل صورة الاعلان ',color:Colors.black,
                                fontSize:21,alignment:Alignment.center,
                              ),
                            ],
                          ),
                          onTap:(){
                            cubit.showDialogBox(context);
                          },
                        ),
                        const SizedBox(height: 20,),


                        const Custom_Text(
                          text: 'اسم الاعلان ',
                          alignment:Alignment.topRight,
                        ),
                        const SizedBox(height: 10,),
                        CustomTextFormField(
                          controller:cubit.adNameController ,
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
                          text: 'تفاصيل الاعلان   ',
                          alignment:Alignment.topRight,
                        ),
                        const SizedBox(height: 10,),
                        CustomTextFormField(
                          controller:cubit.adDetailsController,
                          hint: widget.details,
                          color:Colors.black,
                          obs: false,
                          type: TextInputType.text,
                          obx: false,
                          ontap:(){},
                          max: 5,
                        ),
                        const SizedBox(height: 20,),

                        const SizedBox(height: 30,),
                        CustomButton(
                          text: 'تعديل',
                          color1:ColorsManager.primary,
                          color2:Colors.white,
                          onPressed:(){
                            cubit.updateData(
                                widget.adId,widget.name,widget.details,widget.image
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