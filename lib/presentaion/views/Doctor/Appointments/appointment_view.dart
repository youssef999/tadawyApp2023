
import 'package:doctors_app/presentaion/bloc/tdawa/tdawa_cubit.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/appointments/full_appointments.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../domain/models/booking.dart';

 class AppointmentView extends StatefulWidget {
  List<Booking> listApp;
  TdawaCubit cubit;


  AppointmentView({super.key, required this.listApp,required this.cubit});

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  @override
  void initState() {
    widget.cubit.getPriceCountry();
    super.initState();
    // Initialize your state here
    // Perform any setup or initialization tasks
  }
   //  widget.cubit.getPriceCountry();
  @override
  Widget build(BuildContext context) {



    if(widget.listApp.isNotEmpty){
      return  Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          title:  const Custom_Text(text: 'الحجوزات  ',
            alignment:Alignment.center,
            color:Colors.white,
            fontSize:25,
          ),
          backgroundColor: ColorsManager.primary,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios,size: 21,color:ColorsManager.white,
          ),onPressed:(){
            Get.back();
          },),
        ),
        body:ListView(
          children: [

            const SizedBox(height: 10,),
            AppointmentWidget(),
          ],
        ),
      );
    }else{
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: ColorsManager.primary,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios,size: 21,color:ColorsManager.white,
          ),onPressed:(){
            Get.back();
          },),
        ),
        body:
        Container(
          color:Colors.white,
          child: Center(
            child:

            Column(
              mainAxisAlignment:MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(
                  height:260,
                  child:Image.asset("assets/images/data.png"),
                ),
                const SizedBox(height: 11,),
                const Custom_Text(
                  text: 'لا يوجد ججوزات الان  ',
                  fontSize: 22,
                  color:Colors.black,
                  alignment:Alignment.center,
                )

              ],
            ),
          ),
        ),
      );
    }

  }
}
