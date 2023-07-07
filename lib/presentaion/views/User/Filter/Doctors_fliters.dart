
import 'package:doctors_app/domain/models/user.dart';
import 'package:doctors_app/presentaion/bloc/patient/patient_cubit.dart';
import 'package:doctors_app/presentaion/bloc/patient/patient_states.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../doctors/doctor-details_view.dart';

 class FilterDoctorsView extends StatelessWidget {

   String cat2;
  String cat;
  String place2;

   FilterDoctorsView({required this.cat2,required this.cat,required this.place2});


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (BuildContext context) => PatientCubit()..getPriceCountry()..getAllDoctors(cat2),
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

                      if(cat2=='doctor')
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
                      if(cat2=='hospital')
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
                      if(cat2=='pharmacy')
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
                      AllDoctorsWidget(cubit.doctorList,cubit,cat,place2),
                    ],
                  ),
                ),
              );

            }));
  }
}

Widget AllDoctorsWidget(List<DoctorModel> listApp,PatientCubit cubit,String cat,String place2) {

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
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listApp.length,
            itemBuilder: (context, index) {
              if(listApp[index].country==country
                  && listApp[index].doctor_cat==cat&&listApp[index].place2==place2){
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
                            Row(
                              children: [
                                SizedBox(
                                    height: 90,
                                    width: MediaQuery.of(context).size.width * 0.35,
                                    child: Image.network(
                                        listApp[index].doctor_image.toString())),

                                const SizedBox(
                                  width: 23,
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
                                        fontSize: 16,
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
                                          Custom_Text(
                                            text: listApp[index].price.toString(),
                                            color: ColorsManager.primary,
                                            fontSize: 16,
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
                      Get.to(DoctorDetailsView(listApp[index],cubit.countryPrice));
                    },
                  ),
                );
              }
              if(list.isEmpty){
               return const SizedBox(height: 2,);

              }
              else{
                return const SizedBox(height: 2,);

              }

            }),
      ),
    );
  }

  else{
    return SizedBox();

    //   Container(
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
