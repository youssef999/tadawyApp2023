

// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/color_manager.dart';
import 'Custom_Text.dart';


PreferredSizeWidget CustomAppBar(String text,bool leading,double height){

  return AppBar(
      toolbarHeight: height,
      elevation:0.0,
      backgroundColor:ColorsManager.primary,
      title:Custom_Text(text: text,
        fontSize: 21,color:ColorsManager.white,
        alignment:Alignment.center,
      ),
      leading:(leading==true)?
      IconButton(onPressed: (){
        Get.back();
      }, icon: Icon(Icons.arrow_back_ios,size: 28,
        color:ColorsManager.white,
      ))
          :const SizedBox()
  );
}