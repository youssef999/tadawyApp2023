import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../User/user_auth/Login.dart';
import '../User/user_auth/user_login_view.dart';


  class SplashScreen2 extends StatefulWidget {

    const SplashScreen2({Key? key}) : super(key: key);

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar(
        toolbarHeight: 1,
        elevation: 0,
        backgroundColor:ColorsManager.primary,
      ),
      body:Container(
        color: ColorsManager.primary,
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 30,),
            Container(
              height: 140,
              child:Image.asset('assets/images/logo.png'),
            ),
            const SizedBox(height: 40,),
            const Custom_Text(
              text: 'تداوي',
              fontSize: 22,
              color:Colors.white,
              alignment: Alignment.center,
            ),
            const SizedBox(height: 30,),
            const Custom_Text(
              text: 'يمكنك الان تحديد التخصص المطلوب وأقرب منطقة وسوف تجد امهر الاطباء في جميع التخصصات',
              fontSize: 18,
              color:Colors.white,
              alignment: Alignment.center,
            ),
            const SizedBox(height: 40,),
            Container(
              height: 190,
              child:Image.asset('assets/images/obj2.png'),
            ),
            const SizedBox(height: 10,),

             Padding(
               padding: const EdgeInsets.all(20.0),
               child: CustomButton(
                  text: 'التالي',
                  color1:ColorsManager.white,
                  color2: ColorsManager.primary,
                  onPressed:(){
                    Get.off( UserLoginView(
                      cat: 'user',
                    ));

                  },
                ),
             ),

          ],
        ),
      )
    );
  }
}
