



import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/resources/strings_manager.dart';
import 'package:doctors_app/presentaion/views/app/app-view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../doctor_ads/doctor_ads_view.dart';
import '../doctor_profile/doctor-profile_view.dart';
import 'home_view.dart';




class DashBoardDoctorView extends StatelessWidget {
  String type;
  DashBoardDoctorView({Key? key,required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    List<Widget> fragmentScreens = [
      HomeView(type: type,),
      const DoctorAdsView(),
     DoctorProfileView(type:type),
      AppView(type:type)
    ];

    List _navigationButtonProperties = [
      {
        "active_icon": (Icons.home),
        "non_active_icon": (Icons.home_outlined),
        "label": "الرئيسية "
      },
      {
        "active_icon": (Icons.ad_units_sharp),
        "non_active_icon": (Icons.ad_units_outlined),
        "label": "اعلاناتي"
      },

      {
        "active_icon": (Icons.person),
        "non_active_icon": (Icons.person_outline),
        "label": "صفحتي "
      },
      {
        "active_icon": (Icons.ad_units),
        "non_active_icon": (Icons.ad_units_outlined),
        "label": AppStrings.APPNAME
      },
    ];

    RxInt indexNumber = 0.obs;
    return Scaffold(
      //backgroundColor: ColorsManager.white,
        appBar: AppBar(
          toolbarHeight: 1,
          backgroundColor: ColorsManager.primary,
        ),
        body: SafeArea(child: Obx(() => fragmentScreens[indexNumber.value])),
        bottomNavigationBar: Obx(() => Container(
          //  color:Colors.grey[200],
          padding: const EdgeInsets.all(10.0),
          child: BottomNavigationBar(
            currentIndex: indexNumber.value,
            onTap: (value) {

              indexNumber.value = value;

              },

            showSelectedLabels: true,
            backgroundColor: ColorsManager.primary,
            showUnselectedLabels: true,
            selectedItemColor: ColorsManager.white,
            unselectedItemColor: Colors.grey,
            items: List.generate(4, (index) {
              var BtnProp = _navigationButtonProperties[index];
              return BottomNavigationBarItem(
                  backgroundColor: ColorsManager.primary,
                  icon: Icon(BtnProp["non_active_icon"]),
                  activeIcon: Icon(BtnProp["active_icon"]),
                  label: BtnProp["label"]);
            }),
          ),
        )));
  }
}
