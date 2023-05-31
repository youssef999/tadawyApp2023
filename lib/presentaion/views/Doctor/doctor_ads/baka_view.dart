import 'package:doctors_app/domain/models/ads.dart';
import 'package:doctors_app/domain/models/bouquet.dart';
import 'package:doctors_app/presentaion/bloc/tdawa/tdawa_cubit.dart';
import 'package:doctors_app/presentaion/bloc/tdawa/tdawa_states.dart';
import 'package:doctors_app/presentaion/const/app_message.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/views/Doctor/Home/dashboard.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../resources/assets_manager.dart';


class BakaView extends StatelessWidget {
  Ads ad;
  String image,name,details;
   BakaView({Key? key,required this.ad,required this.image,required this.name,required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create:(BuildContext context)=>TdawaCubit()..getAllBouquet(),
        child: BlocConsumer<TdawaCubit,TdawaStates>(
            listener:(context,state){
              if(state is RenewDoctorAdsSuccessState){

                appMessage(text: 'تم تجديد اعلانك بنجاح');
                Get.offAll( DashBoardDoctorView(type: 'doctor',));
              }
            },
            builder:(context,state){

              TdawaCubit tdawaCubit = TdawaCubit.get(context);

              return Scaffold(
                backgroundColor:Colors.grey[100],
                appBar:AppBar(
                  backgroundColor:ColorsManager.primary,
                  toolbarHeight: 5,
                  elevation: 0,
                ),
                body:Directionality(
                  textDirection: TextDirection.rtl,
                  child: ListView(
                    children: [
                      const SizedBox(height: 20,),
                      SizedBox(
                        height: 120,
                        child:Image.asset(AssetsManager.Logo),
                      ),
                      const SizedBox(height: 20,),
                      const Custom_Text(
                        text: 'تداوي بلس',
                        alignment:Alignment.center,
                        fontSize:22,
                        color:Colors.black,
                      ),
                      const SizedBox(height: 20,),
                      const Custom_Text(text: 'أشترك في طبيبي بلس و أحصل علي مميزات أكتر',
                        alignment: Alignment.center,
                        fontSize:16,
                        color:Colors.black,
                      ),

                      const SizedBox(height: 23,),

                      const Padding(
                        padding: EdgeInsets.only(right:15.0,top:15),
                        child: Custom_Text(text: ' حدد الباقة التي تناسبك',
                          alignment: Alignment.topRight,
                          fontSize:16,
                          color:Colors.black,
                        ),
                      ),
                      const SizedBox(height: 23,),
                      BakaWidget2( tdawaCubit.bakaList,ad,tdawaCubit,
                      name,details,image
                      )




                    ],
                  ),
                ),
              );
            }

        )
    );
  }
}

Widget BakaWidget2(List<Baka>bakaList,Ads ad,  TdawaCubit cubit
    ,String name,String details,String image)

{
  return     SingleChildScrollView(
    child: Container(
      height: 630,
      //width:double.infinity,
      padding:const EdgeInsets.only(top:9,left:7,right:7),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          // physics: const NeverScrollableScrollPhysics(),
          itemCount: bakaList.length,
          itemBuilder: (context, index) {
            return
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width:MediaQuery.of(context).size.width*0.43,
                  decoration:BoxDecoration(
                      borderRadius:BorderRadius.circular(20),
                      color:ColorsManager.white
                  ),
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          children: [
                            const SizedBox(height: 10,),
                            Custom_Text(text: bakaList[index].name.toString(),
                              fontSize:19,
                              color:Colors.black,
                              alignment:Alignment.center,
                            ),
                            const SizedBox(height: 50,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Custom_Text(text: bakaList[index].details.toString(),
                                fontSize:19,
                                color:Colors.black,
                                alignment:Alignment.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Custom_Text(text: bakaList[index].description.toString(),
                                fontSize:14,
                                color:ColorsManager.primary,
                                alignment:Alignment.center,
                              ),
                            ),
                            const SizedBox(height: 60,),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Custom_Text(text: 'سعر الباقة',
                                fontSize:17,
                                color:Colors.black,
                                alignment:Alignment.center,
                              ),
                            ),
                            Positioned(
                              bottom:10,
                              child: Card(
                                color:ColorsManager.primary,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Custom_Text(
                                    text: bakaList[index].price.toString(),
                                    fontSize:20,
                                    color:Colors.white,
                                    alignment:Alignment.center,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30,),
                            const Divider(
                              color:Colors.grey,
                              height: 6,
                            ),

                            Padding(
                              padding: const EdgeInsets.only(right: 20.0,top:20),
                              child: Column(
                                children: [
                                  const Custom_Text(text: 'مميزات الباقة : ',
                                    color:Colors.black,
                                    alignment:Alignment.topRight,
                                    fontSize:20,
                                  ),
                                  const SizedBox(height: 10,),
                                  Container(
                                    height: 90,
                                    child: Custom_Text(text:bakaList[index].adv,
                                      color:ColorsManager.primary,
                                      alignment:Alignment.topRight,
                                      fontSize:14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30,),
                            CustomButton(
                              text: 'تجديد علي هذا النظام ',
                              color1:ColorsManager.primary,
                              color2:Colors.white,
                              onPressed:(){

                                cubit.RenewAd(
                                  days:bakaList[index].days,
                                  detailsHint:details,
                                  nameHint: name,
                                  image2: image,
                                  id: ad.id.toString()
                                );
                        },
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap:(){
                      // tdawaCubit.dispalyFirst();
                      // tdawaCubit. getDocotorAppointments();

                    },
                  ),
                ),
              );
          }),
    ),
  );
}