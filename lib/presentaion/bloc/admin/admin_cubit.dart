//
// import 'dart:convert';
// import 'package:doctors_app/domain/models/country.dart';
// import 'package:doctors_app/domain/models/user.dart';
// import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:doctors_app/Data/api_connection/api_connection.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_storage/get_storage.dart';
// import '../../../domain/models/ads.dart';
// import '../../../domain/models/booking.dart';
// import '../../../domain/models/bouquet.dart';
// import '../../../domain/models/cat.dart';
// import 'admin_state.dart';
//
//  class AdminCubit extends Cubit<AdminStates> {
//
//   AdminCubit() :super(AppIntialState());
//   // objects mn nfsy
//   static AdminCubit get(context) => BlocProvider.of(context);
//
//   List<DoctorModel> doctorList = [];
//   List<Baka> bakaList = [];
//   List<Ads> adsList = [];
//   List<Booking> bookingList=[];
//   List<Cat> catList = [];
//   var imageLink = '';
//   TextEditingController nameController = TextEditingController();
//   TextEditingController detailsController = TextEditingController();
//   TextEditingController desController = TextEditingController();
//   TextEditingController price = TextEditingController();
//   TextEditingController adv = TextEditingController();
//   TextEditingController days = TextEditingController();
//   TextEditingController catController = TextEditingController();
//   final ImagePicker _picker=ImagePicker();
//   XFile? pickedImageXFile;
//   List<Country>countryList=[];
//
//   Map<String, String> myheaders = {
//  "lang": 'ar',
//   "Content-Type": "application/json",
//     'authorization':'Basic ' +
//         base64Encode(utf8.encode(
//             'user_test:123456'))
//   };
//
//   Future <List<Country>> getAllCountries()async {
//
//
//     emit(GetCountryLoadingState());
//     try{
//       var res = await http.get(Uri.parse(API.Country),headers: myheaders);
//
//       if (res.statusCode == 200) {
//
//         print("API222");
//         print("res======${res.body}");
//         var responseBody = jsonDecode(res.body);
//         if (responseBody["success"] == true) {
//           (responseBody['Data'] as List).forEach((eachRecord) {
//
//             countryList.add(Country.fromJson(eachRecord));
//
//
//           });
//         }
//         emit(GetCountrySuccessState());
//       }
//       else {
//         print("eeee");
//         emit(GetCountryErrorState('error'));
//       }
//
//     }
//     catch(e){
//       print("eeee");
//       emit(GetCountryErrorState('error'));
//
//     }
//     return countryList;
//   }
//
//   void addToBestAds (String id) async{
//
//       try{
//         emit(AddBestLoadingState());
//         var res =await http.post(Uri.parse(API.AddBestAdd,),
//           headers: myheaders,
//           body: {
//           'id':id,
//         },
//         );
//
//         if(res.statusCode==200){
//
//           var responseBody =jsonDecode(res.body);
//
//           if(responseBody["success"]==true) {
//             emit(AddCatSuccessState());
//           }
//
//
//         }
//         else{
//           print(res.statusCode);
//           emit(AddBestErrorState(error: 'error'));
//
//         }
//       }
//       catch(e){
//         print(e.toString());
//         emit(AddBestErrorState(error: '$e'));
//       }
//
//
//
//
//
//   }
//
//   addNewBaka() async {
//     try {
//
//       emit(AddBakaLoadingState());
//       var res = await http.post(Uri.parse(API.AddBaka),
//           headers: myheaders,
//           body:
//       {
//         'details':detailsController.text,
//         'description':desController.text,
//         'name':nameController.text,
//         'price':price.text,
//         'advantages':adv.text,
//         'days':days.text
//       }
//       );
//
//       if (res.statusCode == 200) {
//         var resOfSignUp = jsonDecode(res.body);
//         print(resOfSignUp);
//         if (resOfSignUp['success'] == true) {
//           print("SUCCESS");
//           emit(AddBakaSuccessState());
//         } else {
//           print(res.body);
//           print("error${res.statusCode}");
//           emit(AddBakaErrorState(error: 'not 200'));
//
//         }
//       }
//     } catch (e) {
//       print("ERROR==$e");
//       emit(AddBakaErrorState(error: '$e'));
//
//     }
//   }
//
//   addNewCat() async {
//    try {
//
//      print("IMAGE");
//      print("$imageLink");
//         emit(AddCatLoadingState());
//         var res = await http.post(Uri.parse(API.AddCat),
//             headers: myheaders,
//             body:
//         {
//           'image':imageLink,
//           'name':nameController.text,
//           'cat2':catController.text
//         }
//         );
//
//         if (res.statusCode == 200) {
//           var resOfSignUp = jsonDecode(res.body);
//           print(resOfSignUp);
//           if (resOfSignUp['success'] == true) {
//             print("SUCCESS");
//             emit(AddCatSuccessState());
//           } else {
//             print(res.body);
//             print("error${res.statusCode}");
//             emit(AddCatErrorState(error: 'not 200'));
//
//           }
//         }
//       } catch (e) {
//         print("ERROR==$e");
//         emit(AddCatErrorState(error: '$e'));
//
//     }
//   }
//
//   addNewCountry() async {
//     try {
//
//       emit(AddCountryLoadingState());
//       var res = await http.post(Uri.parse(API.AddCountry),
//           headers: myheaders,
//           body:
//       {
//         'name':nameController.text,
//       }
//       );
//       if (res.statusCode == 200) {
//         var resOfSignUp = jsonDecode(res.body);
//         print(resOfSignUp);
//         if (resOfSignUp['success'] == true) {
//           print("SUCCESS");
//           emit(AddCountrySuccessState());
//         } else {
//           print(res.body);
//           print("error${res.statusCode}");
//           emit(AddCountryErrorState(error: 'not 200'));
//
//         }
//       }
//     } catch (e) {
//       print("ERROR==$e");
//       emit(AddCountryErrorState(error: '$e'));
//     }
//   }
//
//   deleteCountry (String id) async {
//     emit(DeleteCatLoadingState());
//     try {
//       var res =
//       await http.post(Uri.parse(API.DeleteCountry),
//           headers: myheaders,
//           body:
//       {
//         "id":id,
//       }
//       );
//       if (res.statusCode == 200) {
//         print('HERE');
//         var resOfSignUp = jsonDecode(res.body);
//         print(resOfSignUp);
//         if (resOfSignUp['Success'] == true) {
//           emit(DeleteCountrySuccessState());
//         } else {
//           print(res.body);
//           print("error${res.statusCode}");
//           emit(DeleteCountryErrorState( error: 'e',));
//         }
//       }
//     }
//
//     catch (e) {
//       print("ERROR==$e");
//       emit(DeleteCountryErrorState( error: '$e',));
//     }
//   }
//
//   Future<List<Cat>> getAllCat() async {
//     try {
//       emit(getCatLoadingState());
//       var res = await http.get(
//         Uri.parse(API.allCat),
//         headers: myheaders,
//       );
//
//       if (res.statusCode == 200) {
//         print(res.bodyBytes);
//         var responseBody = jsonDecode(res.body);
//         if (responseBody["success"] == true) {
//           print(responseBody['Data']);
//
//           (responseBody['Data'] as List).forEach((eachRecord) {
//             catList.add(Cat.fromJson(eachRecord));
//           });
//           print("List===$catList");
//         }
//         emit(getCatSuccessState());
//       } else {
//         print(res.statusCode);
//         emit(getCatErrorState(error: 'error'));
//       }
//     } catch (e) {
//       print(e.toString());
//       emit(getCatErrorState(error: e.toString()));
//     }
//
//     return catList;
//   }
//
//   Future<List<Baka>> getAllBouquet() async{
//
//     try{
//       emit(getBakaLoadingState());
//       var res =await http.get(Uri.parse(API.bouquet),
//         headers: myheaders,
//       );
//
//       if(res.statusCode==200){
//         print(res.bodyBytes);
//         var responseBody =jsonDecode(res.body);
//         if(responseBody["success"]==true) {
//           print(responseBody['Data']);
//
//           (responseBody['Data']as List).forEach ((eachRecord) {
//
//             bakaList.add(Baka.fromJson(eachRecord));
//
//           });
//           print("BAKA===$bakaList");
//         }
//         emit(getBakaSuccessState());
//       }
//       else{
//         emit(getBakaErrorState(error: 'error'));
//       }
//     }
//     catch(e){
//       emit(getBakaErrorState(error: '$e'));
//     }
//
//     return bakaList;
//   }
//
//   deleteBaka (String id) async {
//
//     emit(DeleteBakaLoadingState());
//     try {
//
//       var res =
//       await http.post(Uri.parse(API.DeleteBaka),
//           headers: myheaders,
//           body:
//       {
//         "id":id,
//       }
//       );
//
//       if (res.statusCode == 200) {
//
//         print('HERE');
//         var resOfSignUp = jsonDecode(res.body);
//         print(resOfSignUp);
//         if (resOfSignUp['Success'] == true) {
//           emit(DeleteBakaSuccessState());
//         } else {
//           print(res.body);
//           print("error${res.statusCode}");
//           emit(DeleteAdErrorState('e'));
//         }
//       }
//     }
//     catch (e) {
//       print("ERROR==$e");
//       emit(DeleteBakaErrorState('$e'));
//     }
//
//
//   }
//
//   deleteCat (String id) async {
//     emit(DeleteCatLoadingState());
//     try {
//       var res =
//       await http.post(Uri.parse(API.DeleteCat), body:
//       {
//         "id":id,
//       }
//       );
//       if (res.statusCode == 200) {
//         print('HERE');
//         var resOfSignUp = jsonDecode(res.body);
//         print(resOfSignUp);
//         if (resOfSignUp['Success'] == true) {
//           emit(DeleteCatSuccessState());
//         } else {
//           print(res.body);
//           print("error${res.statusCode}");
//           emit(DeleteCatErrorState('e'));
//         }
//       }
//     }
//
//     catch (e) {
//       print("ERROR==$e");
//       emit(DeleteBakaErrorState('$e'));
//     }
//
//
//   }
//
//   Future<List<DoctorModel>> getAllDoctors() async {
//     try {
//       emit(GetAllDoctorsLoadingState());
//       var res = await http.get(
//         Uri.parse(API.AdminGetDoctors),
//         headers: myheaders,
//       );
//       if (res.statusCode == 200) {
//         print(res.body);
//         var responseBody = jsonDecode(res.body);
//
//         if (responseBody["success"] == true) {
//           print(responseBody['Data']);
//           (responseBody['Data'] as List).forEach((eachRecord) {
//             doctorList.add(DoctorModel.fromJson(eachRecord));
//           });
//           print("List===$doctorList");
//         }
//         emit(GetAllDoctorsSuccessState());
//       } else {
//         print(res.statusCode);
//         emit(GetAllDoctorsErrorState('error'));
//       }
//     } catch (e) {
//       print("Error===");
//       print(e.toString());
//       emit(GetAllDoctorsErrorState(e.toString()));
//     }
//
//     return doctorList;
//   }
//
//
//   Future<List<Ads>> getAllAds() async {
//
//
//     print("ALL ADS");
//     final box = GetStorage();
//     String country = box.read('country') ?? 'x';
//     print("CCCC$country");
//     try {
//       emit(GetAllAdsLoadingState());
//       var res = await http.get(
//         Uri.parse(API.ads),
//        // headers: myheaders,
//       );
//       print("RES");
//       print(res.body);
//       print(res.statusCode);
//       print(res.headers);
//       print(res.request);
//       if (res.statusCode == 200) {
//         print(res.body);
//         var responseBody = jsonDecode(res.body);
//         print(responseBody);
//         if (responseBody["success"] == true) {
//           print("DATA");
//           print(responseBody['Data']);
//
//           (responseBody['Data'] as List).forEach((eachRecord) {
//             adsList.add(Ads.fromJson(eachRecord));
//           });
//
//           print("Appointment===$adsList");
//         }
//
//         emit(GetAllAdsSuccessState());
//       }
//
//       else {
//
//         print("ERROR HERE1111");
//
//         print("ERRRROORRRRRRRRRRR................");
//
//         print(res.statusCode);
//
//         emit(GetAllAdsErrorState( 'error'));
//       }
//     } catch (e) {
//
//       print("ERROR HERE2222");
//
//       print("ERRRROORRRRRRRRRRR................");
//
//       print(e.toString());
//
//       emit(GetAllAdsErrorState( e.toString()));
//     }
//
//     return adsList;
//   }
//
//   deleteDoctor(String id) async {
//
//     emit(DeleteDoctorsLoadingState());
//     try {
//
//       var res =
//       await http.post(Uri.parse(API.deleteDoctor), body:
//       {
//         "doctor_id":id,
//       }
//       );
//
//       if (res.statusCode == 200) {
//
//         print('HERE');
//         var resOfSignUp = jsonDecode(res.body);
//
//         print(resOfSignUp);
//         if (resOfSignUp['Success'] == true) {
//
//           emit(DeleteDoctorsSuccessState());
//
//         } else {
//
//           print(res.body);
//           print("error${res.statusCode}");
//           emit(DeleteDoctorsErrorState('ERRROR'));
//         }
//       }
//     } catch (e) {
//
//       print("ERROR==$e");
//       emit(DeleteDoctorsErrorState('$e'));
//
//     }
//
//
//   }
//
//   deleteAd(String id) async {
//
//     emit(DeleteAdLoadingState());
//     try {
//
//       var res =
//       await http.post(Uri.parse(API.deleteAd), body:
//       {
//         "id":id,
//       }
//       );
//
//       if (res.statusCode == 200) {
//
//         print('HERE');
//         var resOfSignUp = jsonDecode(res.body);
//         print(resOfSignUp);
//         if (resOfSignUp['Success'] == true) {
//           emit(DeleteAdSuccessState());
//         } else {
//           print(res.body);
//           print("error${res.statusCode}");
//           emit(DeleteAdErrorState('e'));
//         }
//       }
//     }
//     catch (e) {
//       print("ERROR==$e");
//       emit(DeleteAdErrorState('$e'));
//     }
//
//
//   }
//
//   Future<List<Booking>> getAllBooking() async {
//
//
//     try {
//       emit(GetAllBookingLoadingState());
//       var res = await http.get(
//         Uri.parse(API.AllBooking),
//       );
//       print(res.body);
//       if (res.statusCode == 200) {
//         print(res.body);
//         var responseBody = jsonDecode(res.body);
//
//         print(responseBody);
//
//         if (responseBody["success"] == true) {
//           print(responseBody['Data']);
//
//           (responseBody['Data'] as List).forEach((eachRecord) {
//             bookingList.add(Booking.fromJson(eachRecord));
//           });
//
//           print("Booking ===$bookingList");
//         }
//         emit(GetAllBookingSuccessState());
//       } else {
//         print("ERRRROORRRRRRRRRRR................");
//         print(res.statusCode);
//         emit(GetAllBookingErrorState( 'error'));
//       }
//     } catch (e) {
//       print("ERRRROORRRRRRRRRRR................");
//       print(e.toString());
//       emit(GetAllBookingErrorState( e.toString()));
//     }
//
//     return bookingList;
//   }
//
//   showDialogBox(BuildContext context) {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return SimpleDialog(
//             backgroundColor: Colors.white,
//             title: const Custom_Text(
//               text: 'الصورة ',
//               alignment: Alignment.center,
//               fontSize: 19,
//               color: Colors.black,
//             ),
//             children: [
//               SimpleDialogOption(
//                 child: const Custom_Text(
//                   text: 'كاميرا ',
//                   alignment: Alignment.center,
//                   fontSize: 14,
//                   color: Colors.black,
//                 ),
//                 onPressed:(){
//                   captureImage();
//                 },
//               ),
//               SimpleDialogOption(
//                   child: const Custom_Text(
//                     text: ' اختر صورة  ',
//                     alignment: Alignment.center,
//                     fontSize: 14,
//                     color: Colors.black,
//                   ),
//                   onPressed: () {
//                     pickImage();
//                   }),
//               SimpleDialogOption(
//                   child: const Custom_Text(
//                     text: 'الغاء  ',
//                     alignment: Alignment.center,
//                     fontSize: 14,
//                     color: Colors.red,
//                   ),
//                   onPressed: () {
//                     Get.back();
//                   })
//             ],
//           );
//         });
//   }
//
//   captureImage()async{
//     pickedImageXFile= await _picker.pickImage(source: ImageSource.camera);
//     Get.back();
//     pickedImageXFile;
//
//     emit( setImageSuccessState());
//
//     uploadImageToServer();
//   }
//
//   pickImage()async{
//     pickedImageXFile= await _picker.pickImage(source: ImageSource.gallery);
//     Get.back();
//     emit( setImageSuccessState());
//     uploadImageToServer();
//   }
//
//   uploadImageToServer()async {
//     emit(sendImageToServerLoadingState());
//     try {
//       var requestImgurApi = http.MultipartRequest(
//           "POST",
//           Uri.parse("https://api.imgur.com/3/image")
//       );
//
//       String imageName = DateTime
//           .now()
//           .millisecondsSinceEpoch
//           .toString();
//       requestImgurApi.fields['title'] = imageName;
//       requestImgurApi.headers['Authorization'] =
//           "Client-ID " + "fb8a505f4086bd5";
//       //"6ca0d6456311e4d";
//
//       var imageFile = await http.MultipartFile.fromPath(
//         'image',
//         pickedImageXFile!.path,
//         filename: imageName,
//       );
//
//       requestImgurApi.files.add(imageFile);
//       var responseFromImgurApi = await requestImgurApi.send();
//
//       var responseDataFromImgurApi = await responseFromImgurApi.stream
//           .toBytes();
//       var resultFromImgurApi = String.fromCharCodes(responseDataFromImgurApi);
//
//       print("RESULT= = = $resultFromImgurApi");
//
//       Map<String, dynamic> jsonRes = json.decode(resultFromImgurApi);
//       imageLink = (jsonRes["data"]["link"]).toString();
//      // String deleteHash = (jsonRes["data"]["deletehash"]).toString();
//
//       emit(setImageSuccessState());
//     } catch (e) {
//       print(e);
//
//       emit(sendImageToServerErrorState(error: e.toString()));
//     }
//   }
//  }
//
//
//
//
//
//
//
//
//
