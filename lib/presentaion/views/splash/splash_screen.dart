import 'dart:async';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/views/Country/countries_view.dart';
import 'package:doctors_app/presentaion/views/Doctor/Home/dashboard.dart';
import 'package:doctors_app/presentaion/views/Doctor/doctor_ads/create_ad_view.dart';
import 'package:doctors_app/presentaion/views/Doctor/doctor_reg/register_view.dart';
import 'package:doctors_app/presentaion/views/sales/sales_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../User/Home/dash_board.dart';




class SplashView extends StatefulWidget
{
  const SplashView({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}
class _MySplashScreenState extends State<SplashView>
{

  startTimer()
  {

    final box=GetStorage();
    String docId=box.read('doc_Id')??'x';
    // String docId=box.read('doc_Id');
    // String email=box.read('email');
    String userId=box.read('userId')??'x';
    String modId=box.read('mod_Id')??'x';
    String salesId=box.read('SalesId')??'x';
    String theme=box.read('Theme')??'x';
    String pay=box.read('pay')??'x';
    String payAds=box.read('payAds')??'x';


    if(theme=='blue'){
      ColorsManager.primary = Color(0xFFF0a19db);
      ColorsManager.primary4=Color(0xFFF00a1e6);
    }
    if(theme=='green'){
      ColorsManager.primary = Color(0xFFF21a300);
      ColorsManager.primary4=Color(0xFFF2ee600);
    }

    Timer(const Duration(seconds: 3), () async
    {
      if(modId !='x'){
        Get.offAll( DashBoardDoctorView (type: 'mod',));
      }

     else if(salesId !='x'){

        Get.offAll( SalesView ());

      }
      else if(docId !='x'){

        Get.offAll( DashBoardDoctorView (type: 'doctor',));

      }

      else if(userId!='x'){

        Get.offAll(const DashBoardFragment());

      }
      else{
        Get.offAll(const CountriesView());

      }

    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }
  
  @override
  Widget build(BuildContext context)
  {
    return
     Scaffold(

        appBar: AppBar(
          toolbarHeight: 10,
          backgroundColor:ColorsManager.primary,
        ),
        body:

        Container(
          color:    ColorsManager.primaryx,
          child:   Center(
            child: Container(
                color:ColorsManager.primaryx,
                height: 290, child:
            CircleAvatar(
               backgroundColor: ColorsManager.primary,
                radius: 120,
                child: Image.asset('assets/images/logo.png',fit:BoxFit.fill,))),
          ),
        )
    );
  }
}
