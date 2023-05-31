

import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/User/search/searching_view.dart';



Widget showSearchBarWidget(TextEditingController name){
  return Padding

    (padding: const EdgeInsets.symmetric(
    horizontal: 18,
  ),

    child:TextField(
      controller: name,
      style:const TextStyle(
        fontSize: 16,
        color:Colors.black,
      ),

      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon:const Icon(Icons.search,color:ColorsManager.purple2, size: 20,) ,
          onPressed:(){
            Get.to( SearchLayout(txt: '',));

          },
        ),

        hintText: "ابحث عن طبيبك هنا ... ",
        hintStyle: const TextStyle(
            color: Colors.grey
        ),
        border: const OutlineInputBorder(
            borderSide: BorderSide(
                color: ColorsManager.purple1,
                width: 2
            )
        ),
        enabledBorder:  const OutlineInputBorder(
            borderSide: BorderSide(
                color: ColorsManager.purple2,
                width: 2
            )
        ),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: ColorsManager.purple1,
                width: 2
            )
        ),
      ),

    ),
  );
}