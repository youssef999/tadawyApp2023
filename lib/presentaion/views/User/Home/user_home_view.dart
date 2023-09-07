import 'package:doctors_app/domain/models/cat.dart';
import 'package:doctors_app/domain/models/country.dart';
import 'package:doctors_app/domain/models/user.dart';
import 'package:doctors_app/presentaion/bloc/patient/patient_cubit.dart';
import 'package:doctors_app/presentaion/bloc/patient/patient_states.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/views/User/Filter/filter_cat_view.dart';
import 'package:doctors_app/presentaion/views/User/Filter/filters_view.dart';
import 'package:doctors_app/presentaion/views/User/search/searching_view.dart';
import 'package:doctors_app/presentaion/views/splash/splash_screen.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:doctors_app/presentaion/widgets/ads_widget/ads_slider2.dart';
import 'package:doctors_app/presentaion/widgets/ads_widget/ads_widget.dart';
import 'package:doctors_app/presentaion/widgets/ads_widget/best_widget.dart';
import 'package:doctors_app/presentaion/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../resources/assets_manager.dart';
import '../doctors/all_doctors_list_view.dart';
import '../doctors/doctor-details_view.dart';


 class UserHomeView extends StatefulWidget {
  const UserHomeView({Key? key}) : super(key: key);

  @override
  State<UserHomeView> createState() => _UserHomeViewState();
}

class _UserHomeViewState extends State<UserHomeView> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return  BlocProvider(
        create:(BuildContext context)=>PatientCubit()..getPriceCountry()
          ..getAllAds()..getAllAds2()
          ..getAllCat()..getTopDoctors()..getAllCountries(),

        child: BlocConsumer<PatientCubit,PatientStates>(
            listener:(context,state){

    },
    builder:(context,state){

    PatientCubit patientCubit = PatientCubit.get(context);

    return
         Scaffold(
           key: _scaffoldKey,
           backgroundColor: ColorsManager.primaryx,

        drawer:  MainDrawer(type: 'user'),
        body:Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            children: [
              SizedBox(height: 10,),
              Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width*0.06,),
                  InkWell(child:
                  Icon(Icons.drag_handle_outlined,color:ColorsManager.primary,size: 40,),

                  onTap:(){
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  ),

                  SizedBox(width: MediaQuery.of(context).size.width*0.22,),
                  SizedBox(
                      height: 77,
                      child: Image.asset(AssetsManager.Logo)),
                  SizedBox(width: MediaQuery.of(context).size.width*0.20,),

                  Row(
                    children: [
                      SizedBox(width: 15,),
                      InkWell(
                        child:Icon(Icons.filter_alt,color:ColorsManager.primary,size:32),
                        onTap:(){
                          Get.to(FiltersView());
                        },
                      ),
                      SizedBox(width: 12,),


                    ],
                  ),



                ],
              ),
              SizedBox(height: 12,),

              SizedBox(height: 5),
              Row(
                children: [

                  DropdownButton<Country>(
                    value: patientCubit.country,
                    items: patientCubit.countryList.map((item) {
                      return DropdownMenuItem<Country>(
                        value: item,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: Image.network(
                                      item.image.toString())),
                              SizedBox(
                                width: 13,
                              ),
                              Custom_Text(
                                text: item.name,
                                color: Colors.black,
                                fontSize: 21,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (item) async {
                      final box=GetStorage();
                    await  box.remove('country');
                    await  box.remove('currency');
                      setState(() {
                        patientCubit.country = item!;
                      });
                      box.write('country',patientCubit.country!.name.toString());
                      box.write('countryCode',patientCubit.country!.countryCode.toString());
                      box.write('currency',patientCubit.country!.currency.toString());
                      Get.offAll(SplashView());
                    },



                  ),
                  //SizedBox(width: 12,),

                ],
              ),
              SizedBox(height: 20,),
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
                            controller: patientCubit.searchController,
                            decoration: InputDecoration(
                                hintText: 'ادخل اسم الطبيب او جهة العلاج ',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        InkWell(child: const Icon(Icons.search,color:ColorsManager.black,size:33),
                          onTap:(){
                            Get.to( SearchLayout(
                              txt: patientCubit.searchController.text,
                              price: patientCubit.countryPrice,
                            ));
                          },
                        ),

                      ],
                    ),
                  ),
                ),
              ),
             const SizedBox(height: 50,),
              AdsSlider(patientCubit.adsList),
              const SizedBox(height: 20,),
             Custom_Text(text: '- - - - - - - - - ',color:ColorsManager.primary,fontSize:23
                ,alignment:Alignment.center),

              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left:26.0,right: 26,top:10,bottom:10),
                child: Container(
                  height: 100,
                  child:CustomButton(
                    text: 'اقسام الاطباء',
                    color1:ColorsManager.primary,
                    color2: Colors.white,
                    onPressed: (){
                      Get.to(FilterCatView());
                    },
                  )
                ),
              ),
              const SizedBox(height: 10,),
              Custom_Text(text: '- - - - - - - - - ',color:ColorsManager.primary,fontSize:23
                  ,alignment:Alignment.center),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CatWidget(patientCubit.catList,patientCubit.countryPrice),
              ),

              const SizedBox(height: 10,),
             Custom_Text(text: '- - - - - - - - - ',color:ColorsManager.primary,fontSize:23
                  ,alignment:Alignment.center),
              const SizedBox(height: 20,),



              AdsSlider2(patientCubit.adsList),

              const SizedBox(height: 20,),
              //
              // (patientCubit.bestList.length>0)?
              // Column(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.all(17.0),
              //       child: Custom_Text(text: 'افضل العروض',fontSize: 23,color:Colors.black,alignment:Alignment.topRight),
              //     ),  const SizedBox(height: 20,),
              //     BestSlider(patientCubit.bestList),
              //
              //   ],
              // ):SizedBox(),

              const SizedBox(height: 30,),


              (patientCubit.topDoctorList.length>0)?
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right:28.0),
                    child: Custom_Text(text: 'افضل الاطباء',fontSize: 22,color:Colors.black,alignment:Alignment.topRight,),
                  ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TopDoctorsWidget(patientCubit.topDoctorList,patientCubit.countryPrice),
                  ),
                ],
              ):SizedBox(),

              const SizedBox(height: 20,),
            ],
          ),
        ),

    );
    }

        )
    );
  }
}


 Widget CatWidget(List<Cat> catList,double price){

  double height=290;

  if(catList.length>4){
    height=290;
  }

  if(catList.length>5){
    height=320;
  }

  if(catList.length>7){
    height=420;
  }

  if(catList.length>9){
    height=520;
  }
  if(catList.length>11){
    height=620;
  }

  return   SizedBox(
    height: height,
    child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 137,
            childAspectRatio: 2 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 16),
        itemCount: catList.length,


        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
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
                      SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Image.network(
                              catList[index].image.toString())),
                      const SizedBox(
                       height: 15,
                      ),

                      SizedBox(
                        child: Column(
                          children: [
                            Custom_Text(
                              text: catList[index].name.toString(),
                              color: ColorsManager.white,
                              fontSize: 15,
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
                ),
              ),
              onTap: () {

                print("cat222"+catList[index].cat2);

                Get.to(AllDoctorsView(catList[index].cat2));
              },
            ),
          );
        }),
  );

}

 Widget TopDoctorsWidget(List<DoctorModel> catList,double price) {


  if(catList.isNotEmpty){
    return SingleChildScrollView(
      child: Container(
       // height:9130,
        color: ColorsManager.primaryx,
        //width:double.infinity,
        padding: const EdgeInsets.only(top: 9, left: 7, right: 7),
        child:
        SizedBox(
     height: 270,
     child: ListView.builder(
         scrollDirection:Axis.horizontal,
            //  physics: const NeverScrollableScrollPhysics(),
              itemCount: catList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Container(
                        height: 222,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white70),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Column(
                            children: [

                              // const SizedBox(
                              //   height: 12,
                              // ),
                              Container(
                                  color:ColorsManager.primary,
                                  height: 106,
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  child: Image.network(
                                    catList[index].doctor_image.toString(),
                                    fit:BoxFit.scaleDown,
                                  )),
                              const SizedBox(
                                height: 30,
                              ),

                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Column(
                                  children: [
                                    Custom_Text(
                                      text: catList[index].doctor_name.toString(),
                                      color: ColorsManager.black,
                                      fontSize: 20,
                                      alignment: Alignment.center,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    RatingBar.builder(
                                      itemSize:12,
                                      initialRating:double.parse( catList[index].rate.toString()),
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding:
                                      EdgeInsets.symmetric(horizontal: 1.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      unratedColor:Colors.grey,
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                    const SizedBox(
                                      height: 13,
                                    ),
                                    Custom_Text(text:catList[index].rate.toString(),
                                      fontSize:16,
                                      color:Colors.black,
                                      alignment:Alignment.center,

                                    )


                                  ],
                                ),
                              ),

                              SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.1),

                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Get.to(DoctorDetailsView(
                            catList[index],
                            price

                        ));
                        // print(AllDoctorsView(catList[index].cat2));
                        // Get.to(AllDoctorsView(catList[index].cat2));

                      },
                    ),
                  ),
                  onTap:(){
                    Get.to(DoctorDetailsView(
                        catList[index],
                        price
                    ));
                  },
                );

              }),
   ),
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

