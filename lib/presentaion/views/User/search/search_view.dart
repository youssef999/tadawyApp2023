import 'package:doctors_app/domain/models/user.dart';
import 'package:doctors_app/presentaion/bloc/patient/patient_cubit.dart';
import 'package:doctors_app/presentaion/bloc/patient/patient_states.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/views/User/doctors/doctor-details_view.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'no_data_view.dart';


  class SearchView extends StatefulWidget {

     TextEditingController name;
     SearchView({required this.name});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController = widget.name;
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (BuildContext context) => PatientCubit()..searchData(widget.name.text),
        child: BlocConsumer<PatientCubit, PatientStates>(

        listener: (context, state) {

          if(state is SearchErrorState) {

            Get.off(const NoDataView());

          }
    },

    builder: (context, state) {

    PatientCubit cubit = PatientCubit.get(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorsManager.primary,
          toolbarHeight: 6,
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            showSearchBarWidget(searchController),
            const SizedBox(
              height: 20,
            ),
            SearchDataWidget(cubit.searchList,cubit)
          ],
        ));
    }));
  }
}

Widget SearchDataWidget(List<DoctorModel> listApp,PatientCubit cubit) {

  final box=GetStorage();
  String country= box.read('country')??'x';
  return SingleChildScrollView(
    child: Container(
      height: 5030,
      color: Colors.grey[200],
      //width:double.infinity,
      padding: const EdgeInsets.only(top: 9, left: 7, right: 7),
      child:
      ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listApp.length,
          itemBuilder: (context, index) {
  if(listApp[index].country==country) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white70),
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
                        height: 80,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.3,
                        child: Image.network(
                            listApp[index].doctor_image.toString())),

                    const SizedBox(
                      width: 30,
                    ),

                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.3,
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

                    SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.1),

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
          Get.to(DoctorDetailsView(listApp[index]));
        },
      ),
    );
  }else{
    return const SizedBox(
      height: 1,
    );
  }
          }),
    ),
  );
}



