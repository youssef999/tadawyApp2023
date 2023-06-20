import 'package:doctors_app/presentaion/pay_mob/constants/const.dart';
import 'package:doctors_app/presentaion/views/Doctor/Home/dashboard.dart';
import 'package:doctors_app/presentaion/views/Doctor/doctor_ads/create_ad_view.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../resources/color_manager.dart';
import '../doctor_reg/register_view.dart';

class PaySuccessView extends StatelessWidget {
  int days,adsNum;
  String type,cat;
  bool free,sales;

  PaySuccessView({Key? key,required this.type,required this.cat,required this.adsNum,required this.days,
    required this.sales,required this.free}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: ColorsManager.primary,
        toolbarHeight: 12,
      ),
      body:Column(
        children: [
          SizedBox(height: 30,),
          Custom_Text(text: orderId,fontSize: 26,color: Colors.black,alignment:Alignment.center),
          SizedBox(height: 30,),
          CircleAvatar(
            radius: 90,
              backgroundColor: Colors.green,
              child: Icon(Icons.done_all_sharp,size: 50,color:Colors.white,)),
          SizedBox(height: 30,),

          Custom_Text(text: 'تمت العملية بنجاح',alignment:Alignment.center,
          fontSize: 24,color:Colors.black
          ),
          SizedBox(height: 30,),
          (cat=='reg')?
          CustomButton(text:'يمكنك انشاء الحساب الان ', onPressed: (){

            Get.to(RegisterView(
              sales: sales,
              adsNum: adsNum,
              days: days,
            ));

          }, color1: ColorsManager.primary, color2: Colors.white):SizedBox(height: 1,),

          (cat=='ads')?
          Column(
            children: [
              CustomButton(text:'اضف اعلانك الان ', onPressed: () {
                String t='';
                if(type.length<3){
                  t='doctor';
                }else{
                  t=type;
                }
                Get.to(CreateAdView(
                  days: days,
                  sales: sales,
                  numOfAds: adsNum,
                  free: false,
                  type: t,
                ));
              }, color1: ColorsManager.primary, color2: Colors.white),

              CustomButton(text:' لاحقا ', onPressed: (){

                print("TYPE=="+type);
                String t='';
                if(type.length<3){
                  t='doctor';
                }else{
                  t=type;
                }

                Get.to(DashBoardDoctorView(
                  type: t,
                ));
              }, color1: ColorsManager.primary, color2: Colors.white),
            ],
          ):SizedBox(height: 1,),

        ],
      ),
    );
  }
}
