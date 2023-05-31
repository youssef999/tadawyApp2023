
import 'dart:convert';

import 'package:doctors_app/Data/api_connection/api_connection.dart';
import 'package:doctors_app/domain/models/user.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import 'doctor_states.dart';


class DoctorCubit extends Cubit<DoctorStates> {
  DoctorCubit() :super(AppIntialState());

  static DoctorCubit get(context) => BlocProvider.of(context);

  DoctorModel doc=DoctorModel();


  Future<DoctorModel> getDocotorData() async{

    final box=GetStorage();
    String docId=box.read('doc_Id')??'x';

    try{
      emit(getDoctorDataLoadingState());
      var res =await http.post(Uri.parse(API.getDoctorData),
          body: {

            "doctor_id":docId,

          }
      );

      if(res.statusCode==200){

        var responseBody =jsonDecode(res.body);
       print( responseBody);

        if(responseBody["success"]==true) {
          print(responseBody['Data']);
          doc=DoctorModel.fromJson(responseBody['Data']);
          print("Doctor Data ===$doc");
        }
        emit(getDoctorDataSuccessState());
      }
      else{
        print("errorrrr");
        emit(getDoctorDataErrorState(error: 'error'));
      }
    }
    catch(e){
      print("error"+e.toString());
      emit(getDoctorDataErrorState(error: e.toString()));
    }

    return doc;
  }


}













