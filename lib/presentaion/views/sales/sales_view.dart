


 import 'package:doctors_app/domain/models/sales.dart';
import 'package:doctors_app/presentaion/bloc/auth/auth_cubit.dart';
import 'package:doctors_app/presentaion/bloc/auth/auth_states.dart';
import 'package:doctors_app/presentaion/resources/assets_manager.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/views/Doctor/doctor_reg/register_view.dart';
import 'package:doctors_app/presentaion/views/sales/get_all_doctors._view.dart';
import 'package:doctors_app/presentaion/views/sales/sales_system.dart';
import 'package:doctors_app/presentaion/views/splash/splash_screen.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../pay_mob/modules/payment/doctor_sub_payment/baka_view.dart';
import '../../widgets/Custom_Text.dart';
import '../Doctor/Payment/tdawa_plus_view.dart';

class SalesView extends StatefulWidget {
  const SalesView({Key? key}) : super(key: key);

  @override
  State<SalesView> createState() => _SalesViewState();
}

class _SalesViewState extends State<SalesView> {
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (BuildContext context) => AuthCubit()..getSalesData()..getCoins(),
        child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {

    },
    builder: (context, state) {

    AuthCubit authCubit = AuthCubit.get(context);

    final box=GetStorage();

    var adsCoins=box.read('adsCoins');
    var systemCoins=box.read('systemCoins');
    //var loginCoins=box.read('loginCoins');

    return Scaffold(
      appBar:AppBar(
        elevation: 0,
        toolbarHeight: 2,
        backgroundColor:ColorsManager.primary,
      ),
      body:Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children:  [

            // SalesWidget(authCubit.salesList,authCubit),
           // const SizedBox(height: 20,),
            Container(
              height: 200,
              width: 700,
              decoration:BoxDecoration(
                borderRadius:BorderRadius.circular(1),
                color:Colors.white
              ),
              child:Image.asset(AssetsManager.Logo),
            ),
            const SizedBox(height: 50,),
            Custom_Text(
              text: authCubit.salesInfo.name.toString(),
              alignment:Alignment.center,
              fontSize: 30,
            ),
            const SizedBox(height: 40,),
            Custom_Text(
              text: "النقاط "+authCubit.salesInfo.coins.toString(),
              alignment:Alignment.center,
              fontSize: 30,
            ),
            const SizedBox(height: 40,),
            //
            CustomButton(
              text: 'انشاء حساب لطبيب',
              color1:ColorsManager.primary,
              color2:Colors.white,
              onPressed:(){

                // Get.to( RegisterView(
                //   sales: true,
                //   adsNum:0 , days: 0,
                // ));

                Get.to(BakaView(
                  sales: true,
                  type: 'doctor',
                ));



                // print(loginCoins);
                // Get.to( RegisterView(
                //   sales: true,
                //   adsNum: ,
                // ));
              },
            ),
            const SizedBox(height: 20,),
            CustomButton(
              text: 'حجز سيستم',
              color1:ColorsManager.primary,
              color2:Colors.white,

              onPressed:(){
                print(systemCoins);
                Get.to(SalesSystem ());
                // Get.to( TdawaPlusView(
                //   sales: true,
                // ));
              },
            ),
            // const SizedBox(height: 20,),
            // CustomButton(
            //   text: 'انشاء اعلان ',
            //   color1:ColorsManager.primary,
            //   color2:Colors.white,
            //   onPressed:(){
            //     print(adsCoins);
            //
            //     // must be edit
            //     Get.to( TdawaPlusView(
            //       sales: true,
            //       numAds:0,
            //     ));
            //   },
            // ),
            const SizedBox(height: 20,),

            CustomButton(
              text: 'الجهات الطبية  ',
              color1:ColorsManager.primary,
              color2:Colors.white,
              onPressed:() {
                Get.to(GetAllDoctorsView());
              }  ),
            const SizedBox(height: 20,),
            CustomButton(
              text: 'تسجيل خروج ',
              color1:ColorsManager.primary,
              color2:Colors.white,
              onPressed:(){

                final box=GetStorage();
                box.remove('SalesId');
                box.remove('userId');
                box.remove('doc_Id');

                Get.offAll( SplashView());
                },
            ),
          ],
        ),
      )
    );
    }));
  }
}

 Widget SalesWidget(List<Sales> listApp,AuthCubit cubit) {

   print("LIST");
   print(listApp);

   if(listApp.isNotEmpty){
     return SingleChildScrollView(
       child: Container(
         height: 12000,
         color: Colors.white,
         //width:double.infinity,
         padding: const EdgeInsets.only(top: 9, left: 7, right: 7),
         child: ListView.builder(
             physics: const NeverScrollableScrollPhysics(),
             itemCount: listApp.length,
             itemBuilder: (context, index) {
               return Padding(
                 padding: const EdgeInsets.all(8.0),
                 child:

              Column(
                children: [
                  Custom_Text(
                    text: listApp[index].name.toString(),
                    color: ColorsManager.black,
                    fontSize: 16,
                    alignment: Alignment.center,
                  ),
                  SizedBox(height: 20,),
                  Custom_Text(
                    text: listApp[index].coins.toString(),
                    color: ColorsManager.black,
                    fontSize: 16,
                    alignment: Alignment.center,
                  ),
                ],
              )
               );
             }),
       ),
     );

   }
   else{
     return Container(
       color: Colors.white,
       child: Column(
         children: [
           const SizedBox(height: 30,),
           SizedBox(
             height:290,
             child:Image.asset("assets/images/data.png"),
           ),
           const SizedBox(height: 11,),
           const Custom_Text(
             text: ' لم تقم باي حجز حتي الان  ',
             fontSize: 22,
             color:Colors.black,
             alignment:Alignment.center,
           ),
           const SizedBox(height: 170,),
         ],
       ),
     );
   }

 }