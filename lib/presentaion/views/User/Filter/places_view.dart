
import 'dart:convert';

import 'package:doctors_app/Data/api_connection/api_connection.dart';
import 'package:doctors_app/domain/models/filters.dart';
import 'package:doctors_app/presentaion/bloc/patient/patient_cubit.dart';
import 'package:doctors_app/presentaion/bloc/patient/patient_states.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/views/User/Filter/search_filter.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../domain/models/places2.dart';
import '../../../resources/strings_manager.dart';
import 'Filter_doctors_view.dart';
import 'package:http/http.dart' as http;

class PlacesView extends StatefulWidget {

String place;


PlacesView({required this.place});

  @override
  State<PlacesView> createState() => _PlacesViewState();
}

 class _PlacesViewState extends State<PlacesView> {
 @override

   Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => PatientCubit()..getAllPlaces2(widget.place),
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
                              text: AppStrings.APPNAME,
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
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:12.0,right: 20),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:BorderRadius.circular(17),
                              color: Colors.white
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left:20.0,right: 20),
                            child: Row(
                              children: [
                                Container(
                                  width:MediaQuery.of(context).size.width*0.66,
                                  child: TextFormField(
                                    controller: cubit.searchController,
                                    decoration: InputDecoration(
                                      hintText: 'ادخل منطقتك  ',
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20,),
                                InkWell(child: const Icon(Icons.search,color:ColorsManager.black,size:33),
                                  onTap:(){
                                    Get.to( SearchFilter(

                                      txt: cubit.searchController.text,
                                    ));
                                  },
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: cubit.uniqueNames2.map((place) {
                          return Padding(
                            padding: const EdgeInsets.all(11.0),
                            child: InkWell(
                              child: Container(
                                height: 45,
                                width: 370,
                                child: Card(
                                    color: ColorsManager.primary,
                                    child: Custom_Text(text: place,fontSize: 15,color:Colors.white,alignment:Alignment.center,)
                                  // subtitle: Text(place.description),
                                ),
                              ),
                              onTap:(){
                                Get.to(FiltersDoctorView(
                                  place2:  place
                                ));
                              },
                            ),
                          );
                        }).toList(),
                      ),
                     // PlacesWidget(cubit.placesList2,cubit),
                      // AllFiltersWidget(cubit.filterList,cubit),
                    ],
                  ),
                ),
              );

            }));
  }
}


 Widget PlacesWidget(List<Places2> listApp,PatientCubit cubit){

  if(listApp.isNotEmpty) {
    return SingleChildScrollView(
      child: Container(
        height: 9130,
        color: Colors.grey[200],
        padding: const EdgeInsets.only(top: 9, left: 7, right: 7),
        child:
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listApp.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorsManager.primary),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Column(
                          children: [


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
                                    color: ColorsManager.white,
                                    fontSize: 26,
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
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Get.to(FiltersDoctorView(
                    place2:  listApp[index].name.toString(),
                  ));
                },
              ),
            );
          },
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 230,
            childAspectRatio: 3.2 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20),

        ),
      ),
    );
  }else{

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
}
