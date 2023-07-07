
import 'package:doctors_app/domain/models/baka.dart';
import 'package:doctors_app/presentaion/bloc/tdawa/tdawa_cubit.dart';
import 'package:doctors_app/presentaion/bloc/tdawa/tdawa_states.dart';
import 'package:doctors_app/presentaion/const/app_message.dart';
import 'package:doctors_app/presentaion/pay_mob/modules/payment/doctor_sub_payment/easy_data_view.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/views/Doctor/doctor_reg/register_view.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../resources/assets_manager.dart';


  class BakaView extends StatelessWidget {

  bool sales;
  String type;
  BakaView({required this.sales,required this.type,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create:(BuildContext context)=>TdawaCubit()..getPriceCountry()..getBakaSub(),
        child: BlocConsumer<TdawaCubit,TdawaStates>(
            listener:(context,state){
            },
            builder:(context,state){
              TdawaCubit tdawaCubit = TdawaCubit.get(context);
              return Scaffold(
                backgroundColor:Colors.white,
                appBar:AppBar(
                  elevation: 0,
                  backgroundColor:ColorsManager.primary,
                  toolbarHeight: 5,
                ),
                body:Directionality(
                  textDirection: TextDirection.rtl,
                  child: ListView(
                    children: [
                      const SizedBox(height: 20,),
                      SizedBox(
                        height: 120,
                        child:Image.asset(AssetsManager.Logo),
                      ),
                      const SizedBox(height: 20,),
                      const Custom_Text(
                        text: 'تداوي بلس',
                        alignment:Alignment.center,
                        fontSize:22,
                        color:Colors.black,
                      ),
                      const SizedBox(height: 20,),
                      const Custom_Text(text: 'أشترك في طبيبي بلس و أحصل علي مميزات أكتر',
                        alignment: Alignment.center,
                        fontSize:16,
                        color:Colors.black,
                      ),

                      const SizedBox(height: 23,),

                      const Padding(
                        padding: EdgeInsets.only(right:15.0,top:15),
                        child: Custom_Text(text: ' حدد الباقة التي تناسبك',
                          alignment: Alignment.topRight,
                          fontSize:16,
                          color:Colors.black,
                        ),
                      ),
                      const SizedBox(height: 23,),
                      BakaSubWidget(bakaList: tdawaCubit.bakaSubList,sales:sales,type: type,price:tdawaCubit.countryPrice)

                    ],
                  ),
                ),
              );
            }

        )
    );
  }
}




 class BakaSubWidget extends StatelessWidget {

  List<BakaSub> bakaList;
  bool sales;
  String type;
double price;
  BakaSubWidget({required this.bakaList,
    required this.price,
    required this.type,required this.sales});

  @override
  Widget build(BuildContext context) {
    final box=GetStorage();
    String currency=box.read('currency');


    return  Container(
      height: 630,

      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          // physics: const NeverScrollableScrollPhysics(),
          itemCount: bakaList.length,
          itemBuilder: (context, index) {
            return
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width:MediaQuery.of(context).size.width*0.43,
                  decoration:BoxDecoration(
                      borderRadius:BorderRadius.circular(20),
                      color:ColorsManager.white
                  ),
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 10,),
                          Custom_Text(text: bakaList[index].name.toString(),
                            fontSize:19,
                            color:Colors.black,
                            alignment:Alignment.center,
                          ),
                          const SizedBox(height: 50,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Custom_Text(text: bakaList[index].details.toString(),
                              fontSize:19,
                              color:Colors.black,
                              alignment:Alignment.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Custom_Text(text: bakaList[index].des.toString(),
                              fontSize:14,
                              color:ColorsManager.primary,
                              alignment:Alignment.center,
                            ),
                          ),
                          const SizedBox(height: 60,),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Custom_Text(text: 'سعر الباقة',
                              fontSize:17,
                              color:Colors.black,
                              alignment:Alignment.center,
                            ),
                          ),
                          Card(
                            color:ColorsManager.primary,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Custom_Text(
                                text: (bakaList[index].price/price).toStringAsFixed(2)+" " +currency,
                                fontSize:18,
                                color:Colors.white,
                                alignment:Alignment.center,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30,),
                          const Divider(
                            color:Colors.grey,
                            height: 6,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(right: 20.0,top:20),
                            child: Column(
                              children: [
                                const Custom_Text(text: 'مميزات الباقة : ',
                                  color:Colors.black,
                                  alignment:Alignment.topRight,
                                  fontSize:20,
                                ),
                                const SizedBox(height: 10,),
                                Container(
                                  height: 90,
                                  child: Custom_Text(text:bakaList[index].adv,
                                    color:ColorsManager.primary,
                                    alignment:Alignment.topRight,
                                    fontSize:14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30,),
                          CustomButton(
                            text: 'اختار الباقة',
                            color1:ColorsManager.primary,
                            color2:Colors.white,
                            onPressed:(){
                              if(sales==true){

                                if(bakaList[index].price<1.0){

                                  appMessage(text: 'الطبيب فقط من يستطيع التسجيل في الباقة المجانية ');
                                }

                                else{
                                  Get.to(
                                      RegisterView(sales: true,
                                        adsNum:bakaList[index].freeAds,
                                        days:bakaList[index].days ,
                                      )
                                  );
                                }

                                // Get.to( CreateAdView(
                                //   days: bakaList[index].days,
                                //   numOfAds: bakaList[index].freeAds,
                                //   free: false,
                                //   sales: true,
                                //   // sales:sales, free: null,
                                // ));
                              }
                              else{
                                if(bakaList[index].price<1.0){
                                  Get.to(RegisterView(
                                    sales: sales,
                                    adsNum:bakaList[index].freeAds,
                                    days: bakaList[index].days,
                                  ));
                                }
                                else{
                                  Get.to(EasyDataView(
                                    price:(bakaList[index].price*100).toString() ,
                                    ads: false,
                                    paid: false,
                                    type: type,
                                    days: bakaList[index].days,
                                    adsNum: bakaList[index].freeAds,
                                    freeAds: 0,
                                  )
                                  );
                                }

                              }



                              // Get.to( CreateAdView(
                              //     days: bakaList[index].days,
                              //     sales:sales
                              // ));
                            },
                          )
                        ],
                      ),
                    ),
                    onTap:() {
                      // Get.to(EasyDataView(
                      //   price:bakaList[index].price.toString() ,
                      // ));


                    },
                  ),
                ),
              );
          }),
    );
  }
}

