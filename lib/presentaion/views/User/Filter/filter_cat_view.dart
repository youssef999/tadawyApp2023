
import 'dart:convert';

import 'package:doctors_app/Data/api_connection/api_connection.dart';
import 'package:doctors_app/domain/models/filters.dart';
import 'package:doctors_app/presentaion/bloc/patient/patient_cubit.dart';
import 'package:doctors_app/presentaion/bloc/patient/patient_states.dart';
import 'package:doctors_app/presentaion/resources/assets_manager.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/views/User/Filter/search_filter.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../domain/models/places2.dart';
import 'Filter_doctors_view.dart';
import 'package:http/http.dart' as http;

import 'doctor_filter_cat.dart';

class FilterCatView extends StatefulWidget {

  const FilterCatView();

  @override
  State<FilterCatView> createState() => _PlacesViewState();
}

class _PlacesViewState extends State<FilterCatView> {
  @override

  List<String>images=['assets/images/cat.jpg','assets/images/cat2.jpg','assets/images/cat3.png','assets/images/cat4.jpg',
    'assets/images/cat5.jpg','assets/images/cat6.png',
   'assets/images/cat.jpg', 'assets/images/cat5.jpg','assets/images/cat3.png','assets/images/cat4.jpg',
        'assets/images/cat2.jpg','assets/images/cat6.png',
    'assets/images/cat3.png','assets/images/cat4.jpg',
    'assets/images/cat.jpg','assets/images/cat2.jpg','assets/images/cat3.png','assets/images/cat4.jpg',
    'assets/images/cat5.jpg','assets/images/cat6.png',
    'assets/images/cat.jpg', 'assets/images/cat5.jpg','assets/images/cat3.png','assets/images/cat4.jpg',
    'assets/images/cat3.png','assets/images/cat4.jpg',
    'assets/images/cat.jpg','assets/images/cat2.jpg','assets/images/cat3.png','assets/images/cat4.jpg',
    'assets/images/cat5.jpg','assets/images/cat6.png',
    'assets/images/cat3.png','assets/images/cat4.jpg',
    'assets/images/cat.jpg','assets/images/cat2.jpg','assets/images/cat3.png','assets/images/cat4.jpg',
    'assets/images/cat5.jpg','assets/images/cat6.png',
  ];

  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => PatientCubit()..getAllDoctorsFilter(),
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
                  color: ColorsManager.primary,
                  child: ListView(
                    children: [
                      Container(
                        color:ColorsManager.white,
                        child: Column(
                          children:  [
                            SizedBox(
                              height: 20,
                            ),
                          Container(
                            height: 200,
                            child:Image.asset(AssetsManager.Logo),
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
                      const SizedBox(
                        height: 10,
                      ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 6000,
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 22,
                              mainAxisSpacing:12
                            ),
                            itemCount:cubit.uniqueNames3.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                child: Container(
                                  decoration:BoxDecoration(
                                    borderRadius:BorderRadius.circular(13)
                                  ),
                                  child: Card(
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Container(
                                            height:110,
                                            child: Image.asset(images[index])),
                                        SizedBox(height: 13,),
                                        Center(child:
                                        Custom_Text(text: cubit.uniqueNames3.elementAt(index),fontSize: 16
                                          ,alignment: Alignment.center,color:ColorsManager.primary,)
                                        // Text(cubit.uniqueNames3.elementAt(index))),
                                        ),
                                      ],
                                    )),
                                ),
                                onTap:(){

                                 Get.to(FilterCatDoctorView(
                                   doctorCat:cubit.uniqueNames3.elementAt(index) ,
                                 ));

                                },
                              );
                            }
                        ),
                      ),
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


