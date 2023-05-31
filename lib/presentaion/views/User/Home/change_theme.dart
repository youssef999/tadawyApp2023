import 'package:doctors_app/presentaion/views/User/Home/dash_board.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../widgets/Custom_button.dart';
import '../../splash/splash_screen.dart';



class ChangeThemeScreen extends StatelessWidget {
  const ChangeThemeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box=GetStorage();
    return Scaffold(
      appBar:AppBar(
        backgroundColor:ColorsManager.primary,
        toolbarHeight: 4,
      ),
      body:Center(
        child: Column(
          children: [
            SizedBox(height: 60,),
            Container(
              decoration:BoxDecoration(
                borderRadius:BorderRadius.circular(38),
                color: Colors.white
              ),
              height:170,
              width: 221,
              child:   Image.asset(AssetsManager.Logo),
            ),
            SizedBox(height: 30,),
            CustomButton(
              text: 'الاساسي',
              color1:ColorsManager.primary,
              color2:Colors.white,
              onPressed:(){
                box.write('Theme','blue');
                Get.offAll(SplashView());
                },
            ),
            SizedBox(height: 20,),
            CustomButton(
              text: 'اللون الاخضر ',
              color1:ColorsManager.primary,
              color2:Colors.white,
              onPressed:(){
                box.write('Theme','green');
                Get.offAll(SplashView());
                },
            ),
          ],
        ),
      )
    );
  }
}
