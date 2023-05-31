

 import 'package:doctors_app/domain/models/ap.dart';
import 'package:doctors_app/presentaion/bloc/tdawa/tdawa_cubit.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/appointments/full_appointments.dart';
import 'package:flutter/material.dart';

import '../../../../domain/models/booking.dart';

 class AppointmentView extends StatelessWidget {
  List<Booking> listApp;
  TdawaCubit cubit;


  AppointmentView({super.key, required this.listApp,required this.cubit});

  @override
  Widget build(BuildContext context) {

    if(listApp.isNotEmpty){
      return  Scaffold(
        appBar:AppBar(
          toolbarHeight: 6,
          elevation: 0,
          backgroundColor:ColorsManager.primary,
        ),
        body:ListView(
          children: [
            Container(
              height: 60,
              decoration:BoxDecoration(
                borderRadius:BorderRadius.circular(5),
                color:ColorsManager.primary
              ),
              child: const Custom_Text(text: 'الحجوزات  ',
                alignment:Alignment.center,
                color:Colors.white,
                fontSize:25,
              ),
            ),
            const SizedBox(height: 10,),
            AppointmentWidget(),
          ],
        ),
      );
    }else{
      return Scaffold(
        appBar:AppBar(
          toolbarHeight: 4,
          backgroundColor:ColorsManager.primary,
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
