


  import 'dart:io';

import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:doctors_app/presentaion/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SendEmailView extends StatelessWidget {
    SendEmailView({Key? key}) : super(key: key);

   TextEditingController phone=TextEditingController();
   TextEditingController sub=TextEditingController();
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.white,
       appBar: AppBar(
         backgroundColor: ColorsManager.primary,
         toolbarHeight: 3,
       ),
       body:Padding(
         padding: const EdgeInsets.all(23.0),
         child: ListView(
         //  mainAxisAlignment: MainAxisAlignment.start,
           //crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             SizedBox(height: 20,),
             Icon(Icons.email_outlined,size: 120,color:ColorsManager.primary,),
             SizedBox(height: 7,),
             Custom_Text(text: 'قم بارسال اي استفسار تريد',alignment: Alignment.center,fontSize: 17,color:Colors.black,),
             // Container(
             //   height: 120,
             //   child:Image.asset('assets/images/t.png'),),
             SizedBox(height: 20,),
             Container(
               width: 300,
               decoration: BoxDecoration(
                 borderRadius:BorderRadius.circular(6),
                 border:Border.all(color:Colors.grey[200]!)
               ),
               child: CustomTextFormField(hint: 'رقم الموبايل', obx: false, ontap:(){}, type:TextInputType.text, obs:false
                   , color: Colors.black, controller: phone),
             ),
             SizedBox(height: 30,),
             Container(
               width: 300,
               decoration: BoxDecoration(
                   borderRadius:BorderRadius.circular(6),
                   border:Border.all(color:Colors.grey[200]!)
               ),
               child: CustomTextFormField(hint: 'تفاصيل', obx: false, ontap:(){}, type:TextInputType.text, obs:false
                   , color: Colors.black, controller: sub,max:5),
             ),
             SizedBox(height: 40,),
             CustomButton(text: 'ارسال', onPressed: (){
               sendEmail('info@tadawiapp.com',sub.text);
             }, color1:ColorsManager.primary, color2:Colors.white)
           ],
         ),
       )
     );
   }
 }
  sendEmail(String mail,String sub)async{

    String emailUrl = 'mailto:$mail?subject=Tedawy Mail&body=$sub';
    String url(){
      if(Platform.isAndroid){
        return emailUrl;
        //  return 'whatsapp://wa.me/$phone/?text=${Uri.parse(msg)}';
      }
      else{
        return emailUrl;
        //  return 'whatsapp://send?$phone=phone&text=$msg';
        //   return 'whatsapp://wa.me/$phone&text=$msg';
      }
    }
    await canLaunch(url())?launch(url()) :launch(url());
    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('there is no whats app in your device')));
  }