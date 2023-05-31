
import 'package:doctors_app/domain/models/filters.dart';
import 'package:doctors_app/domain/models/places.dart';
import 'package:doctors_app/domain/models/places.dart';

import 'package:doctors_app/presentaion/bloc/patient/patient_cubit.dart';
import 'package:doctors_app/presentaion/bloc/patient/patient_states.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/resources/strings_manager.dart';
import 'package:doctors_app/presentaion/views/User/Filter/places_view.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'Doctors_fliters.dart';

 class FiltersView extends StatelessWidget {

  FiltersView ( {super.key});

  @override

  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => PatientCubit()..getAllPlaces(),
        child: BlocConsumer<PatientCubit, PatientStates>(

            listener: (context, state) {

            },

            builder: (context, state) {

              PatientCubit cubit = PatientCubit.get(context);

              return Scaffold(
                appBar: AppBar(
                  toolbarHeight: 6,
                  elevation: 0,
                  backgroundColor: ColorsManager.primary,
                ),
                body: Container(
                  color: Colors.grey[200],
                  child: ListView(
                    children: [

                      Container(
                        color:ColorsManager.primary,
                        child: Column(
                          children: const [
                            SizedBox(
                              height: 20,
                            ),
                            Custom_Text(
                              text:   AppStrings.APPNAME,
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
                      Column(
                        children: cubit.uniqueNames.map((place) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              child: Container(
                                height: 45,
                                child: Card(
                                  color: ColorsManager.primary,
                                child: Custom_Text(text: place,fontSize: 18,color:Colors.white,alignment:Alignment.center,)
                                 // subtitle: Text(place.description),
                                ),
                              ),
                              onTap:(){
                                Get.to(PlacesView(
                                           place:place
                                ));
                              },
                            ),
                          );
                        }).toList(),
                      ),
                  //  Places(cubit.uniqueData,cubit),
                    //  PlacesWidget(cubit.uniqueData,cubit),
                     // AllFiltersWidget(cubit.filterList,cubit),
                    ],
                  ),
                ),
              );

            }));
  }
}

  Widget AllFiltersWidget(List<Filter> listApp,PatientCubit cubit) {

  final box=GetStorage();
  String country= box.read('country')??'x';
  List<Filter>list=[];
  if(listApp.isNotEmpty){
    return SingleChildScrollView(
      child: Container(
        height:9130,
        color: Colors.grey[200],
        //width:double.infinity,
        padding: const EdgeInsets.only(top: 9, left: 7, right: 7),
        child:
        GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listApp.length,
            itemBuilder: (context, index) {

              if(listApp[index].country==country){
                list.add(listApp[index]);

                return Padding(
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
                         Column(
                              children: [
                                SizedBox(
                                    height: 90,
                                    width: MediaQuery.of(context).size.width * 0.35,
                                    child: Image.network(
                                        listApp[index].image.toString())),

                                const SizedBox(
                              height: 23,
                                ),

                                SizedBox(
                                  // width: MediaQuery.of(context).size.width * 0.3,
                                  child:

                                  Column(
                                    children: [
                                      Custom_Text(
                                        text: listApp[index].name.toString(),
                                        color: ColorsManager.black,
                                        fontSize: 14,
                                        alignment: Alignment.center,
                                      ),
                                      const SizedBox(
                                        height: 5,
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

                      Get.to(FilterDoctorsView(
                        cat: listApp[index].name,
                        cat2:listApp[index].cat2.toString(),
                        place2: listApp[index].place2.toString(),
                      ));
                    },
                  ),
                );
              }
              if(list.isEmpty){
                return    Container(
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
              else{
                return const SizedBox(height: 2,);
              }
            },        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 230,
            childAspectRatio: 1.8 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20),),
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



  // Widget PlacesWidget(Set<Places> listApp,PatientCubit cubit){
  //
  //   if(listApp.isNotEmpty) {
  //     return SingleChildScrollView(
  //       child: Container(
  //         height: 9130,
  //         color: Colors.grey[200],
  //         padding: const EdgeInsets.only(top: 9, left: 7, right: 7),
  //         child:
  //         GridView.builder(
  //           physics: const NeverScrollableScrollPhysics(),
  //           itemCount: listApp.length,
  //           itemBuilder: (context, index) {
  //             return Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: InkWell(
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(15),
  //                       color: ColorsManager.primary),
  //                   child: Directionality(
  //                     textDirection: TextDirection.rtl,
  //                     child: Column(
  //                       children: [
  //                         const SizedBox(
  //                           height: 12,
  //                         ),
  //                         Column(
  //                           children: [
  //
  //
  //                             const SizedBox(
  //                               height: 23,
  //                             ),
  //
  //                             SizedBox(
  //                               // width: MediaQuery.of(context).size.width * 0.3,
  //                               child:
  //
  //                               Column(
  //                                 children: [
  //                                   Custom_Text(
  //                                     text: listApp[index].name.toString(),
  //                                     color: ColorsManager.white,
  //                                     fontSize: 26,
  //                                     alignment: Alignment.center,
  //                                   ),
  //                                   const SizedBox(
  //                                     height: 10,
  //                                   ),
  //
  //
  //                                 ],
  //                               ),
  //                             ),
  //
  //
  //                           ],
  //                         ),
  //                         const SizedBox(
  //                           height: 12,
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 onTap: () {
  //                   Get.to(PlacesView(
  //                     place: listApp[index].name.toString(),
  //                   ));
  //                 },
  //               ),
  //             );
  //           },
  //           gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
  //             maxCrossAxisExtent: 230,
  //             childAspectRatio: 3.5 / 2,
  //             crossAxisSpacing: 10,
  //             mainAxisSpacing: 20),
  //
  //         ),
  //       ),
  //     );
  //   }else{
  //
  //     return    Container(
  //       color:Colors.white,
  //       child:
  //
  //       Center(
  //         child:
  //
  //         Column(
  //           mainAxisAlignment:MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //
  //             SizedBox(
  //               height:260,
  //               child:Image.asset("assets/images/data.png"),
  //             ),
  //             const SizedBox(height: 11,),
  //             const Custom_Text(
  //               text: 'القسم لا يحتوي علي بيانات الان ',
  //               fontSize: 22,
  //               color:Colors.black,
  //               alignment:Alignment.center,
  //             ),
  //             const SizedBox(height: 400,),
  //
  //           ],
  //         ),
  //       ),
  //     );
  //
  //   }
  // }

  // Widget Places(Set <Places> uniqueData,PatientCubit cubit){
  //  print("widget place");
  //  print(uniqueData);
  //  return Column(
  //    children: uniqueData.map((data) {
  //      return Text(data,style:TextStyle(fontSize: 21,color:Colors.black),);
  //    }).toList(),
  //  );
  // }
