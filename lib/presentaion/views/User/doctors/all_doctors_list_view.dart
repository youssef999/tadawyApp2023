
import 'package:doctors_app/domain/models/ads.dart';
import 'package:doctors_app/domain/models/user.dart';
import 'package:doctors_app/presentaion/bloc/patient/patient_cubit.dart';
import 'package:doctors_app/presentaion/bloc/patient/patient_states.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Ads/ads_details_view.dart';
import 'doctor-details_view.dart';

class AllDoctorsView extends StatefulWidget {
  String cat2;

  AllDoctorsView(this.cat2, {super.key});

  @override
  State<AllDoctorsView> createState() => _AllDoctorsViewState();
}

class _AllDoctorsViewState extends State<AllDoctorsView> {
  @override
  Widget build(BuildContext context) {

    print("cat=="+widget.cat2.toString());
    return BlocProvider(
        create: (BuildContext context) => PatientCubit()
        ..getPriceCountry()
          ..getAllDoctors(widget.cat2)..getAllAds(),
        child: BlocConsumer<PatientCubit, PatientStates>(
            listener: (context, state) {
            //  PatientCubit cubit = PatientCubit.get(context);
              if(state is getAdsSuccessState){
                print ("SUCCESS");
              //  print(cubit.adsList2.length);
              }
            },
            builder: (context, state) {
              PatientCubit cubit = PatientCubit.get(context);
              return Scaffold(
                backgroundColor:  ColorsManager.primaryx,
                appBar: AppBar(
                  toolbarHeight: 6,
                  elevation: 0,
                  backgroundColor: ColorsManager.primary,
                ),
                body: Container(
                  color: ColorsManager.primaryx,
                  child: ListView(
                    children: [
                      if(widget.cat2=='طبيب')
                      Container(
                        color: ColorsManager.primary,
                        child: Column(
                          children: const [
                            SizedBox(
                              height: 20,
                            ),
                            Custom_Text(
                              text: ' قائمة الاطباء   ',
                              alignment: Alignment.center,
                              color: Colors.white,
                              fontSize: 25,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                     if(widget.cat2=='مستشفي')
                        Container(
                          color:ColorsManager.primary,
                          child: Column(
                            children: const [
                              SizedBox(
                                height: 20,
                              ),
                              Custom_Text(
                                text: ' المستشفيات   ',
                                alignment: Alignment.center,
                                color: Colors.white,
                                fontSize: 25,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      if(widget.cat2=='صيدلية')
                        Container(
                          color:ColorsManager.primary,
                          child: Column(
                            children: const [
                              SizedBox(height: 20,),
                              Custom_Text(
                                text: ' الصيدليات  ',
                                alignment: Alignment.center,
                                color: Colors.white,
                                fontSize: 25,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(
                        height: 10,
                      ),

                      AllDoctorsWidget(cubit.doctorList,cubit,cubit.countryPrice),
                    ],
                  ),
                ),
              );

            }));
  }
  Widget AllDoctorsWidget (List<DoctorModel> listApp,PatientCubit cubit,double price) {

    final box=GetStorage();
    String country= box.read('country')??'x';
    String currency= box.read('currency')??'x';
    print("COUNTRY");
    print(country);
    print("LIST LENGTH=="+listApp.length.toString());
//  List<DoctorModel>list=[];
    if(listApp.isNotEmpty){
      return SingleChildScrollView(
        child: Container(
          height:913110,
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
                              color: Colors.white),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [

                                    (listApp[index].doctor_image!.length>4)?
                                    SizedBox(
                                        height: 90,
                                        width: MediaQuery.of(context).size.width * 0.30,
                                        child: Image.network(
                                            listApp[index].doctor_image.toString())):
                                    SizedBox(
                                      height: 90,
                                      width: MediaQuery.of(context).size.width * 0.30,
                                      child:Image.asset('assets/images/doc.png'),
                                    ),

                                    const SizedBox(
                                      width: 16,
                                    ),

                                    SizedBox(
                                      // width: MediaQuery.of(context).size.width * 0.3,
                                      child: Column(
                                        children: [
                                          Custom_Text(
                                            text: listApp[index].doctor_name.toString(),
                                            color: ColorsManager.black,
                                            fontSize: 16,
                                            alignment: Alignment.center,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Custom_Text(
                                            text: listApp[index].doctor_cat.toString(),
                                            color: ColorsManager.primary,
                                            fontSize: 12,
                                            alignment: Alignment.center,
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
                                                text: 'سعر الكشف '.toString(),
                                                color: Colors.grey,
                                                fontSize: 14,
                                                alignment: Alignment.center,
                                              ),
                                              const SizedBox(
                                                width: 12,
                                              ),

                                              (widget.cat2=='طبيب')?
                                              Custom_Text(
                                                text: (double.parse(listApp[index].price!)/price).toStringAsFixed(1)+" " +currency,
                                                color: ColorsManager.primary,
                                                fontSize: 16,
                                                alignment: Alignment.center,
                                              ):SizedBox()
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
                          Get.to(DoctorDetailsView(listApp[index],price));
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    (index==0)?NewAdsWidget(
                        cubit.doctorList,cubit.adsList,cubit,0
                    ):SizedBox(height: 1,),

                    (index==2)?NewAdsWidget(
                        cubit.doctorList,  cubit.adsList,cubit,0
                    ):SizedBox(height: 1,),
                    (index==5)?NewAdsWidget(
                        cubit.doctorList,   cubit.adsList,cubit,0
                    ):SizedBox(height: 1,),

                  ],
                );
                // if(listApp[index].country==country){
                //
                // //  list.add(listApp[index]);
                //
                //   return Column(
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: InkWell(
                //           child: Container(
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(15),
                //                 color: Colors.white),
                //             child: Directionality(
                //               textDirection: TextDirection.rtl,
                //               child: Column(
                //                 children: [
                //                   const SizedBox(
                //                     height: 12,
                //                   ),
                //                   Row(
                //                     children: [
                //
                //                       (listApp[index].doctor_image!.length>4)?
                //                       SizedBox(
                //                           height: 90,
                //                           width: MediaQuery.of(context).size.width * 0.30,
                //                           child: Image.network(
                //                               listApp[index].doctor_image.toString())):
                //                           SizedBox(
                //                             height: 90,
                //                             width: MediaQuery.of(context).size.width * 0.30,
                //                             child:Image.asset('assets/images/doc.png'),
                //                           ),
                //
                //                       const SizedBox(
                //                         width: 16,
                //                       ),
                //
                //                       SizedBox(
                //                        // width: MediaQuery.of(context).size.width * 0.3,
                //                         child: Column(
                //                           children: [
                //                             Custom_Text(
                //                               text: listApp[index].doctor_name.toString(),
                //                               color: ColorsManager.black,
                //                               fontSize: 16,
                //                               alignment: Alignment.center,
                //                             ),
                //                             const SizedBox(
                //                               height: 10,
                //                             ),
                //                             Custom_Text(
                //                               text: listApp[index].doctor_cat.toString(),
                //                               color: ColorsManager.primary,
                //                               fontSize: 12,
                //                               alignment: Alignment.center,
                //                             ),
                //                             const SizedBox(
                //                               height: 10,
                //                             ),
                //                             Row(
                //                               children: [
                //                                 const SizedBox(
                //                                   width: 21,
                //                                 ),
                //                                 Custom_Text(
                //                                   text: 'سعر الكشف '.toString(),
                //                                   color: Colors.grey,
                //                                   fontSize: 14,
                //                                   alignment: Alignment.center,
                //                                 ),
                //                                 const SizedBox(
                //                                   width: 12,
                //                                 ),
                //
                //                                 Custom_Text(
                //
                //                                   text: (double.parse(listApp[index].price!)/price).toStringAsFixed(1)+" " +currency,
                //                                   color: ColorsManager.primary,
                //                                   fontSize: 16,
                //                                   alignment: Alignment.center,
                //                                 ),
                //                               ],
                //                             ),
                //                           ],
                //                         ),
                //                       ),
                //
                //
                //                     ],
                //                   ),
                //                   const SizedBox(
                //                     height: 12,
                //                   ),
                //
                //                 ],
                //               ),
                //             ),
                //           ),
                //           onTap: () {
                //             Get.to(DoctorDetailsView(listApp[index],price));
                //           },
                //         ),
                //       ),
                //       SizedBox(height: 10,),
                //       (index==0)?NewAdsWidget(
                //           cubit.doctorList,cubit.adsList,cubit,0
                //       ):SizedBox(height: 1,),
                //
                //       (index==2)?NewAdsWidget(
                //           cubit.doctorList,  cubit.adsList,cubit,0
                //       ):SizedBox(height: 1,),
                //       (index==5)?NewAdsWidget(
                //           cubit.doctorList,   cubit.adsList,cubit,0
                //       ):SizedBox(height: 1,),
                //
                //     ],
                //   );
                // }
                // // if(list.isEmpty){
                // //   return    Container(
                // //     color:Colors.white,
                // //     child:
                // //
                // //     Center(
                // //       child:
                // //
                // //       Column(
                // //         mainAxisAlignment:MainAxisAlignment.center,
                // //         crossAxisAlignment: CrossAxisAlignment.center,
                // //         children: [
                // //
                // //           SizedBox(
                // //             height:260,
                // //             child:Image.asset("assets/images/data.png"),
                // //           ),
                // //           const SizedBox(height: 11,),
                // //           const Custom_Text(
                // //             text: 'القسم لا يحتوي علي بيانات الان ',
                // //             fontSize: 22,
                // //             color:Colors.black,
                // //             alignment:Alignment.center,
                // //           ),
                // //           const SizedBox(height: 400,),
                // //
                // //         ],
                // //       ),
                // //     ),
                // //   );
                // // }
                // else{
                //   return const SizedBox(height: 2,);
                // }

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
}



Widget NewAdsWidget(List<DoctorModel>doc,List<Ads> listApp,PatientCubit cubit,int index2){

  print("start==="+listApp.length.toString());
  print("indes22==="+index2.toString());

  print('LENGTH');
  print(listApp.length);
  print(index2);
  if(index2>doc.length){
    index2==doc.length-1;
  }else{
   // index2=doc.length;
  }

  return Container(
    height:104,
    color: ColorsManager.primary,
    padding: const EdgeInsets.only(top: 9, left: 7, right: 7),
    child:
    ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 1,
        itemBuilder: (context, index) {

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorsManager.primary),
                  child: Column(
                    children: [

                      Row(
                        children: [
                          SizedBox(
                              height: 70,
                              width: MediaQuery.of(context).size.width * 0.38,
                              child: Image.network(
                                  listApp[index2].image.toString(),
                              fit:BoxFit.fill,
                              )),

                          const SizedBox(
                            width: 35,
                          ),

                          SizedBox(
                            // width: MediaQuery.of(context).size.width * 0.3,
                            child: Column(
                              children: [
                                Custom_Text(
                                  text: listApp[index2].name.toString(),
                                  color: ColorsManager.white,
                                  fontSize: 16,
                                  alignment: Alignment.center,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),


                        ],
                      ),

                    ],
                  ),
                ),
                onTap: () {
                  Get.to(AdDetailsView(
                    ad: listApp[index2],
                  ));
                },
              ),
            );


        }),
  );
}
