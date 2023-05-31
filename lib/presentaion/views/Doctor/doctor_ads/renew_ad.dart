
import 'dart:io';

import 'package:doctors_app/domain/models/ads.dart';
import 'package:doctors_app/presentaion/bloc/tdawa/tdawa_cubit.dart';
import 'package:doctors_app/presentaion/bloc/tdawa/tdawa_states.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:doctors_app/presentaion/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'baka_view.dart';


 class RenewAdView extends StatelessWidget {

  Ads ad;

   RenewAdView({Key? key,required this.ad}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => TdawaCubit(),
        child: BlocConsumer<TdawaCubit, TdawaStates>(
        listener: (context, state) {

        },
    builder: (context, state) {

    TdawaCubit cubit = TdawaCubit.get(context);
    return Scaffold(
      appBar:AppBar(
        toolbarHeight: 5,
        elevation: 0,
        backgroundColor:ColorsManager.primary,
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [

            const SizedBox(height: 10,),

            cubit.pickedImageXFile != null?
            InkWell(
              child: Container(
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
                    height: 190,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(20),
                        color:ColorsManager.primary

                    ),

                    child:Image.network(ad.image,fit:BoxFit.fill,),
                  ),
                  const SizedBox(height: 20,),
                  const Custom_Text(text: ' صورة الاعلان ',color:Colors.black,
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
              hint: ad.name,
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
              hint: ad.details,
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
              text: 'تجديد الاعلان',
              color1:ColorsManager.primary,
              color2:Colors.white,
              onPressed:(){

                String e,n,image;
                if(cubit.adNameController.text==''){
                  e=ad.name;
                }else{
                  e=cubit.adNameController.text;
                }

                if(cubit.adDetailsController.text==''){
                  n=ad.details;
                }else{
                  n=cubit.adDetailsController.text;
                }
                if(  cubit.pickedImageXFile==null){
                  image=ad.image;
                }else{
                  image=cubit.pickedImageXFile!.path;
                }

                Get.to(BakaView(
                    ad:ad,
                  name: e,
                  details: n,
                  image: image,
                ));

              },
            )
          ],
        ),
      ),

    );
    }));
  }
}
