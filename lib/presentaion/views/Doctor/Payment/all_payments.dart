import 'package:doctors_app/domain/models/pay.dart';
import 'package:doctors_app/presentaion/bloc/tdawa/tdawa_states.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../bloc/tdawa/tdawa_cubit.dart';


 class AllPaymentsView extends StatelessWidget {

  const AllPaymentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => TdawaCubit()..getDocotorPayments(),
        child: BlocConsumer<TdawaCubit, TdawaStates>(
            listener: (context, state) {},
            builder: (context, state) {

              TdawaCubit cubit = TdawaCubit.get(context);

              return Scaffold(
                appBar: AppBar(
                  backgroundColor: ColorsManager.primary,
                  toolbarHeight: 50,
                  title: Custom_Text(text: 'عمليات الدفع',fontSize: 23,color:Colors.white,alignment:Alignment.center),
                  leading: IconButton(
                    onPressed: () {},
                    icon: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back_ios,
                          size: 24, color: Colors.white),
                    ),
                  ),
                ),
                body:ListView(
                  children: [
                    SizedBox(height: 22,),
                    AllDoctorPayments(cubit.payList, cubit)
                  ],
                ),
              );
            }));
  }
}
Widget AllDoctorPayments(List<Pay> listApp,TdawaCubit cubit) {


  if(listApp.isNotEmpty){
    return SingleChildScrollView(
      child: Container(
        height:91300,
        color: ColorsManager.primaryx,
        //width:double.infinity,
        padding: const EdgeInsets.only(top: 9, left: 7, right: 7),
        child:
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listApp.length,
            itemBuilder: (context, index) {

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [

                                  const SizedBox(
                                    width: 23,
                                  ),

                                  SizedBox(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Custom_Text(
                                              text: 'الرقم التعريفي للطلب : ',
                                              color: ColorsManager.black,
                                              fontSize: 18,
                                              alignment: Alignment.center,
                                            ),
                                            Custom_Text(
                                              text: listApp[index].order_id.toString(),
                                              color: ColorsManager.white,
                                              fontSize: 17,
                                              alignment: Alignment.center,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Custom_Text(
                                              text:'الاجمالي :',
                                              color: ColorsManager.black,
                                              fontSize: 18,
                                              alignment: Alignment.center,
                                            ),
                                            Custom_Text(
                                              text: listApp[index].total.toString(),
                                              color: ColorsManager.white,
                                              fontSize: 17,
                                              alignment: Alignment.center,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 21,
                                            ),
                                            Custom_Text(
                                              text: 'حالة العملية : '.toString(),
                                              color: Colors.black,
                                              fontSize: 18,
                                              alignment: Alignment.center,
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Custom_Text(
                                              text: listApp[index].status.toString(),
                                              color: ColorsManager.white,
                                              fontSize: 17,
                                              alignment: Alignment.center,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),


                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),

                            ],
                          ),
                        ),
                      ),
                      onTap: () {

                      },
                    ),
                  ),
                  SizedBox(height: 10,),


                ],
              );


            }),
      ),
    );
  }

  else{
    return     Container(
      color:Colors.white,
      child:

      Center(
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
              text: 'القسم لا يحتوي علي بيانات الان ',
              fontSize: 22,
              color:Colors.black,
              alignment:Alignment.center,
            ),
            const SizedBox(height: 400,),

          ],
        ),
      ),
    );
  }

}