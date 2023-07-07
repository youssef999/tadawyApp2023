import 'package:doctors_app/domain/models/country.dart';
import 'package:doctors_app/presentaion/bloc/country/country_bloc.dart';
import 'package:doctors_app/presentaion/bloc/country/country_states.dart';
import 'package:doctors_app/presentaion/const/app_message.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/views/HomeApp/choose/choose_view.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CountriesView extends StatefulWidget {
  const CountriesView({Key? key}) : super(key: key);

  @override
  State<CountriesView> createState() => _CountriesViewState();
}

class _CountriesViewState extends State<CountriesView> {


  String selectedValue = 'مصر';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => CountryCubit()..getAllCountries(),
        child: BlocConsumer<CountryCubit, CountryStates>(
            listener: (context, state) {},
            builder: (context, state) {
              CountryCubit cubit = CountryCubit.get(context);
              return Scaffold(
                  appBar: AppBar(
                    toolbarHeight: 7,
                    elevation: 0,
                    backgroundColor: ColorsManager.primary,
                  ),
                  body: Container(
                    //color:ColorsManager.primary,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //const SizedBox(height: 10,),

                          Container(
                            color: ColorsManager.primary,
                            child: Column(
                              children: [
                                Container(
                                  color: ColorsManager.primary,
                                  height: 150,
                                  child: Image.asset('assets/images/logo.png'),
                                ),
                                Container(
                                    color: ColorsManager.primary,
                                    child: const SizedBox(
                                      height: 20,
                                    )),
                                Container(
                                    color: ColorsManager.primary,
                                    child: const Custom_Text(
                                        text: 'اختر البلد',
                                        fontSize: 28,
                                        color: Colors.white,
                                        alignment: Alignment.center)),
                                Container(
                                    color: ColorsManager.primary,
                                    child: const SizedBox(
                                      height: 20,
                                    )),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 30,
                          ),
                          //  CountryWidget(cubit.countryList,cubit),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Custom_Text(
                                  text: 'البلد ',
                                  color: Colors.black,
                                  fontSize: 21,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                DropdownButton<Country>(
                                  value: cubit.country,
                                  items: cubit.countryList.map((item) {
                                    return DropdownMenuItem<Country>(
                                      value: item,
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Row(
                                          children: [
                                           Container(
                                                width: 40,
                                                //backgroundColor: Colors.white,
                                                child: Image.network(
                                                    item.image.toString(),fit:BoxFit.fill,)),
                                            SizedBox(
                                              width: 14,
                                            ),
                                            Custom_Text(
                                              text: item.name,
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (item) {
                                    setState(() {
                                      cubit.country = item!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                              width: 150,
                              child: CustomButton(
                                  text: 'التالي',
                                  color1: ColorsManager.primary,
                                  color2: Colors.white,
                                  onPressed: () {
                                    if (cubit.country.isNull) {
                                      appMessage(text: 'اختر الدولة ');
                                    }

                                    print('ccc');
                                    print(cubit.country!.countryCode);
                                    final box = GetStorage();

                                    box.write('country', cubit.country!.name);
                                    box.write('currency', cubit.country!.currency);
                                    box.write('countryCode', cubit.country!.countryCode);
                                    Get.to(const ChooseView());
                                  })

                              //   print(cubit.country!.name.toString());
                              //
                              //   final box=GetStorage();
                              //
                              //   box.write('country',cubit.country!.name.toString());
                              //   Get.to(const ChooseView());
                              // }, color1: ColorsManager.primary, color2: Colors.white),
                              )
                        ],
                      ),
                    ),
                  ));
            }));
  }
}

Widget CountryWidget(List<Country> listApp, CountryCubit cubit) {
  return SingleChildScrollView(
    child: Container(
      height: 400,
      color: Colors.grey[200],
      //width:double.infinity,
      padding: const EdgeInsets.only(top: 9, left: 7, right: 7),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listApp.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    InkWell(
                      child: Row(
                        children: [
                          Container(
                            height: 60,
                            width: 50,
                            child:
                                Image.network(listApp[index].image.toString(),fit:BoxFit.fill),
                          ),
                          SizedBox(
                            width: 21,
                          ),
                          Container(
                            // height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.transparent),
                            child: Custom_Text(
                              text: listApp[index].name.toString(),
                              color: ColorsManager.black,
                              fontSize: 16,
                              alignment: Alignment.center,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        print(listApp[index].name.toString());
                        final box = GetStorage();
                        print(listApp[index].countryCode);
                        box.write('country', listApp[index].name);
                        box.write('countryCode', listApp[index].countryCode);
                         Get.to(const ChooseView());
                      },
                    ),
                    SizedBox(
                      height: 12,
                    )
                  ],
                  // );

                  // InkWell(
                  //   child: Container(
                  //     height: 80,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(15),
                  //         color: Colors.white70),
                  //     child:   Custom_Text(
                  //       text: listApp[index].name.toString(),
                  //       color: ColorsManager.black,
                  //       fontSize: 21,
                  //       alignment: Alignment.center,
                  //     ),
                  //
                  //
                  //   ),
                  //   onTap: () {
                  //     print(listApp[index].name.toString());
                  //     final box=GetStorage();
                  //     box.write('country',listApp[index].name);
                  //     Get.to(const ChooseView());
                  //   },
                  // ),
                ));
          }),
    ),
  );
}
