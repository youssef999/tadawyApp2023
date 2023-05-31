import 'dart:io';
import 'package:doctors_app/presentaion/bloc/tdawa/tdawa_cubit.dart';
import 'package:doctors_app/presentaion/bloc/tdawa/tdawa_states.dart';
import 'package:doctors_app/presentaion/const/app_message.dart';
import 'package:doctors_app/presentaion/views/sales/sales_view.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:doctors_app/presentaion/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../resources/color_manager.dart';
import '../Home/dashboard.dart';
import '../Home/home_view.dart';

class CreateAdView extends StatelessWidget {

  int days;
  int numOfAds;
  bool sales;
  bool free;
  String type;
   CreateAdView({Key? key,required this.days,required this.type,required this.sales,required this.free,required this.numOfAds}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return BlocProvider(
         create: (BuildContext context) => TdawaCubit(),
         child: BlocConsumer<TdawaCubit, TdawaStates>(
         listener: (context, state) {

           if(state is addNewAdSuccessState){
             appMessage(text:'تم اضافة اعلانك بنجاح' );

             if(sales==false){

               Get.offAll( DashBoardDoctorView(type: 'doctor',));
             }


             if(sales==true){
               Get.offAll(SalesView());
             }

           }

           if(state is addNewAdErrorState){
             appMessage(text:'خطا في اضافة اعلانك ' );


           }
         },
     builder: (context, state) {
     TdawaCubit tdawaCubit = TdawaCubit.get(context);

     return Scaffold(
       backgroundColor: Colors.grey[200],
       appBar: AppBar(
         backgroundColor:ColorsManager.primary,
         toolbarHeight: 4,
         elevation: 0,
       ),
       body:Padding(
         padding: const EdgeInsets.all(25.0),
         child: ListView(
           children: [
             const SizedBox(height:10,),

               Custom_Text(text: 'هذا الاعلان لمدة $days' +' يوم  '  ,
               color:Colors.black,fontSize:25,alignment:Alignment.center,
               ),
             const SizedBox(height:20,),
               tdawaCubit.pickedImageXFile != null?
             InkWell(
               child: Container(
                 height:  MediaQuery.of(context).size.width*0.6,
                 width: MediaQuery.of(context).size.width*0.8,
                 decoration:BoxDecoration(
                   borderRadius:BorderRadius.circular(19), 
                     image: DecorationImage(
                         image:FileImage(
                             File(tdawaCubit.pickedImageXFile!.path)),
                         fit:BoxFit.fill
                     )
                 ),
               ),
               onTap:(){
                 tdawaCubit.showDialogBox(context);
               },
             ):InkWell(
               child: Column(
                 children: [

                   CircleAvatar(
                     radius: 100,
                     child:Image.asset('assets/images/logo.png'),
                   ),
                   const SizedBox(height: 10,),
                   const Custom_Text(text: 'اضف صورة الاعلان ',color:Colors.black,
                     fontSize:21,alignment:Alignment.center,
                   ),
                 ],
               ),
               onTap:(){
                 tdawaCubit.showDialogBox(context);
               },
             ),
             const SizedBox(height: 20,),

             (sales==true)?   CustomTextFormField(
               controller: tdawaCubit.idController,
               color:Colors.black,
               obx: false,
               obs: false,
               type:TextInputType.text,
               hint: ' الرمز التعريفي للطبيب ',
               ontap:(){},
               max: 2,
               input: false,
             ):SizedBox(height: 2,),

             SizedBox(height: 20,),

             CustomTextFormField(
               controller: tdawaCubit.adNameController,
               color:Colors.black,
               obx: false,
               obs: false,
               type:TextInputType.text,
               hint: 'اسم الاعلان ',
               ontap:(){},
               max: 2,
               input: false,
             ),
             const SizedBox(height:30,),

             CustomTextFormField(
               controller: tdawaCubit.adDetailsController,
               color:Colors.black,
               obx: false,
               obs: false,
               type:TextInputType.text,
               hint: 'تفاصيل الاعلان ',
               ontap:(){},
               max: 10,
               input: false,
             ),
             const SizedBox(height:20,),
             CustomButton(
               text: 'اضف اعلانك',
               color1:ColorsManager.primary ,
               color2:Colors.white,
               onPressed:() {
                 appMessage(text: 'جاري رفع اعلانك ');
                 // if(tdawaCubit.imageLink.length<2){
                 //   appMessage(text: 'ادخل الصورة مجددا');
                 //   tdawaCubit.showDialogBox(context);
                 // }
                 Future.delayed(Duration(seconds: 3)).then((value) {
                   tdawaCubit.addNewAd(days,sales);
                   if(free==true){
                     print('num of ads');
                     tdawaCubit.changeNumOfAds(numOfAds);
                     // tdawaCubit.addNewAd(days,sales);
                   }
                   else{
                     final box=GetStorage();
                     box.remove('payAds');
                     box.remove('days');
                     //tdawaCubit.addNewAd(days,sales);
                   }
                 });
                 //tdawaCubit.addNewAd(days,sales);
               },
             )
           ],
         ),
       )
     );
     }));
   }
}