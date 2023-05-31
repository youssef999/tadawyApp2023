
import 'dart:convert';
import 'package:doctors_app/domain/models/booking.dart';
import 'package:doctors_app/domain/models/user.dart';
import 'package:doctors_app/presentaion/const/app_message.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:image_picker/image_picker.dart';
import 'package:doctors_app/Data/api_connection/api_connection.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import 'booking_states.dart';


class BookingCubit extends Cubit<BookingStates> {
  BookingCubit() :super(AppIntialState());

  // objects mn nfsy
  static  BookingCubit get(context) => BlocProvider.of(context);
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  List<Booking> bookingList=[];

  addNewBooking(String doctorId,String day,String doctorToken) async {

    String deviceToken='';
   await FirebaseMessaging.instance.getToken().then((token) {
      print("Device Token: $token");
      deviceToken=token!;
    }).catchError((error) {
      print("Error getting device token: $error");
    });


    final box=GetStorage();
    String userId=box.read('userId')??'x';
    DateTime now = DateTime.now();


    if(nameController.text.length<1){
      appMessage(text: 'قم بادخال اسمك بشكل سليم');
    } else if(phoneController.text.length<7){
      appMessage(text: 'قم بادخال رقمك بشكل سليم');
    }
    else if(day.length<1){
      appMessage(text: 'قم باختيار اليوم');
    }
   else if(dayController.text.length<1){
      appMessage(text: 'قم بتحديد الوقت بشكل مناسب ');
    }

    else{
      try {
        emit(AddBookingLoadingState());
        var res = await http.post(Uri.parse(API.addBooking), body: {
          'name':nameController.text,
          'phone':phoneController.text,
          'data': dataController.text,
          'city':cityController.text,
          'token':deviceToken,
          // 'status':'بانتظار الموافقة',
          'day':day,
          'age': ageController.text,
          'time':dayController.text,
          'date':now.toString(),
          'user_id':userId,
          'doctor_id':doctorId
        });

        print("res${res.body}");

        if (res.statusCode == 200) {
          print("200");

          var resOfLogin = jsonDecode((res.body));

          if (resOfLogin['success'] == true) {
            print('TOKKKENEEEEN');
            print(deviceToken);
            emit(AddBookingSuccessState());

            sendNotificationToDoctorNow(
              deviceRegistrationToken: doctorToken,
              docId: doctorId,);
            // Booking doc_Info =  Booking.fromJson(resOfLogin['userData']);
            appMessage(text: 'تم ارسال طلبك بنجاح ');
            print("SUCCESSS");
          }

          else {
            emit(AddBookingErrorState('not 200'));
            appMessage(text: 'حدث خطا حاول مرة اخري ');

          }
        }
        else{
          print(res.statusCode);
        }
      } catch (e) {
        print(e);
        emit(AddBookingErrorState(e.toString()));
        appMessage(text: 'حدث خطا ');

      }
    }


  }

  Future <List<Booking>> getUserBooking()async {

    final box=GetStorage();
    String userId=box.read('userId')??'x';
    emit(getBookingLoadingState());
    try{
      var res = await http.post(Uri.parse(API.getBooking),
          body: {
            'user_id': userId
          }
      );

      if (res.statusCode == 200) {

        print("API222");
        print("res======${res.body}");
        var responseBody = jsonDecode(res.body);
        if (responseBody["success"] == true) {
          (responseBody['Data'] as List).forEach((eachRecord) {

        bookingList.add(Booking.fromJson(eachRecord));

            print("book==${bookingList[0].name}");
          });
        }
        emit(getBookingSuccessState());
      }
      else {
        print("eeee");
        emit(getBookingErrorState('error'));
      }

    }
    catch(e){
      print("CART ERROR == $e");
      emit(getBookingErrorState('$e'));

    }
    return bookingList;
  }

  sendNotificationToDoctorNow
      ({required String deviceRegistrationToken, required String docId, context}) async

  {
    var responseNotification;

    print("DEVICERegToken===="+deviceRegistrationToken);
    print("DEVICERegToken===="+docId);
    //String destinationAddress = userDropOffAddress;
    Map<String, String> headerNotification =
    {
      'Content-Type': 'application/json',
      'Authorization': 'key=AAAALpfB_b0:APA91bHkKX2yOolOrGyBFqLcjXjFsPTZ4IxRw5Q6IsiqgCfwGfPoSIpSRFlp9a04rgQTCAcbI7vKB9DQkydkAnw-oFExoiGRcI6wu-qV--mBvbgMEXvkUcBlZ2azhrgpAHBRUMNO26mT'
      //cloudMessagingServerToken,
    };

    Map bodyNotification =
    {
      "body":"حجز جديد علي التطبيق الان ",
      "title":" المريض بانتظار موافقتك الان  "
    };

    Map dataMap =
    {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "status": "done",
      "rideRequestId": docId
    };

    Map officialNotificationFormat =
    {
      "notification": bodyNotification,
      "data": dataMap,
      "priority": "high",
      "to": deviceRegistrationToken,
     // "sound": "music.mp3"
    };
    try{
      print('try send notification');
      responseNotification = http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: headerNotification,
        body: jsonEncode(officialNotificationFormat),
      ).then((value) {
        print('NOTIFICATION SENT =='+value.toString());
      });
    }
    catch(e){
      print("NOTIFICATION ERROR==="+e.toString());
    }

    return   responseNotification;
  }





}













