import 'dart:convert';
import 'package:doctors_app/Data/api_connection/api_connection.dart';
import 'package:doctors_app/domain/models/country.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'country_states.dart';

class CountryCubit extends Cubit<CountryStates> {
  CountryCubit() :super(AppIntialState());

  static CountryCubit get(context) => BlocProvider.of(context);
  List<Country> countryList=[];
   Country ? country;

  Future <List<Country>> getAllCountries()async {


    emit(GetCountryLoadingState());
    try{
      var res = await http.get(Uri.parse(API.Country));

      if (res.statusCode == 200) {

        print("API222");
        print("res======${res.body}");
        var responseBody = jsonDecode(res.body);
        if (responseBody["success"] == true) {
          (responseBody['Data'] as List).forEach((eachRecord) {
          countryList.add(Country.fromJson(eachRecord));

          });
        }
        emit(GetCountrySuccessState());
      }
      else {
        print("eeee");
        emit(GetCountryErrorState('error'));
      }

    }
    catch(e){
      print("e==="+e.toString());
      print("eeee");
      emit(GetCountryErrorState('error'));

    }
    return countryList;
  }

 }