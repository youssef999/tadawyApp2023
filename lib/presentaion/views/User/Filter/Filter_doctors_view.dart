
import 'package:doctors_app/domain/models/filters.dart';
import 'package:doctors_app/domain/models/places.dart';
import 'package:doctors_app/domain/models/user.dart';
import 'package:doctors_app/presentaion/bloc/patient/patient_cubit.dart';
import 'package:doctors_app/presentaion/bloc/patient/patient_states.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/resources/strings_manager.dart';
import 'package:doctors_app/presentaion/views/User/Filter/places_view.dart';
import 'package:doctors_app/presentaion/views/User/doctors/doctor-details_view.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'Doctors_fliters.dart';

class FiltersDoctorView extends StatelessWidget {

String place2;


FiltersDoctorView({required this.place2});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (BuildContext context) => PatientCubit()..getAllFilters(place2),
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
                              text:  AppStrings.APPNAME,
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

                       AllFiltersWidget(cubit.filterList,cubit,place2),
                    ],
                  ),
                ),
              );

            }));
  }
}

Widget AllFiltersWidget(List<DoctorModel> listApp,PatientCubit cubit,String place2) {

  final box=GetStorage();
  String country= box.read('country')??'x';
  List<DoctorModel>list=[];
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

            if(listApp[index].country==country&&listApp[index].place2==place2){
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
                            height: 10,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width * 0.55,
                                  child: Image.network(
                                      listApp[index].doctor_image.toString(),
                                 // fit:BoxFit.fill,
                                  )),

                              const SizedBox(
                                height: 5,
                              ),

                              SizedBox(
                                // width: MediaQuery.of(context).size.width * 0.3,
                                child:

                                Column(
                                  children: [
                                    Custom_Text(
                                      text: listApp[index].doctor_name.toString(),
                                      color: ColorsManager.black,
                                      fontSize: 20,
                                      alignment: Alignment.center,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Custom_Text(
                                      text: listApp[index].doctor_cat.toString(),
                                      color: ColorsManager.primary,
                                      fontSize: 20,
                                      alignment: Alignment.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {

                    Get.to(DoctorDetailsView(
                        listApp[index]
                    ));

                    // Get.to(FilterDoctorsView(
                    //   cat: listApp[index].doctor_name!,
                    //   cat2:listApp[index].cat2.toString(),
                    //   place2: listApp[index].place2.toString(),
                    // ));
                  },
                ),
              );
            }
           else if(list.isEmpty){
              return const SizedBox(height: 2,);
              // return    Container(
              //   color:Colors.white,
              //   child:
              //
              //   Center(
              //     child:
              //
              //     Column(
              //       mainAxisAlignment:MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //
              //         SizedBox(
              //           height:260,
              //           child:Image.asset("assets/images/data.png"),
              //         ),
              //         const SizedBox(height: 11,),
              //         const Custom_Text(
              //           text: 'القسم لا يحتوي علي بيانات الان ',
              //           fontSize: 22,
              //           color:Colors.black,
              //           alignment:Alignment.center,
              //         ),
              //         const SizedBox(height: 400,),
              //
              //       ],
              //     ),
              //   ),
              // );
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
    return const SizedBox(height: 2,);
    // return     Container(
    //   color:Colors.white,
    //   child:
    //
    //   Center(
    //     child:
    //
    //     Column(
    //       mainAxisAlignment:MainAxisAlignment.center,
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //
    //         SizedBox(
    //           height:260,
    //           child:Image.asset("assets/images/data.png"),
    //         ),
    //         const SizedBox(height: 11,),
    //         const Custom_Text(
    //           text: 'القسم لا يحتوي علي بيانات الان ',
    //           fontSize: 22,
    //           color:Colors.black,
    //           alignment:Alignment.center,
    //         ),
    //         const SizedBox(height: 400,),
    //
    //       ],
    //     ),
    //   ),
    // );
  }

}

