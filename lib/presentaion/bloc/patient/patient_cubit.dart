import 'dart:convert';
import 'package:doctors_app/Data/api_connection/api_connection.dart';
import 'package:doctors_app/domain/models/ads.dart';
import 'package:doctors_app/domain/models/best.dart';
import 'package:doctors_app/domain/models/cat.dart';
import 'package:doctors_app/domain/models/country.dart';
import 'package:doctors_app/domain/models/filters.dart';
import 'package:doctors_app/domain/models/places.dart';
import 'package:doctors_app/domain/models/places2.dart';
import 'package:doctors_app/domain/models/user.dart';
import 'package:doctors_app/domain/models/user_model.dart';
import 'package:doctors_app/presentaion/bloc/patient/patient_states.dart';
import 'package:doctors_app/presentaion/const/app_message.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientCubit extends Cubit<PatientStates> {


  PatientCubit() : super(AppIntialState());
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  static PatientCubit get(context) => BlocProvider.of(context);
  List<Ads> adsList = [];
  List<Ads> adsList2 = [];
  List<Ads> bestList = [];
  List<DoctorModel> doctorList = [];
  List<DoctorModel> doctorListFilter = [];
  List<DoctorModel> topDoctorList = [];
  List<DoctorModel> searchList = [];
  List<Filter> searchFilter = [];
  List<Cat> catList = [];
  List<Ads>newList=[];
  double countryPrice=0.0;

  Set<Places> uniquePlaces = Set<Places>();

  //List<Filter>filterList=[];
  List<DoctorModel> filterList = [];
  List<DoctorModel> filterCatList = [];
  List<Places>placesList=[];
  List<Places2>placesList2=[];
  Set<String> uniqueNames = Set<String>();
  Set<String> uniqueNames2 = Set<String>();
  Set<String> uniqueNames3 = Set<String>();


  TextEditingController searchController = TextEditingController();

  User user = User();
  List<Country> countryList=[];


  Country ? country;

  Future<double> getPriceCountry() async{

    print("GET COUNTRY PRICE");
    final box = GetStorage();

    String country = box.read('country') ?? 'x';

    try{
      emit(GetCountryPriceLoadingState());
      var res =await http.post(Uri.parse(API.GetPriceCountry),body:{
        'name':country
      },
      );

      if(res.statusCode==200){
        print(res.bodyBytes);
        var responseBody =jsonDecode(res.body);
        if(responseBody["success"]==true) {

          print(responseBody['Data']);
          print(responseBody['Data']['price']);
          countryPrice=double.parse(responseBody['Data']['price'].toString());
        }

        emit(GetCountryPriceSuccessState());
      }
      else{
        emit(GetCountryPriceErrorState(error: 'error'));
      }
    }
    catch(e){
      emit(GetCountryPriceErrorState(error: e.toString()));
    }

    print("PRICE COUNTRY===="+countryPrice.toString());

    return countryPrice;
  }


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

void getAllAds() async {

    adsList=[];
    print("ALL ADS");
    final box = GetStorage();
    String country = box.read('country') ?? 'x';
    print("CCCC$country");
    try {
      emit(getAdsLoadingState());
      var res = await http.post(
        Uri.parse(API.ads),body:{
          "country":country
      });
      print(res.body);
      if (res.statusCode == 200) {
        print("ADS 200");
        print(res.body);
        var responseBody = jsonDecode(res.body);

        print(responseBody);

        if (responseBody["success"] == true) {
          print(responseBody['Data']);

          (responseBody['Data'] as List).forEach((eachRecord) {
            adsList.add(Ads.fromJson(eachRecord));
          });

          print("Appointment===$adsList");
        }
        emit(getAdsSuccessState());
      } else {
        print("ERRRROORRRRRRRRRRR................");
        print(res.statusCode);
        emit(getAdsErrorState(error: 'error'));
      }
    } catch (e) {
      print("ERRRROORRRRRRRRRRR................");
      print(e.toString());
      emit(getAdsErrorState(error: e.toString()));
    }

    print("====ADS===="+adsList.toString());
    print("====ADS length===="+adsList.length.toString());

  //  return adsList;
  }

  Future<List<Ads>> getAllAds2() async {
    print("ALL ADS");
    final box = GetStorage();
    String country = box.read('country') ?? 'x';
    print("CCCC$country");
    print("ALL ADS222222222");
    // final box = GetStorage();
    // String country = box.read('country') ?? 'x';
    // print("CCCC$country");
    try {
      emit(getAdsLoadingState());
      var res = await http.post(
        Uri.parse(API.ads2),body: {
        "country":country
      },
      );
      print("SUC..............................");
      print(res.body);
      if (res.statusCode == 200) {
        print(res.body);
        var responseBody = jsonDecode(res.body);

        print("SUC..............................");
        print(responseBody);

        if (responseBody["success"] == true) {
          print(responseBody['Data']);

          (responseBody['Data'] as List).forEach((eachRecord) {
            adsList2.add(Ads.fromJson(eachRecord));
          });

          print("ADS 2 ===$adsList2");
        }
        emit(getAdsSuccessState());
      } else {
        print("ERRRROORRRRRRRRRRR................");
        print(res.statusCode);
        emit(getAdsErrorState(error: 'error'));
      }
    } catch (e) {
      print("ERRRROORRRRRRRRRRR................");
      print(e.toString());
      emit(getAdsErrorState(error: e.toString()));
    }

    return adsList2;
  }

  Future<List<DoctorModel>> getAllFilters(String place2) async {
    print("ALL ADS");
    final box = GetStorage();
    String country = box.read('country') ?? 'x';
    print("CCCC$country");
    try {
      emit(getFiltersLoadingState());
      var res = await http.post(
        Uri.parse(API.Filters),body:{
          'place2':place2
      } ,
      );
      print(res.body);
      if (res.statusCode == 200) {
        print(res.body);
        var responseBody = jsonDecode(res.body);

        print(responseBody);

        if (responseBody["success"] == true) {
          print(responseBody['Data']);
          (responseBody['Data'] as List).forEach((eachRecord) {
            filterList.add(DoctorModel.fromJson(eachRecord));
          });

          print("FILTER  ===$filterList");
        }
        emit(getFiltersSuccessState());
      } else {
        print("ERRRROORRRRRRRRRRR................");
        print(res.statusCode);
        emit(getFiltersErrorState(error: 'error'));
      }
    } catch (e) {
      print("ERRRROORRRRRRRRRRR................");
      print(e.toString());
      emit(getFiltersErrorState(error: e.toString()));
    }

    return filterList;
  }






  Future<List<DoctorModel>> getAllCatFilters(String dcotorCat) async {
    print("ALL ADS");
    final box = GetStorage();
    String country = box.read('country') ?? 'x';
    print("CCCC$country");
    try {
      emit(getFiltersLoadingState());
      var res = await http.post(
        Uri.parse(API.DoctorsWithCat),body:{
        'doctor_cat':dcotorCat
      } ,
      );
      print(res.body);
      if (res.statusCode == 200) {
        print(res.body);
        var responseBody = jsonDecode(res.body);

        print(responseBody);

        if (responseBody["success"] == true) {
          print(responseBody['Data']);
          (responseBody['Data'] as List).forEach((eachRecord) {
            filterCatList.add(DoctorModel.fromJson(eachRecord));
          });

          print("FILTER  ===$filterList");
        }
        emit(getFiltersSuccessState());
      } else {
        print("ERRRROORRRRRRRRRRR................");
        print(res.statusCode);
        emit(getFiltersErrorState(error: 'error'));
      }
    } catch (e) {
      print("ERRRROORRRRRRRRRRR................");
      print(e.toString());
      emit(getFiltersErrorState(error: e.toString()));
    }

    return filterCatList;
  }




  Future<List<Places>> getAllPlaces() async {



    print("ALL ADS");
    final box = GetStorage();
    String country = box.read('country') ?? 'x';
    print("CCCC$country");
    try {
      emit(getPlacesLoadingState());

      var res = await http.post(
        Uri.parse(API.Places),body:{
          'country':country
          //country
        });

      print(res.body);
      if (res.statusCode == 200) {
        print(res.body);
        var responseBody = jsonDecode(res.body);

        print(responseBody);

        if (responseBody["success"] == true) {
          print(responseBody['Data']);
          (responseBody['Data'] as List).forEach((eachRecord) {
            placesList.add(Places.fromJson(eachRecord));
          });
          getUniquePlaces(placesList);
        //  uniquePlaces = placesList.toSet();
         // print("Unique===$uniqueData");
        }

        emit(getPlacesSuccessState());

      } else {
        print("ERRRROORRRRRRRRRRR................");
        print(res.statusCode);
        emit(getPlacesErrorState(error: 'error'));
      }
    } catch (e) {
      print("ERRRROORRRRRRRRRRR................");
      print(e.toString());
      emit(getPlacesErrorState(error: e.toString()));
    }

    return placesList;
  }


  List<Places> getUniquePlaces(List<Places>apiData) {

    List<Places> uniquePlacesList = [];

    for (Places place in apiData) {
      if (!uniqueNames.contains(place.name)) {
        uniqueNames.add(place.name!);
        uniquePlacesList.add(place);
      }
    }
    return uniquePlacesList;
  }

  List<Places2> getUniquePlaces2(List<Places2>apiData) {

    List<Places2> uniquePlacesList = [];

    for (Places2 place in apiData) {
      if (!uniqueNames2.contains(place.name)) {
        uniqueNames2.add(place.name!);
        uniquePlacesList.add(place);
      }
    }
    return uniquePlacesList;
  }

  List<DoctorModel> getUniqueCat(List<DoctorModel>apiData) {

    List<DoctorModel> uniquePlacesList3 = [];

    for (DoctorModel place in apiData) {
      if (!uniqueNames3.contains(place.doctor_cat)) {
        uniqueNames3.add(place.doctor_cat!);
        uniquePlacesList3.add(place);
      }
    }
    return uniquePlacesList3;
  }



  Future<List<Places2>> getAllPlaces2(String place) async {


    try {
      emit(getPlacesLoadingState2());

      var res = await http.post(
          Uri.parse(API.Places2),body:{
        'place':place
      });

      print(res.body);
      if (res.statusCode == 200) {
        print(res.body);
        var responseBody = jsonDecode(res.body);

        print(responseBody);

        if (responseBody["success"] == true) {
          print(responseBody['Data']);
          (responseBody['Data'] as List).forEach((eachRecord) {
            placesList2.add(Places2.fromJson(eachRecord));
          });

          print("PLACES 2 ===$placesList2");
        }
        getUniquePlaces2(placesList2);
        emit(getPlacesSuccessState());

      } else {
        print("ERRRROORRRRRRRRRRR................");
        print(res.statusCode);
        emit(getPlacesErrorState(error: 'error'));
      }
    } catch (e) {
      print("ERRRROORRRRRRRRRRR................");
      print(e.toString());
      emit(getPlacesErrorState(error: e.toString()));
    }

    return placesList2;
  }


  Future<List<Ads>> getBestOffers() async {
    print(".......Best Offers.............");

    try {
      emit(getBestOffersLoadingState());
      var res = await http.post(
        Uri.parse(API.Best),body:{
          "country":country
      },
      );
      print(res.body);
      if (res.statusCode == 200) {
        print(res.body);
        var responseBody = jsonDecode(res.body);

        print(responseBody);

        if (responseBody["success"] == true) {
          print("............B.......");
          print(responseBody['Data']);

          (responseBody['Data'] as List).forEach((eachRecord) {
            bestList.add(Ads.fromJson(eachRecord));
          });

          print("Best===$bestList");
          print('LLLLLLLLLLLLLL');
          print(bestList.length);

        }
        emit(getBestOffersSuccessState());
      } else {
        print("ERRRROORRRRRRRRRRR................");
        print(res.statusCode);
        emit(getBestOffersErrorState(error: 'error'));
      }
    } catch (e) {
      print("ERRRROORRRRRRRRRRR................");
      print(e.toString());
      emit(getBestOffersErrorState(error: e.toString()));
    }

    return bestList;
  }


  handleBestOffers( List <Ads> adsList){
    final box=GetStorage();
    String c=box.read('country')??"x";

    for(int i=0;i<adsList.length;i++){
      print('HEREXXX');
      DateTime now = DateTime.now();
      DateTime endDate = DateTime.parse(adsList[i].date_end.toString());
      if(endDate.isAfter(now)&&adsList[i].country==c&&adsList[i].best=='true'){
        print('HERETRUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE');
        newList.add(adsList[i]);
      }
    }
    print("LIST000============"+newList.toString());
  }


  DoctorModel doc=DoctorModel();

  Future<DoctorModel> getDoctorData(String id) async {
    try {
      emit(TopDoctorsLoadingState());
      var res = await http.post(
        Uri.parse(API.DOCDATA),body:{
        "doctor_id":id
      },
      );
      if (res.statusCode == 200) {
        print(res.body);
        var responseBody = jsonDecode(res.body);

        if (responseBody["success"] == true) {
          print(responseBody['Data']);
          doc=DoctorModel.fromJson(responseBody['Data']);
          // (responseBody['Data'] as List).forEach((eachRecord) {
          //   topDoctorList.add(DoctorModel.fromJson(eachRecord));
          // });
          // print("TOP===$topDoctorList");
        }
        emit(TopDoctorsSuccessState());
      } else {
        print(res.statusCode);
        emit(TopDoctorsErrorState());
      }
    } catch (e) {
      print("Error===");
      print(e.toString());
      emit(TopDoctorsErrorState());
    }
    return doc;
  }

  Future<List<DoctorModel>> getTopDoctors() async {
    final box=GetStorage();
    String c=box.read('country')??"";
    print("TOP DOCTORS...................................");
    print("$c");
    try {
      emit(TopDoctorsLoadingState());
      var res = await http.post(
        Uri.parse(API.TopDoctors),body:{
          "country":c
      },
      );
      if (res.statusCode == 200) {
        print(res.body);
        var responseBody = jsonDecode(res.body);

        if (responseBody["success"] == true) {
          print(responseBody['Data']);
          (responseBody['Data'] as List).forEach((eachRecord) {
            topDoctorList.add(DoctorModel.fromJson(eachRecord));
          });
          print("TOP===$topDoctorList");
        }
        emit(TopDoctorsSuccessState());
      } else {
        print(res.statusCode);
        emit(TopDoctorsErrorState());
      }
    } catch (e) {
      print("Error===");
      print(e.toString());
      emit(TopDoctorsErrorState());
    }
    return topDoctorList;
  }

  Future<List<DoctorModel>> getAllDoctors(String cat2) async {

    print("GET ALL DOCTORS");
    final box=GetStorage();
    String country=box.read('country')??"";
    try {
      emit(getDoctorsLoadingState());
      var res = await http.post(
        Uri.parse(API.allDoctorsData),
        body: {
          'cat2': cat2,
          "country":country
        },
      );
      if (res.statusCode == 200) {
        print(res.body);
        var responseBody = jsonDecode(res.body);
        if (responseBody["success"] == true) {
          print(responseBody['Data']);
          (responseBody['Data'] as List).forEach((eachRecord) {
            doctorList.add(DoctorModel.fromJson(eachRecord));
          }
          );
         // print("List===$doctorList");
        }
        emit(getDoctorsSuccessState());
      } else {
        print(res.statusCode);
        emit(getDoctorsErrorState());
      }
    } catch (e) {
      print("GET DOCTOR Error===");
      print(e.toString());
      emit(getDoctorsErrorState());
    }
    return doctorList;
  }

  Future<List<DoctorModel>> getAllDoctorsSales() async {
    try {
      emit(getDoctorsLoadingState());
      var res = await http.get(
        Uri.parse(API.allDoctorsDataSales));

      if (res.statusCode == 200) {
        print(res.body);
        var responseBody = jsonDecode(res.body);

        if (responseBody["success"] == true) {
          print(responseBody['Data']);
          (responseBody['Data'] as List).forEach((eachRecord) {
            doctorList.add(DoctorModel.fromJson(eachRecord));
          });
          print("List===$doctorList");
        }
        emit(getDoctorsSuccessState());
      } else {
        print(res.statusCode);
        emit(getDoctorsErrorState());
      }
    } catch (e) {
      print("Error===");
      print(e.toString());
      emit(getDoctorsErrorState());
    }

    return doctorList;
  }

  Future<List<DoctorModel>> getAllDoctorsFilter() async {
    final box=GetStorage();
    String country=box.read('country')??'';
    try {
      emit(getDoctorsLoadingState());
      var res = await http.post(
        Uri.parse(API.allDoctorsFilter),
        body: {

          'country':country
        },
      );
      if (res.statusCode == 200) {
        print(res.body);
        var responseBody = jsonDecode(res.body);

        if (responseBody["success"] == true) {
          print(responseBody['Data']);
          (responseBody['Data'] as List).forEach((eachRecord) {

            doctorListFilter.add(DoctorModel.fromJson(eachRecord));

          });
          print("List===$doctorListFilter");
        }
        getUniqueCat(doctorListFilter);
        emit(getDoctorsSuccessState());
      } else {
        print(res.statusCode);
        emit(getDoctorsErrorState());
      }
    } catch (e) {
      print("Error===");
      print(e.toString());
      emit(getDoctorsErrorState());
    }
    return doctorList;
  }

  List<Ads>newAdsList=[];
  filterData(){
    print("FILTERads");
    for(int i=0;i<adsList.length;i++){
      // if(widget.adsList[i].date_end.toString().length>2){
      //   print("IF HERE");
      DateTime currentDate = DateTime.now();
      String date=adsList[i]
          .date_end.toString();
      DateTime date2 = DateTime.parse(date);
      int result = currentDate.compareTo(date2);
      print("/////");
      print(currentDate);
      print(date2);
      print(result);
      print("//////////");
      String comparisonResult;

      if (result < 0) {
        comparisonResult = 'Date 1 is before Date 2';

          newAdsList.add(adsList[i]);


      } else if (result == 0) {
        comparisonResult = 'Date 1 is equal to Date 2';
      } else {
        comparisonResult = 'Date 1 is after Date 2';

      }
      print(comparisonResult);
      emit(getAdsSuccessState());
      // }else{
      //
      //   print("NOT IDF");
      //}
    }

  }

  Future<List<Cat>> getAllCat() async {
    try {
      emit(getCatLoadingState());
      var res = await http.get(
        Uri.parse(API.allCat),
      );

      if (res.statusCode == 200) {
        print(res.bodyBytes);
        var responseBody = jsonDecode(res.body);
        if (responseBody["success"] == true) {
          print(responseBody['Data']);

          (responseBody['Data'] as List).forEach((eachRecord) {
            catList.add(Cat.fromJson(eachRecord));
          });
          print("List===$catList");
        }
        emit(getCatSuccessState());
      } else {
        print(res.statusCode);
        emit(getCatErrorState(error: 'error'));
      }
    } catch (e) {
      print(e.toString());
      emit(getCatErrorState(error: e.toString()));
    }

    return catList;
  }

  Future<User> getUserData() async {
    final box = GetStorage();
    String id = box.read('userId') ?? 'x';
    print('id$id');
    try {
      emit(getUserDataLoadingState());
      var res = await http.post(
        Uri.parse(API.getUserData),
        body: {'user_id': id},
      );

      if (res.statusCode == 200) {
        print(res.body);
        var responseBody = jsonDecode(res.body);

        if (responseBody["success"] == true) {
          print("Data");
          print(responseBody['Data']);

          user = User.fromJson(responseBody['Data']);
        }
        emit(getUserDataSuccessState());
      } else {
        print(res.statusCode);
        emit(getUserDataErrorState(error: 'error'));
      }
    } catch (e) {
      print(e.toString());
      emit(getUserDataErrorState(error: e.toString()));
    }

    return user;
  }

  Future<List<DoctorModel>> searchData(String name) async {
    emit(SearchLoadingState());
    try {
      var res = await http.post(Uri.parse(API.SEARCH), body: {
        'typedkeyWords': name,
      });

      print("res${res.body}");
      if (res.statusCode == 200) {
        print("......HERE...SEARCH........");

        var resOfFavValidate = jsonDecode((res.body));

        if (resOfFavValidate['success'] == true) {
          (resOfFavValidate['Data'] as List).forEach((eachRecord) {
            searchList.add(DoctorModel.fromJson(eachRecord));
          });
          print("success");
          emit(SearchSuccessState());
        } else {
          print("errrorr");
          emit(SearchErrorState(error: 'e'));
        }
      }
    } catch (e) {
      print("ERROR22::$e");
      emit(SearchErrorState(error: e.toString()));
    }
    return searchList;
  }


  Future<List<Filter>> searchFilters(String name) async {
    emit(SearchLoadingState());
    try {
      var res = await http.post(Uri.parse(API.SEARCHFilters), body: {
        'typedkeyWords': name,
      });

      print("res${res.body}");
      if (res.statusCode == 200) {
        print("......HERE...SEARCH........");

        var resOfFavValidate = jsonDecode((res.body));

        if (resOfFavValidate['success'] == true) {
          (resOfFavValidate['Data'] as List).forEach((eachRecord) {
            searchFilter.add(Filter.fromJson(eachRecord));
          });
          print("success");
          emit(SearchSuccessState());
        } else {
          print("errrorr");
          emit(SearchErrorState(error: 'e'));
        }
      }
    } catch (e) {
      print("ERROR22::$e");
      emit(SearchErrorState(error: e.toString()));
    }
    return searchFilter;
  }


  void updateData(String emailHint, String nameHint, String phoneHint) async {
    String e, n, p;
    if (email.text == '') {
      e = emailHint;
    } else {
      e = email.text;
    }

    if (name.text == '') {
      n = nameHint;
    } else {
      n = name.text;
    }
    if (phone.text == '') {
      p = phoneHint;
    } else {
      p = phone.text;
    }

    final box = GetStorage();
    String userId = box.read('userId') ?? 'x';
    print("ID===$userId");
    if (phone.text.isNotEmpty ||
        name.text.isNotEmpty ||
        email.text.isNotEmpty) {
      try {
        emit(UpdateDataLoadingState());
        var res = await http.post(
          Uri.parse(API.updateData),
          body: {
            'user_id': userId,
            'email': e,
            'name': n,
            'phone': p,
          },
        );

        if (res.statusCode == 200) {
          var responseBody = jsonDecode(res.body);

          if (responseBody["success"] == true) {
            emit(UpdateDataSuccessState());
          }
        } else {
          print(res.statusCode);
          emit(UpdateDataErrorState(error: 'error'));
        }
      } catch (e) {
        print(e.toString());
        emit(UpdateDataErrorState(error: e.toString()));
      }
    } else {
      appMessage(text: 'انت لم تدخل اي تعديل ');
    }
  }
}
