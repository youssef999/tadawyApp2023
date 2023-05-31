import 'dart:convert';

import 'package:doctors_app/Data/api_connection/api_connection.dart';
import 'package:doctors_app/domain/models/ap.dart';
import 'package:doctors_app/presentaion/bloc/tdawa/tdawa_cubit.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/views/Doctor/Home/dashboard.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../domain/models/booking.dart';
import '../../bloc/tdawa/tdawa_states.dart';
import '../../const/app_message.dart';


class AppointmentWidget extends StatefulWidget {

  // List<Booking> listApp;
  // TdawaCubit cubit;
  //
  // AppointmentWidget(this.listApp,this.cubit, {Key? key}) : super(key: key);

  @override
  State<AppointmentWidget> createState() => _AppointmentWidgetState();
}

class _AppointmentWidgetState extends State<AppointmentWidget> {

  bool press=false;
  String pressed='';
  @override
  Widget build(BuildContext context) {


    return BlocProvider(
        create: (BuildContext context) => TdawaCubit()..getDocotorBoking(),
    child: BlocConsumer<TdawaCubit, TdawaStates>(
    listener: (context, state) {

    },
    builder: (context, state) {
    TdawaCubit tdawaCubit = TdawaCubit.get(context);

    return  SingleChildScrollView(
      child: Container(
        height: 12230,
        color:Colors.grey[100],
        //width:double.infinity,
        padding:const EdgeInsets.only(top:9,left:7,right:7),
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tdawaCubit.listAppointments.length,
            itemBuilder: (context, index) {
              return
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Container(
                      decoration:BoxDecoration(
                          borderRadius:BorderRadius.circular(15),
                          color:Colors.white70
                      ),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Column(
                          children: [
                            const SizedBox(height: 5,),
                            Row(
                              children: [
                                SizedBox(
                                    height: 60,
                                    child: Image.asset('assets/images/person.png')),

                                const SizedBox(width:100,),
                                Custom_Text(text:tdawaCubit.listAppointments[index].date!.toString().replaceAll('00:00:00.000','')
                                  ,color:ColorsManager.primary,
                                  fontSize:16,alignment:Alignment.center,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              children: [
                                const SizedBox(width: 100,),
                                Custom_Text(text:    tdawaCubit.listAppointments[index].name.toString(),color:Colors.black,
                                  fontSize:16,alignment:Alignment.center,
                                ),
                                const SizedBox(width: 40,),
                                Column(
                                  children: [
                                    Custom_Text(text:      'اليوم ',color:Colors.black,
                                      fontSize:20,alignment:Alignment.center,
                                    ),
                                    const SizedBox(height: 10,),
                                    Custom_Text(text:     tdawaCubit.listAppointments[index].day.toString(),color:Colors.grey,
                                      fontSize:16,alignment:Alignment.center,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10,),

                            const SizedBox(height: 10,),
                            Row(
                              children: [
                                const SizedBox(width: 30,),
                                Custom_Text(text:      'رقم الهاتف',color:ColorsManager.primary,
                                  fontSize:14,alignment:Alignment.center,
                                ),
                                const SizedBox(width: 30,),
                                Custom_Text(text:     tdawaCubit.listAppointments[index].phone.toString(),color:ColorsManager.primary,
                                  fontSize:14,alignment:Alignment.center,
                                ),
                              ],
                            ),

                            const SizedBox(height: 10,),


                            Custom_Text(text:tdawaCubit.listAppointments[index].status.toString(),color:Colors.red,
                              fontSize:21,alignment:Alignment.center,
                            ),


                            const SizedBox(height: 10,),
                            (tdawaCubit.listAppointments[index].status=='بانتظار الموافقة' && press==false)?
                            Row(
                              children: [
                                const SizedBox(width: 10),
                                CustomButton(text: 'موافقة', onPressed: (){


                                  tdawaCubit.changeBookingStatus(tdawaCubit.listAppointments[index].id.toString(),'تمت الموافقة');

                                  tdawaCubit.
                                  sendNotificationToUserNow(
                                      deviceRegistrationToken:tdawaCubit.listAppointments[index].token.toString(),
                                      userId: tdawaCubit.listAppointments[index].user_id.toString()
                                      , status: 'تمت الموافقة');

                                }, color1:ColorsManager.primary, color2: Colors.white),

                                const SizedBox (width: 11,),

                                CustomButton(text: 'رفض', onPressed: (){
                                  tdawaCubit.changeBookingStatus(tdawaCubit.listAppointments[index].id.toString(),' مرفوضة ');
                                  tdawaCubit.
                                  sendNotificationToUserNow(
                                      deviceRegistrationToken:tdawaCubit.listAppointments[index].token.toString(),
                                      userId: tdawaCubit.listAppointments[index].user_id.toString()
                                      , status: 'تم رفض عملية الحجز ');

                                }, color1:Colors.red, color2: Colors.white),
                              ],
                            ):SizedBox(),
                            const SizedBox(height: 20,),
                          ],
                        ),
                      ),
                    ),
                    onTap:(){

                    },
                  ),
                );
            }),
      ),
    );
    }));
  }
}




