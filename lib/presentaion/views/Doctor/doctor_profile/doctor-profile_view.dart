
import 'package:doctors_app/presentaion/bloc/doc_profile/doctor_cubit.dart';
import 'package:doctors_app/presentaion/bloc/doc_profile/doctor_states.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/views/HomeApp/choose/choose_view.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'change_password_view.dart';


class DoctorProfileView extends StatelessWidget {
  String type;

  DoctorProfileView({Key? key,required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    int x=0;
    return BlocProvider(
        create: (BuildContext context) => DoctorCubit()..getDocotorData(),
        child: BlocConsumer<DoctorCubit, DoctorStates>(
        listener: (context, state) {

          if(state is getDoctorDataSuccessState ){
            x=1;
          }
        },

    builder: (context, state) {

      DoctorCubit doctorCubit = DoctorCubit.get(context);

      if(x==1){
        return Scaffold(
          appBar:AppBar(
            toolbarHeight: 5,
            elevation: 0,
            backgroundColor:ColorsManager.primary,
          ),
          body:
          Directionality(
            textDirection:TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children:  [
                  const SizedBox(height: 20,),
                  SizedBox(
                    height:190,
                    width:400,
                    child:Image.network(doctorCubit.doc.doctor_image.toString(),fit:BoxFit.scaleDown),),
                  const SizedBox(height: 20,),
                  Custom_Text(text: doctorCubit.doc.doctor_name.toString(),alignment:Alignment.topRight,
                    fontSize:21,
                    color:ColorsManager.primary,
                  ),
                  const SizedBox(height: 15,),
                  Custom_Text(text: doctorCubit.doc.doctor_cat.toString(),alignment:Alignment.topRight,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    children: [

                  Icon(Icons.phone,color:ColorsManager.primary,),

                      const SizedBox(width: 60,),
                     Column(
                       children: [
                         Custom_Text(text: 'رقم  ارضي ',alignment: Alignment.topRight),
                          SizedBox(height: 10,),
                         Custom_Text(text: doctorCubit.doc.clink_phone1.toString(),alignment:Alignment.center,
                           fontSize:15,
                           color:ColorsManager.black,
                         ),
                         SizedBox(height: 10,),
                         Custom_Text(text: 'رقم  موبيل ',alignment: Alignment.topRight),
                         SizedBox(height: 10,),
                         Custom_Text(text: doctorCubit.doc.clink_phone2.toString(),alignment:Alignment.center,
                           fontSize:15,
                           color:ColorsManager.black,
                         ),
                         SizedBox(height: 10,),
                         Custom_Text(text: 'رقم  واتس ',alignment: Alignment.topRight),
                         SizedBox(height: 10,),
                         Custom_Text(text: doctorCubit.doc.clink_phone3.toString(),alignment:Alignment.center,
                           fontSize:15,
                           color:ColorsManager.black,
                         ),
                         SizedBox(height: 6,),
                       ],
                     )
                    ],
                  ),
                  Divider(
                    thickness:0.6,
                    color:Colors.black,
                  ),
                  const SizedBox(height: 15,),
                  (type=='doctor')?
                  InkWell(
                    child: Row(
                      children: [

                        Icon(Icons.password_sharp,color:ColorsManager.primary,),

                        const SizedBox(width: 60,),


                        Custom_Text(text: '  تغيير كلمة المرور ',
                            fontSize: 26
                            ,alignment: Alignment.topRight),
                      ],
                    ),
                    onTap:(){
                      Get.to(ChangePasswordView());
                    },
                  ):SizedBox(),
                  const SizedBox(height: 15,),
                  Divider(
                    thickness:0.6,
                    color:Colors.black,
                  ),

                  const SizedBox(height: 15,),
                  Row(
                    children: [
                      Icon(Icons.place,color:ColorsManager.primary,),
                      const SizedBox(width: 20,),
                      Custom_Text(text: doctorCubit.doc.position.toString(),alignment:Alignment.topRight,
                        fontSize:15,
                        color:ColorsManager.black,
                      ),

                    ],
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    children: [

                    Icon(Icons.price_change,color:ColorsManager.primary,),
                      const SizedBox(width: 20,),
                      const Custom_Text(text: 'السعر   -  ',alignment:Alignment.topRight,
                        fontSize:15,
                        color:ColorsManager.black,
                      ),
                      const SizedBox(width: 10,),
                      Custom_Text(text: doctorCubit.doc.price.toString(),alignment:Alignment.topRight,
                        fontSize:15,
                        color:ColorsManager.black,
                      ),

                    ],
                  ),
                  SizedBox(height: 11,),
                  Row(
                    children: [

                      Icon(Icons.ad_units,color:ColorsManager.primary,),
                      const SizedBox(width: 20,),
                      const Custom_Text(text: 'المنصب   -  ',alignment:Alignment.topRight,
                        fontSize:15,
                        color:ColorsManager.black,
                      ),
                      const SizedBox(width: 10,),
                      Custom_Text(text: doctorCubit.doc.clink_p1.toString(),alignment:Alignment.topRight,
                        fontSize:15,
                        color:ColorsManager.black,
                      ),

                    ],
                  ),
                  const SizedBox(height: 15,),
                  const Padding(
                    padding: EdgeInsets.only(left:36.0,right:36.0),
                    child: Divider(
                      height:6,
                      color:Colors.black,
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    children: [

                      Container(
                        child: Image.asset('assets/images/profile.png'),
                      ),
                      const SizedBox(width: 20,),
                      const Custom_Text(text: ' معلوماتي  ',alignment:Alignment.topRight,
                        fontSize:24,
                        color:ColorsManager.black,
                      ),
                      const SizedBox(width: 10,),
                    ],
                  ),

                  const SizedBox(height: 15,),
                  Custom_Text(text: doctorCubit.doc.doctor_info.toString(),alignment:Alignment.center,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                  const SizedBox(height: 22,),
                  (doctorCubit.doc.image1.toString()!='')?
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                   //   width: 100,
                      height: 140,
                      child: Image.network(doctorCubit.doc.image1.toString(),fit:BoxFit.fill),
                    ),
                  ):SizedBox(),
                  Row(
                    children: [

                      Image.asset('assets/images/grade.png'),
                      const SizedBox(width: 20,),
                      const Custom_Text(text: ' الدرجة العلمية ',alignment:Alignment.topRight,
                        fontSize:24,
                        color:ColorsManager.black,
                      ),
                      const SizedBox(width: 10,),
                    ],
                  ),
                  (doctorCubit.doc.image2.toString()!='')?
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      //   width: 100,
                      height: 140,
                      child: Image.network(doctorCubit.doc.image2.toString(),fit:BoxFit.fill),
                    ),
                  ):SizedBox(),
                  const SizedBox(height: 12,),
                  Custom_Text(text: doctorCubit.doc.doctor_degree.toString(),alignment:Alignment.center,
                    fontSize:15,
                    color:ColorsManager.black,
                  ),
                  const SizedBox(height: 22,),
                  ( doctorCubit.doc.clink_name2!.isNotEmpty)?
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Divider(height: 2,thickness: 2,color:Colors.grey,),
                      ),
                      SizedBox(height: 10,),
                      Custom_Text(text: 'مكان عملك الاخر',alignment:Alignment.center,
                        fontSize:22,
                        color:ColorsManager.black,
                      ),
                      SizedBox(height: 10,),

                      Custom_Text(text: doctorCubit.doc.clink_name2.toString(),alignment:Alignment.center,
                        fontSize:15,
                        color:ColorsManager.black,
                      ),
                      SizedBox(height: 10,),
                      Custom_Text(text: doctorCubit.doc.address2.toString(),alignment:Alignment.center,
                        fontSize:15,
                        color:ColorsManager.black,
                      ),
                      SizedBox(height: 10,),
                      Custom_Text(text: 'رقم  ارضي ',alignment: Alignment.topRight),
                    //  SizedBox(height: 6,),
                      Custom_Text(text: doctorCubit.doc.clink_phone4.toString(),alignment:Alignment.center,
                        fontSize:15,
                        color:ColorsManager.black,
                      ),
                      SizedBox(height: 6,),
                      Custom_Text(text: 'رقم  موبيل ',alignment: Alignment.topRight),
                    //  SizedBox(height: 6,),
                      Custom_Text(text: doctorCubit.doc.clink_phone5.toString(),alignment:Alignment.center,
                        fontSize:15,
                        color:ColorsManager.black,
                      ),
                      SizedBox(height: 6,),
                      Custom_Text(text: 'رقم  واتس ',alignment: Alignment.topRight),
                    //  SizedBox(height: 6,),
                      Custom_Text(text: doctorCubit.doc.clink_phone6.toString(),alignment:Alignment.center,
                        fontSize:15,
                        color:ColorsManager.black,
                      ),
                      SizedBox(height: 6,),
                      Custom_Text(text: 'المنصب ',alignment: Alignment.topRight),
                   //   SizedBox(height: 6,),
                      Custom_Text(text: doctorCubit.doc.clink_p2.toString(),alignment:Alignment.center,
                        fontSize:15,
                        color:ColorsManager.black,
                      ),
                    ],
                  ):SizedBox(height: 1,),

                  ( doctorCubit.doc.clink_name3!.isNotEmpty)?
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Divider(height: 2,thickness: 2,color:Colors.grey,),
                      ),
                      SizedBox(height: 10,),
                      Custom_Text(text: 'مكان عملك الاخر',alignment:Alignment.center,
                        fontSize:22,
                        color:ColorsManager.black,
                      ),
                      SizedBox(height: 10,),

                      Custom_Text(text: doctorCubit.doc.clink_name3.toString(),alignment:Alignment.center,
                        fontSize:15,
                        color:ColorsManager.black,
                      ),
                      SizedBox(height: 10,),
                      Custom_Text(text: doctorCubit.doc.address3.toString(),alignment:Alignment.center,
                        fontSize:15,
                        color:ColorsManager.black,
                      ),
                      SizedBox(height: 10,),
                      Custom_Text(text: 'رقم  ارضي ',alignment: Alignment.topRight),
                      //  SizedBox(height: 6,),
                      Custom_Text(text: doctorCubit.doc.clink_phone7.toString(),alignment:Alignment.center,
                        fontSize:15,
                        color:ColorsManager.black,
                      ),
                      SizedBox(height: 6,),
                      Custom_Text(text: 'رقم  موبيل ',alignment: Alignment.topRight),
                      //  SizedBox(height: 6,),
                      Custom_Text(text: doctorCubit.doc.clink_phone8.toString(),alignment:Alignment.center,
                        fontSize:15,
                        color:ColorsManager.black,
                      ),
                      SizedBox(height: 6,),
                      Custom_Text(text: 'رقم  واتس ',alignment: Alignment.topRight),
                      //  SizedBox(height: 6,),
                      Custom_Text(text: doctorCubit.doc.clink_phone9.toString(),alignment:Alignment.center,
                        fontSize:15,
                        color:ColorsManager.black,
                      ),
                      SizedBox(height: 6,),
                      Custom_Text(text: 'المنصب ',alignment: Alignment.topRight),
                      //   SizedBox(height: 6,),
                      Custom_Text(text: doctorCubit.doc.clink_p3.toString(),alignment:Alignment.center,
                        fontSize:15,
                        color:ColorsManager.black,
                      ),
                    ],
                  ):SizedBox(height: 1,),


                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CustomButton(
                      text: 'تسجيل خروج',
                      color1:ColorsManager.primary,
                      color2:Colors.white,
                      onPressed:(){
                        final box=GetStorage();
                        box.remove('doc_Id');
                        Get.offAll(const ChooseView());
                      },
                    ),
                  )

                ],
              ),
            ),
          ),
        );
      }else{
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

    }));
  }
}
