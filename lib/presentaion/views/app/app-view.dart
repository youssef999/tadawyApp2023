import 'dart:io';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/views/Country/change_country.dart';
import 'package:doctors_app/presentaion/views/app/send_email_view.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../resources/assets_manager.dart';


 class AppView extends StatelessWidget {

  String type;

  AppView({required this.type});

  @override
  Widget build(BuildContext context) {

    final box=GetStorage();

    String c=box.read('country');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.primary,
        toolbarHeight: 2,
      ),
      body:ListView(
        children: [
          SizedBox(height: 3,),
          Container(
            height: 170,
            child:Image.asset(AssetsManager.Logo),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(right:45.0,left: 5),
            child: Column(
              children: [
                InkWell(
                  child: Column(
                    children: [
                      SizedBox(width: 10,),

                      Row(
                        children: [
                          Icon(Icons.language,size:33,color:Colors.blue[400],),
                          SizedBox(width: 20,),
                          Custom_Text(text: 'الدولة',color:Colors.black,fontSize: 22,alignment:Alignment.topRight,),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(right: 34.0),
                        child: Custom_Text(text: c,color:Colors.black,fontSize: 23,alignment:Alignment.topRight,),
                      ),

                    ],
                  ),
                  onTap:(){
                    if(type!='doctor'){
                      Get.to(ChangeCountry());
                    }else{
                      //appMessage(text: '');
                    }

                  },
                ),
                SizedBox(height: 40,),
                Divider(height: 1,),
                SizedBox(height: 40,),

                InkWell(
                  child: Row(
                    children: [
                      SizedBox(width: 10,),
                      Icon(Icons.email,size:33,color:Colors.blue[400],),
                      SizedBox(width: 30,),
                      Custom_Text(text: 'ارسل لنا ',color:Colors.black,fontSize: 22,alignment:Alignment.topRight,),
                      SizedBox(width: MediaQuery.of(context).size.width*0.36,),
                      SizedBox(width:14,),
                      Icon(Icons.arrow_forward_ios,size: 21,color:Colors.blue[400],)
                    ],
                  ),
                  onTap:(){
                    Get.to(SendEmailView());
                  //  sendEmail('info@tadawiapp.com');
                  },
                ),

                SizedBox(height: 40,),
                Divider(height: 1,),
                SizedBox(height: 40,),

                InkWell(
                  child: Row(
                    children: [
                      SizedBox(width: 10,),
                      Icon(Icons.phone,size:33,color:Colors.blue[400],),
                      SizedBox(width: 30,),
                      Custom_Text(text: 'اتصل بنا',color:Colors.black,fontSize: 22,alignment:Alignment.topRight,),
                      SizedBox(width: MediaQuery.of(context).size.width*0.36,),
                      SizedBox(width:14,),
                      Icon(Icons.arrow_forward_ios,size: 21,color:Colors.blue[400],)
                    ],
                  ),
                  onTap:(){
                    sendWhatsApp('+2010200163336','');
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

 sendWhatsApp(String phone,String msg)async{

   String url(){
     if(Platform.isAndroid){
       return 'whatsapp://send?phone=$phone&text=$msg';
       //  return 'whatsapp://wa.me/$phone/?text=${Uri.parse(msg)}';
     }
     else{
       return 'whatsapp://send?phone=$phone&text=$msg';
       //  return 'whatsapp://send?$phone=phone&text=$msg';
       //   return 'whatsapp://wa.me/$phone&text=$msg';
     }
   }
   await canLaunch(url())?launch(url()) :launch(url());
   //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('there is no whats app in your device')));
 }

