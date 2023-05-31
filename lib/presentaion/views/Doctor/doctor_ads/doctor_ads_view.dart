

 import 'package:doctors_app/domain/models/ads.dart';
import 'package:doctors_app/presentaion/bloc/tdawa/tdawa_cubit.dart';
import 'package:doctors_app/presentaion/bloc/tdawa/tdawa_states.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/views/Doctor/doctor_ads/renew_ad.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'doctor_edit_ad.dart';


 class DoctorAdsView extends StatelessWidget {
  const DoctorAdsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => TdawaCubit()..getDoctorAds(),
        child: BlocConsumer<TdawaCubit, TdawaStates>
          (listener: (context, state) {

        },
    builder: (context, state) {
    TdawaCubit tdawaCubit = TdawaCubit.get(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        elevation: 0,
        backgroundColor:ColorsManager.primary,
        toolbarHeight: 10,
      ),
      body:ListView(
        children: [
          const SizedBox(height: 20,),
          AdWidget(tdawaCubit.adsList, tdawaCubit)
        ],
      )
    );
    }));
  }
}

 Widget AdWidget(List<Ads> listApp,TdawaCubit cubit) {

   DateTime now = DateTime.now();

if(listApp.length<1){
  return Column(
    children: [
      SizedBox(height: 30,),
     Container(
       height: 300,
       child:Image.asset('assets/images/data.png'),
     ),
      SizedBox(height: 30,),
      Custom_Text(text: 'لا توجد لديك اعلانات',color:Colors.black,fontSize: 24,alignment:Alignment.center,)
    ],
  );
}
else{
  return SingleChildScrollView(
    child: Container(
      height:12130,
      color: Colors.white,
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
                        Row(
                          children: [
                            SizedBox(
                                height: 200,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Image.network(
                                  listApp[index].image.toString(),
                                  fit:BoxFit.fill,
                                )),

                            SizedBox(
                              width:MediaQuery.of(context).size.width * 0.10,
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
                                      text: listApp[index].details.toString(),
                                      color: Colors.grey,
                                      fontSize: 14,
                                      alignment: Alignment.topRight,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  (listApp[index].date_end.isAfter(now))?
                                  Column(
                                    children: [
                                      const Custom_Text(
                                        text: 'تاريخ انتهاء اعلانك ',
                                        color: ColorsManager.black,
                                        fontSize: 18,
                                        alignment: Alignment.center,
                                      ),
                                      const SizedBox(height: 10,),
                                      Custom_Text(
                                        text: listApp[index].date_end.toString().replaceAll('00:00:00.000',
                                            ''),
                                        color: Colors.grey,
                                        fontSize: 16,
                                        alignment: Alignment.center,
                                      ),
                                      const SizedBox(height: 10,),
                                      CustomButton(
                                        text: 'تعديل',
                                        color1:ColorsManager.primary,
                                        color2: Colors.white,
                                        onPressed:(){
                                          Get.to(DoctorEditView(
                                            name: listApp[index].name,
                                            details: listApp[index].details,
                                            image: listApp[index].image,
                                            adId: listApp[index].id.toString(),
                                          ));
                                        },
                                      )
                                    ],
                                  ):
                                  Column(
                                    children: [
                                      const Custom_Text(
                                        text: 'تم انتهاء اعلانك ',
                                        color: Colors.red,
                                        fontSize: 18,
                                        alignment: Alignment.center,
                                      ),
                                      SizedBox(height: 10,),
                                      CustomButton(
                                        text: 'اعادة نشر ',
                                        color1:ColorsManager.primary,
                                        color2: Colors.white,
                                        onPressed:(){
                                          Get.to(RenewAdView(
                                            ad:listApp[index],
                                          ));
                                        },
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),

                                ],
                              ),
                            ),
                          ],
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

 }