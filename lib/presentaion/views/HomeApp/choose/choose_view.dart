



 import 'package:doctors_app/presentaion/resources/assets_manager.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/views/splash/splash_screen2.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../User/user_auth/Login.dart';
import '../../User/user_auth/user_login_view.dart';
import '../../sales/sales_code.dart';

class ChooseView extends StatelessWidget {
  const ChooseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        toolbarHeight: 5,
        elevation: 0,
        backgroundColor:ColorsManager.primary,
      ),
      body:
    Container(
      color:Colors.white,
        padding: const EdgeInsets.all(15),
        child: Column(
          children:  [
            const SizedBox(height: 30,),
            Container(
              color:Colors.white,
              height: 150,
              width: 500,
              child:Image.asset(AssetsManager.Logo),
            ),
            const SizedBox(height: 40,),
            const Custom_Text(
              text: 'نوع حسابك ',
              fontSize: 21,
              alignment:Alignment.center,
            ),
            const SizedBox(height: 40,),
            InkWell(
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color:Colors.grey[300]
                ),
                child:Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                          width:45,
                          child: Image.asset('assets/images/doc2.png')),
                      const SizedBox(width: 5,),
                      Column(
                        children: const [
                          SizedBox(height: 20,),
                          Custom_Text(
                            text: 'جهة طبية',
                            fontSize: 21,
                            alignment:Alignment.center,
                          ),
                          SizedBox(height:6,),
                          Custom_Text(
                            text: 'نسعى لتحقيق الأفضل لك و الوصول لعدد كبير من المرضى',
                            fontSize: 12,
                            color: Colors.grey,
                            alignment:Alignment.center,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ),
              onTap:(){
                Get.to(UserLoginView(
                  cat: 'doctor',
                ));
                // Get.to(const HomeView());
              },
            ),
            const SizedBox(height: 40,),
            InkWell(
              child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:Colors.grey[300]
                  ),
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                            width:50,
                            child: Image.asset('assets/images/user2.png')),
                        const SizedBox(width: 35,),
                        Column(
                          children: const [
                            SizedBox(height: 20,),
                            Custom_Text(
                              text: 'مريض ',
                              fontSize: 21,
                              alignment:Alignment.center,
                            ),
                            SizedBox(height:6,),
                            Custom_Text(
                              text: 'نضع صحتك في المقام الاول احجز افضل الاطباء ',
                              fontSize: 12,
                              color: Colors.grey,
                              alignment:Alignment.center,
                            ),
                            Custom_Text(
                              text: ' في دقيقة واحدة فقط توصيلك بالمختص المناسب',
                              fontSize: 12,
                              color: Colors.grey,
                              alignment:Alignment.center,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
              ),
              onTap:(){
                Get.to(const SplashScreen2());
              },
            ),
            const SizedBox(height: 40,),

          ],
        ),
      )
    );
  }
}
