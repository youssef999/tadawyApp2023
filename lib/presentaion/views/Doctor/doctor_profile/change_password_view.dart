


 import 'dart:convert';
 import 'package:doctors_app/presentaion/const/app_message.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:doctors_app/Data/api_connection/api_connection.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:doctors_app/presentaion/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';

import '../../../resources/assets_manager.dart';
import '../Home/dashboard.dart';

class ChangePasswordView extends StatelessWidget {

   ChangePasswordView({Key? key}) : super(key: key);

  TextEditingController passController=TextEditingController();
  TextEditingController checkPassController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        toolbarHeight: 2,
        backgroundColor:ColorsManager.primary,
      ),
      body:Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              height: 140,
              child:Image.asset(AssetsManager.Logo),
            ),
            SizedBox(height: 18,),
            CustomTextFormField(hint: 'كلمة المرور الجديدة',
                obx: true, ontap:(){},
                type: TextInputType.text, obs: true, color:ColorsManager.primary
                , controller: passController),
            SizedBox(height: 18,),
            CustomTextFormField(hint: 'تاكيد كلمة المرور ',
                obx: true, ontap:(){},
                type: TextInputType.text, obs: true, color:ColorsManager.primary
                , controller: checkPassController),

            SizedBox(height: 20,),

            CustomButton(text:'تغيير كلمة المرور', onPressed: (){
              changePassword();
            }, color1:ColorsManager.primary
                , color2:Colors.white)

          ],
        ),
      ),
    );
  }
   changePassword() async {

    final box=GetStorage();
    String id=box.read("doc_Id");
     try {
       var res = await http.post(Uri.parse(API.UpdatePassword), body: {
         'doctor_id':id,
         'doctor_password': passController.text.trim(),
       });

       print("res======== ${res.body}");

       if (res.statusCode == 200) {
         print("200");

         var resOfLogin = jsonDecode((res.body));

         if (resOfLogin['success'] == true) {

           appMessage(text: 'تم تغيير كلمة المرور بنجاح');

           Get.offAll(DashBoardDoctorView(
             type: 'doctor',
           ));



         } else {
          appMessage(text: 'حدث خطا');
         }
       } else {
         print(res.statusCode);
       }
     } catch (e) {
       print(e);

     }
   }
}
