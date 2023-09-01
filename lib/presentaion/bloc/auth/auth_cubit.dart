import 'dart:convert';
import 'dart:math';
import 'package:doctors_app/domain/models/coins.dart';
import 'package:doctors_app/domain/models/sales.dart';
import 'package:doctors_app/domain/models/user.dart';
import 'package:doctors_app/domain/models/user_model.dart';
import 'package:doctors_app/presentaion/bloc/auth/auth_states.dart';
import 'package:doctors_app/presentaion/const/app_message.dart';
import 'package:doctors_app/presentaion/views/sales/sales_code.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:firebase_auth/firebase_auth.dart' as fauth;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:doctors_app/Data/api_connection/api_connection.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import '../../resources/assets_manager.dart';
import '../../views/FireBase/otp_view.dart';
import '../../views/User/user_auth/Login.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AppIntialState());

  // objects mn nfsy
  static AuthCubit get(context) => BlocProvider.of(context);




  bool isChecked = false;
  bool isChecked2 = false;

  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  TextEditingController nameController = TextEditingController();
  TextEditingController hospitalCatController = TextEditingController();
  TextEditingController nameController2 = TextEditingController();
  TextEditingController catController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController place2Controller = TextEditingController();
  bool locationButton = false;
  bool option = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneController1 = TextEditingController();
  TextEditingController phoneController2 = TextEditingController();
  TextEditingController phoneController3 = TextEditingController();
  TextEditingController infoController = TextEditingController();
  TextEditingController masterController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordCheck = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController timeControllerX = TextEditingController();
  TextEditingController timeControllerX2 = TextEditingController();
  TextEditingController timeControllerX3 = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController daysController = TextEditingController();
  String smsCode = '';
  String verId = '';
  Coins coins = Coins();
  Sales salesInfo = Sales();

  List<Sales> salesList = [];
  TextEditingController addressController2 = TextEditingController();
  TextEditingController timeController2 = TextEditingController();
  TextEditingController locationController2 = TextEditingController();
  TextEditingController addressController3 = TextEditingController();
  TextEditingController timeController3 = TextEditingController();
  TextEditingController locationController3 = TextEditingController();
  bool x1 = false;
  bool x2 = false;

  // fauth.FirebaseAuth _auth = fauth.FirebaseAuth.instance;
  int toogleIndex = 4;
  DoctorModel doctorModel = DoctorModel();
  User user = User();
  var imageLink = '';
  var imageLink2 = '';
  var imageLink3 = '';
  final ImagePicker _picker = ImagePicker();
  XFile? pickedImageXFile;
  List<XFile>? pickedImageXFiles;
  List<XFile>? pickedImageXFiles2;
  bool isImage = false;
  double lat = 0.0;
  double long = 0.0;
  String country = '';
  String city = '';
  String address = '';
  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  bool _checking = true;
  bool locatate = false;


  TextEditingController clinkName1 = TextEditingController();
  TextEditingController clinkName2 = TextEditingController();
  TextEditingController clinkName3 = TextEditingController();
  TextEditingController clinkPosition1 = TextEditingController();
  TextEditingController clinkPosition2 = TextEditingController();
  TextEditingController clinkPosition3 = TextEditingController();
  TextEditingController clinkPhone1= TextEditingController();
  TextEditingController clinkPhone2= TextEditingController();
  TextEditingController clinkPhone3= TextEditingController();
  TextEditingController clinkPhone4= TextEditingController();
  TextEditingController clinkPhone5= TextEditingController();
  TextEditingController clinkPhone6= TextEditingController();
  TextEditingController clinkPhone7= TextEditingController();
  TextEditingController clinkPhone8= TextEditingController();
  TextEditingController clinkPhone9= TextEditingController();
  TextEditingController salesCode= TextEditingController();

  // PermissionStatus permissionGranted;

  showLoading (BuildContext context) {
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.of(context).pop();
    });

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(bottom:100.0,top:40,left:20,right: 20),
            child: Container(
              height: 320,
              child: Center(
                child: AlertDialog(
                  title: Container(
                      height: 60,
                      child: Image.asset(AssetsManager.Logo)),

                  content: Column(
                    children: [
                      Custom_Text(text: 'جاري تحديد موقعك الان',color:Colors.black,fontSize: 21,alignment:Alignment.center),
                      SizedBox(height: 40,),
                      Center(child: CircularProgressIndicator()),
                    ],
                  ),

                  actions: [


                  ],
                ),
              ),
            ),
          );
        });
  }

  changeCheckBox(bool val)

  {

    isChecked=val;

    emit(ChangeCheckBoxState());

  }

  changeCheckBox2(bool val)

  {

    isChecked2=val;

    emit(ChangeCheckBoxState2());

  }


  loginFaceBook() async {
    emit(FaceLoginLoadingState());
    final LoginResult result = await FacebookAuth.instance.login(
      permissions: [
        'email'
        //, 'public_profile'
      ],
    );

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;

      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
      print("Success");
      print(_userData);
      emit(FaceLoginSuccessState());
      loginWithFaceBook(_userData!['email'],_userData!['id']);
    } else {
      print("FAILED");
      emit(FaceLoginErrorState('error'));
      print(result.status);
      print(result.message);
      print(_userData);
    }
    _checking = false;
  }


  void validateDocEmail(String dropdownValue,String dropdownCatValue,bool sales,int adsNum,int days) async {
    try {
      var res = await http.post(Uri.parse(API.validateDocEmail),
          body: {'doctor_email': emailController.text.trim()});

      print("res==" + res.body.toString());

      if (res.statusCode == 200) {
        var resBodyofValidateEmail = jsonDecode((res.body));
        if (resBodyofValidateEmail['emailFound']) {
          appMessage(text: 'البريد الالكتروني مسجل من قبل');
        } else {
          print("here");

          registerAndSaveUserRecord

            (selectedOption: dropdownValue,
              cat:dropdownCatValue,
              sales:sales,adsNum:adsNum,days:days );
        }
      }
    } catch (e) {
      appMessage(text: '$e');
      print("ERRORxxx::$e");
    }
  }

  void validateDocPhone(String dropdownValue,String dropdownCatValue,bool sales,int adsNum,int days) async {

    print("PHONE");
    final box = GetStorage();
    String country = box.read('countryCode');
    print(phoneController.text);
    String phone;
    if(phoneController.text[0]=='0'){
      phone=country+phoneController.text.replaceFirst('0', '');
    }else{
      phone=country+phoneController.text;
    }
    try {
      var res = await http.post(Uri.parse(API.validateDocPhone),
          body: {'doctor_phone': phone.trim()});

      print("res==" + res.body.toString());

      if (res.statusCode == 200) {
        var resBodyofValidateEmail = jsonDecode((res.body));
        if (resBodyofValidateEmail['emailFound']) {
          appMessage(text: 'الرقم مسجل من قبل');
        } else {
          print("here");

         validateDocEmail(dropdownValue, dropdownCatValue, sales, adsNum, days);
        }
      }
    } catch (e) {
      appMessage(text: '$e');
      print("ERRORxxx::$e");
    }
  }


  void validateUserEmail() async {

    try {
      var res = await http.post(Uri.parse(API.validateEmail),
          body: {'email': emailController.text.trim()});

      print("res==" + res.body.toString());

      if (res.statusCode == 200) {
        var resBodyofValidateEmail = jsonDecode((res.body));
        if (resBodyofValidateEmail['emailFound']) {
          appMessage(text: 'البريد الالكتروني مسجل من قبل');
        } else {
          print("here");
          validateUserPhone();
        }
      }
    } catch (e) {
      appMessage(text: '$e');
      print("ERRORxxx::$e");
    }
  }




  void validateUserPhone() async {

    print("PHONE");
    final box = GetStorage();
    String country = box.read('countryCode');
    print(phoneController.text);
    String phone;
    if(phoneController.text[0]=='0'){
      phone=country+phoneController.text.replaceFirst('0', '');
    }else{
      phone=country+phoneController.text;
    }
    try {
      var res = await http.post(Uri.parse(API.validatePhone),
          body: {'phone':phone.trim()});

      print("resuser phone ==" + res.body.toString());

      if (res.statusCode == 200) {

        var resBodyofValidateEmail = jsonDecode((res.body));

        if (resBodyofValidateEmail['emailFound']) {

          appMessage(text: 'هذا الرقم  مسجل من قبل');
        }
        else {
          print("here");
          userRegister(countryCode: '$country');
        }
      }
    } catch (e) {
      appMessage(text: '$e');
      print("ERRORxxx::$e");
    }
  }



  void googleValidateUserEmail () async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    String email = googleUser!.email;

    try {
      var res =
          await http.post(Uri.parse(API.validateEmail), body: {'email': email});

      print("res==" + res.body.toString());

      if (res.statusCode == 200) {
        var resBodyofValidateEmail = jsonDecode((res.body));
        if (resBodyofValidateEmail['emailFound']) {
          // appMessage(text: 'البريد الالكتروني مسجل من قبل');
          googleSignInMethod();
        } else {
          googleSignInMethod();
        //  googleRegister();
          // print("here");
          // userRegister(countryCode: '$country');
        }
      }
    } catch (e) {
      FaceValidateUserEmail ();
     // appMessage(text: '$e');
      print("ERRORxxx::$e");
    }
  }


  void FaceValidateUserEmail () async {

    emit(FaceLoginLoadingState());
    final LoginResult result = await FacebookAuth.instance.login(
      permissions: [
        'email'
      ],
    );
    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;
      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
      print("Success");
      print(_userData);
      emit(FaceLoginSuccessState());
    } else {
      print("FAILED");
      emit(FaceLoginErrorState('error'));
      print(result.status);
      print(result.message);
      print(_userData);
    }
    _checking = false;

    try {
      var res =
      await http.post(Uri.parse(API.validateEmail), body: {'email':_userData!['email']});

      print("res==" + res.body.toString());

      if (res.statusCode == 200) {
        var resBodyofValidateEmail = jsonDecode((res.body));
        if (resBodyofValidateEmail['emailFound']) {
          // appMessage(text: 'البريد الالكتروني مسجل من قبل');
         loginFaceBook();
        } else {
         // loginFaceBook();
          FaceRegister(
              _userData!['email'],
              _userData!['name'],
              _userData!['id']
          );
          // print("here");
          // userRegister(countryCode: '$country');
        }
      }
    } catch (e) {

      googleValidateUserEmail ();
      //appMessage(text: '$e');
      print("ERRORxxx::$e");
    }
  }

  void googleRegister() async {
    print("REG");
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    String email = googleUser!.email;
    String name = googleUser.displayName.toString();
    String password = googleUser.id.toString();
    String phone = '';
    googleRegister2(email: email, name: name, password: password, phone: phone);
  }

  void FaceRegister(String email,String name,String pass) async {


    faceRegister2(email: email, name: name, password: pass, phone: '');
  }

  faceRegister2(
      {required String email,
        required String name,
        required String phone,
        required String password}) async {

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission();


    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Permission granted');
    } else {
      print('Permission denied');
    }
    String? deviceToken = await FirebaseMessaging.instance.getToken();

    try {
      emit(GoogleRegisterLoadingState());
      var res = await http.post(Uri.parse(API.userSignup), body: {
        "email": email,
        "password": password,
        "name": name,
        'token':deviceToken!,
        "phone": phone
      });

      if (res.statusCode == 200) {
        var resOfSignUp = jsonDecode(res.body);

        print(resOfSignUp);
        if (resOfSignUp['Success'] == true) {
          emit(GoogleRegisterSuccessState());

          //registerInFireBase(type: 'user',countryCode: countryCode);
          autoLogin(email, password);


        } else {
          print(res.body);
          print("error${res.statusCode}");
          emit(GoogleRegisterErrorState('not 200'));
        }
      }
    } catch (e) {
      print("ERROR==$e");
      emit(GoogleRegisterErrorState(e.toString()));
    }
  }

  googleRegister2(
      {required String email,
      required String name,
      required String phone,
      required String password}) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission();


    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Permission granted');
    } else {
      print('Permission denied');
    }
    String? deviceToken = await FirebaseMessaging.instance.getToken();
    try {
      emit(GoogleRegisterLoadingState());
      var res = await http.post(Uri.parse(API.userSignup), body: {
        "email": email,
        "password": password,
        "name": name,
        "phone": phone,
        "token":deviceToken!,
      });

      if (res.statusCode == 200) {
        var resOfSignUp = jsonDecode(res.body);

        print(resOfSignUp);
        if (resOfSignUp['Success'] == true) {
          emit(GoogleRegisterSuccessState());

          //registerInFireBase(type: 'user',countryCode: countryCode);

          autoLogin(emailController.text, passwordController.text);
        } else {
          print(res.body);
          print("error${res.statusCode}");
          emit(GoogleRegisterErrorState('not 200'));
        }
      }
    } catch (e) {
      print("ERROR==$e");
      emit(GoogleRegisterErrorState(e.toString()));
    }
  }

  void googleSignInMethod() async {

    emit(GoogleLoginLoadingState());
    final GoogleSignInAccount? googleUser = await googleSignIn
        .signIn()
        .then((value) {
          print("vvv=$value");

          print("id==" + value!.id);

          emit(GoogleLoginSuccessState());
          loginWithGoogle(value.email.toString(), value.id);
        })
        .catchError(onError)
        .then((value) {
          print("ERRRORR==="+onError.toString());
          emit(GoogleLoginErrorState(onError.toString()));
        });
    print(googleUser);
  }

  Future<void> getData() async {


    // bool serviceEnabled=await Geolocator.isLocationServiceEnabled();
    // if(!serviceEnabled){
    //   appMessage(text: '');
    // }
    LocationPermission permission=await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission=await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {

      permission=await Geolocator.requestPermission();
      // The user has previously denied the request permanently.
      // You might want to handle this case specifically.
     // return;
    }


    print("HERE");
    Future.delayed(Duration(seconds: 4)).then((value) async {
      try {
        emit(GetLocationLoadingState());
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
        );

        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        Placemark placemark = placemarks.first;
        // print(placemark);
        // print(position.longitude);
        // print(position.latitude);
        lat = position.latitude;
        long = position.longitude;
        emit(GetLocationSuccessState());
        country = placemark.country!;
        city = placemark.locality!;

        address = placemark.street.toString();
        locatate = true;
        appMessage(text: 'تم تحديد موقعك بنجاح');
        emit(GetLocationSuccessState());
      } catch (e) {
        print(e);
        appMessage(text: '$e');
      }
    });

  }

  changeToogleIndex(int index) {
    toogleIndex = index;
    emit(ChangeToogleIndexSuccessState());
  }

  changeLocationButton() {
    locationButton = true;
    emit(ChangeButtonLocationSuccessState());
  }

  removeNew() {
    x1 = false;
    emit(removeNewSuccess());
  }

  removeNew2() {
    x2 = false;
    emit(removeNewSuccess2());
  }

  addNew() {
    x1 = true;
    emit(addNewSuccess());
  }

  addNew2() {
    x2 = true;
    emit(addNewSuccess2());
  }

  registerAndSaveUserRecord(
      {required String selectedOption,
      required bool sales,
        required String cat,
      required int adsNum,
      required int days}) async {
    final box = GetStorage();
    String country = box.read('country') ?? 'x';
    String countryCode = box.read('countryCode') ?? 'x';

    String p='';
    bool paid=true;


    if(sales==true) {
      paid=false;
    }
    else{
      paid=true;
    }

    if(phoneController.text.startsWith('0')){
      p=phoneController.text.replaceFirst('0', '');
    }else{
      p=phoneController.text;
    }
    if (emailController.text.contains('@') == false) {
      appMessage(text: 'البريد الاكتروني خاطئ');
    } else if (passwordController.text.length < 6) {
      appMessage(text: 'كلمة السر يجب ان تساوي او تزيد عن  6 احرف');
    }

    else {

      try {
        print("days=="+daysController.text);
        String deviceToken='';
        await FirebaseMessaging.instance.getToken().then((token) {
          print("Device Token: $token");
          deviceToken=token!;
        }).catchError((error) {
          print("Error getting device token: $error");
        });
        print(lat);
        emit(RegisterLoadingState());
        var res = await http.post(Uri.parse(API.signup), body: {

          'delivery':isChecked.toString(),
          'fullService':isChecked2.toString(),
          'hospitalCat':hospitalCatController.text,
          'paid':paid.toString(),
          'clink_name1':clinkName1.text.trim()??"",
          'clink_name2':clinkName2.text.trim()??"",
          'clink_name3':clinkName3.text.trim(),
          'token':deviceToken,
          'clink_p1':clinkPosition1.text.trim()??'',
          'clink_p2':clinkPosition2.text.trim(),
          'clink_p3':clinkPosition3.text.trim(),
          'clink_phone1':clinkPhone1.text.trim(),
          'clink_phone2':clinkPhone2.text.trim(),
          'clink_phone3':clinkPhone3.text.trim(),
          'clink_phone4':clinkPhone4.text.trim(),
          'clink_phone5':clinkPhone5.text.trim(),
          'clink_phone6':clinkPhone6.text.trim(),
          'clink_phone7':clinkPhone7.text.trim(),
          'clink_phone8':clinkPhone8.text.trim(),
          'clink_phone9':clinkPhone9.text.trim(),
          "doctor_email": emailController.text.trim(),
          'free_ads': adsNum.toString(),
          'ads_days': days.toString(),
          "days":daysController.text,
          "doctor_password": passwordController.text.trim(),
          "doctor_name": nameController.text.trim()??"",
          "doctor_cat": cat,
          "doctor_info": infoController.text.trim(),
          "doctor_masters": masterController.text.trim(),
          "doctor_degree": degreeController.text.trim(),
          "price": priceController.text.trim(),
          "doctor_phone": countryCode+p.trim(),
          "doctor_image": imageLink,
          "image1": imageLink2,
          "image2": imageLink3,
          'place': placeController.text.trim(),
          'place2': place2Controller.text.trim(),
          'cat2': selectedOption,
          "address1": addressController.text,
          "address2": addressController2.text,
          "address3": addressController3.text,
          "time1": timeController.text,
           "time1x": timeControllerX.text??'',
          "time2": timeController2.text??"",
           "time2x": timeControllerX2.text??"",
          "time3": timeController3.text,
           "time3x": timeControllerX.text,
          "lat": lat.toString()??"",
          "lng": long.toString()??"",
          'country': country
        });

        if (res.statusCode == 200) {
          var resOfSignUp = jsonDecode(res.body);
          print(resOfSignUp);
          if (resOfSignUp['Success'] == true) {
            print("SUCCESS");
            emit(RegisterSuccessState());

            if (sales == true) {
             print("Sales login");
             // SalesCoins('login');
            }
          } else {
            print(res.statusCode);
            print("error${res.body}");
            emit(RegisterErrorState('not 200'));
          }
        }
      } catch (e) {
        print("ERRORxxxxxxxxx==$e");
        emit(RegisterErrorState(e.toString()));
      }
    }
  }



  void registerInFireBase(
      {required String type, required String countryCode}) async {
    emit(OtpFirebaseLoadingState());
    print("OTP FIRE REG");
    if (phoneController.text.toString()[0] == '0') {
      try {
        await fauth.FirebaseAuth.instance
            .verifyPhoneNumber(
              phoneNumber:
                  countryCode + phoneController.text.replaceFirst('0', ''),
              verificationCompleted: (fauth.PhoneAuthCredential credential) {},
              verificationFailed: (fauth.FirebaseAuthException e) {},
              codeSent: (String verificationId, int? resendToken) {
                emit(OtpFireSuccessState());
                print(verificationId);
                print("kkkkkvvvvvvvv");
                smsCode = verificationId;

                Get.to(OtpView(
                  verId: verificationId,
                  type: type,
                ));
              },
              codeAutoRetrievalTimeout: (String verificationId) {},
            )
            .catchError(onError)
            .then((value) {
          emit(OtpFirebaseErrorState('eeeVVVCCC'));
          Future.delayed(Duration(seconds: 3)).then((value) {
            print("ONERROORRRR");
            // Get.off(UserLoginView(cat: 'user'));
          });
        });
      } catch (e) {
        emit(OtpFirebaseErrorState(e.toString()));
        appMessage(text: '');
        print("$e");
      }
    } else {
      try {
        await fauth.FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: countryCode + phoneController.text,
          verificationCompleted: (fauth.PhoneAuthCredential credential) {},
          verificationFailed: (fauth.FirebaseAuthException e) {
            //Get.to(UserLoginView(cat: 'user'));
          },
          codeSent: (String verificationId, int? resendToken) {
            emit(OtpFireSuccessState());
            print(verificationId);
            print("kkkkkvvvvvvvv");
            smsCode = verificationId;

            if (smsCode == '') {}
            Get.to(OtpView(
              verId: verificationId,
              type: type,
            ));
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            //Get.to(UserLoginView(cat: 'user'));
          },
        );
      } catch (e) {
        emit(OtpFirebaseErrorState(e.toString()));

        //  Get.off(UserLoginView(cat: 'user'));

        appMessage(text: '');
        print("$e");
      }
    }
  }

  addNewFilter() async {
    final box = GetStorage();
    String country = box.read('country') ?? 'x';
    emit(AddNewFilterLoadingState());
    try {
      var res = await http.post(Uri.parse(API.AddFilters),
          body: {'name': catController.text, 'country': country});

      print("res======== ${res.body}");

      if (res.statusCode == 200) {
        print("200");

        var resOfLogin = jsonDecode((res.body));

        if (resOfLogin['success'] == true) {
          print("SUCCESSS");
          emit(AddNewFilterSuccessState());
        } else {
          emit(AddNewFilterErrorState('not 200'));
        }
      } else {
        print(res.statusCode);
      }
    } catch (e) {
      print(e);
      emit(AddNewFilterErrorState('$e'));
    }
  }

  addNewPlaces() async {
    final box = GetStorage();
    String country = box.read('country') ?? 'x';
    String c2 = box.read('c2') ?? 'x';
    emit(AddNewPlacesLoadingState());
    try {
      var res = await http.post(Uri.parse(API.AddPlaces),
          body: {'name': c2, 'country': country});

      print("res======== ${res.body}");

      if (res.statusCode == 200) {
        print("200");

        var resOfLogin = jsonDecode((res.body));

        if (resOfLogin['success'] == true) {
          print("SUCCESSS");
          emit(AddNewPlacesSuccessState());
          // Future.delayed(Duration(seconds: 2)).then((value) {
          //   addNewPlaces2();
          // });
        } else {
          emit(AddNewPlacesErrorState('not 200'));
        }
      } else {
        print(res.statusCode);
      }
    } catch (e) {
      print(e);
      emit(AddNewPlacesErrorState('$e'));
    }
  }

  addNewPlaces2() async {
    final box = GetStorage();
    String c2 = box.read('c2') ?? 'x';
    emit(AddNewPlacesLoadingState2());
    try {
      var res = await http.post(Uri.parse(API.AddPlaces2),
          body: {'name': place2Controller.text, 'place': placeController.text});

      print("res======== ${res.body}");

      if (res.statusCode == 200) {
        print("200");

        var resOfLogin = jsonDecode((res.body));

        if (resOfLogin['success'] == true) {
          print("SUCCESSS");
          emit(AddNewPlacesSuccessState2());
        } else {
          emit(AddNewPlacesErrorState2('error'));
        }
      } else {
        print(res.statusCode);
      }
    } catch (e) {
      print(e);
      emit(AddNewPlacesErrorState2('$e'));
    }
  }

  SalesCoins(String type) async {

    final box = GetStorage();
    // var id = box.read('SalesId');
    String coins = box.read('SalesCoins');
    int loginCoins = box.read('loginCoins');
    int systemCoins = box.read('systemCoins');
    int adsCoins = box.read('adsCoins');
    int c = int.parse(coins);
    //int cLogin=int.parse(loginCoins);
    int c2 = 0;
    String c3 = '';
    if (type == 'login') {
      c2 = c + loginCoins;
      c3 = c2.toString();
    } else if (type == 'system') {
      c2 = c + systemCoins;
      c3 = c2.toString();
    } else if (type == 'ads') {
      c2 = c + adsCoins;
      c3 = c2.toString();
    }

    print('COINS==' + coins.toString());
    // print('ID==' + id.toString());
    print('NEW COINS==' + c3);
    try {
      emit(SalesCoinsLoadingState());
      var res = await http
          .post(Uri.parse(API.SalesCoins), body: { 'code': salesCode.text, 'coins': c3});

      if (res.statusCode == 200) {
        var resOfSignUp = jsonDecode(res.body);
        print(resOfSignUp);
        if (resOfSignUp['success'] == true) {
          print("SUCCESS");
          emit(SalesCoinsSuccessState());
        } else {
          print(res.body);
          print("error${res.statusCode}");
          emit(SalesCoinsErrorState('not 200'));
        }
      }
    } catch (e) {
      print("ERROR==$e");
      emit(SalesCoinsErrorState('$e'));
    }
  }

  salesLogin() async {
    emit(SalesLoginLoadingState());
    try {
      var res = await http.post(Uri.parse(API.SalesLogin), body: {
        'code': code.text.trim(),
      });

      print("res======== ${res.body}");

      if (res.statusCode == 200) {
        print("200");

        var resOfLogin = jsonDecode((res.body));

        if (resOfLogin['success'] == true) {
          print("SALES INfo==== ${resOfLogin["Data"]["id"]}");
          final box = GetStorage();
          box.write('SalesId', resOfLogin["Data"]["id"]);
          box.write('SalesCoins', resOfLogin["Data"]["coins"]);
          box.write('SalesName', resOfLogin["Data"]["name"]);
          print("SUCCESSS");
          emit(SalesLoginSuccessState());

        } else {
          emit(SalesLoginErrorState('not 200'));
        }
      } else {
        print(res.statusCode);
      }
    } catch (e) {
      print(e);
      emit(SalesLoginErrorState('$e'));
    }
  }

  systemBooking() async {
    emit(SalesSystemLoadingState());
    try {
      var res = await http.post(Uri.parse(API.SystemBooking), body: {
        'doctor_name': nameController.text.trim(),
        'doctor_phone': phoneController.text.trim(),
        'price': priceController.text.trim(),
        'notes': notesController.text.trim(),
      });

      print("res======== ${res.body}");

      if (res.statusCode == 200) {
        print("200");

        var resOfLogin = jsonDecode((res.body));

        if (resOfLogin['Success'] == true) {
          emit(SalesSystemSuccessState());
        //  SalesCoins('system');
        } else {
          emit(SalesSystemErrorState('not 200'));
        }
      } else {
        print(res.statusCode);
      }
    } catch (e) {
      print(e);
      emit(SalesSystemErrorState('$e'));
    }
  }

  getCoins() async {
    emit(GetCoinsLoadingState());
    try {
      var res = await http.get(Uri.parse(API.Coins));

      print("res Sales Data ======== ${res.body}");

      if (res.statusCode == 200) {
        print("200");
        var resOfLogin = jsonDecode((res.body));

        if (resOfLogin['success'] == true) {
          coins = Coins.fromJson(resOfLogin['Data']);

          final box = GetStorage();
          box.write('adsCoins', coins.ads);
          box.write('systemCoins', coins.system);
          box.write('loginCoins', coins.login);

          emit(GetCoinsSuccessState());
        } else {
          emit(GetCoinsErrorState('not 200'));
        }
      } else {
        print(res.statusCode);
      }
    } catch (e) {
      print(e);
      emit(GetCoinsErrorState('$e'));
    }
  }

  getSalesData() async {
    final box = GetStorage();
    String id = box.read('SalesId') ?? 'x';

    emit(SalesDataLoadingState());
    try {
      var res = await http.post(Uri.parse(API.SalesData), body: {
        'id': id,
      });

      print("res Sales Data ======== ${res.body}");

      if (res.statusCode == 200) {
        print("200");

        var resOfLogin = jsonDecode((res.body));

        if (resOfLogin['success'] == true) {
          salesInfo = Sales.fromJson(resOfLogin['Data']);
          final box = GetStorage();
          box.write('SalesId', resOfLogin["Data"]["id"]);
          box.write('SalesCoins', resOfLogin["Data"]["coins"]);
          box.write('SalesName', resOfLogin["Data"]["name"]);
          print("SALES");
          print(salesInfo.coins);
          print("UserINfo====${salesInfo.id}");
          emit(SalesDataSuccessState());
        } else {
          emit(SalesDataErrorState('not 200'));
        }
      } else {
        print(res.statusCode);
      }
    } catch (e) {
      print(e);
      emit(SalesDataErrorState('$e'));
    }
  }

  loginDoctorWithPhone() async {
    emit(LoginLoadingState());

    try {
      var res = await http.post(Uri.parse(API.DoctorPhoneLogin), body: {
        'doctor_phone': phoneController.text.trim(),
        'doctor_password': passwordController.text.trim(),
      });

      print("res${res.body}");

      if (res.statusCode == 200) {
        print("200");

        var resOfLogin = jsonDecode((res.body));

        if (resOfLogin['success'] == true) {

          DoctorModel doc_Info = DoctorModel.fromJson(resOfLogin['userData']);
          print("UserINfo====${doc_Info.doctor_email}");

          final box = GetStorage();

          box.write('doc_email', doc_Info.doctor_email);
          box.write('doc_Id', doc_Info.doctor_id);

          print("SUCCESSS");
          emit(LoginSuccessState());
        } else {
          emit(LoginErrorState('not 200'));
        }
      } else {
        print(res.statusCode);
      }
    } catch (e) {
      print(e);
      emit(LoginErrorState(e.toString()));
    }
  }

  login() async {
    emit(LoginLoadingState());

    try {
      var res = await http.post(Uri.parse(API.login), body: {
        'doctor_email': emailController.text.trim(),
        'doctor_password': passwordController.text.trim(),
      });

      print("res${res.body}");

      if (res.statusCode == 200) {
        print("200");

        var resOfLogin = jsonDecode((res.body));

        if (resOfLogin['success'] == true) {
          print("SUCCESS");
      //    DoctorModel doc_Info = DoctorModel.fromJson(resOfLogin['userData']);
       //   print("UserINfo====${doc_Info.doctor_email}");

          final box = GetStorage();

          box.write('doc_email', resOfLogin['userData']['doctor_email']);
          box.write('doc_Id', resOfLogin['userData']['doctor_id']);

          print("SUCCESSS");
          emit(LoginSuccessState());
        } else {
          emit(LoginErrorState('not 200'));
        }
      } else {
        print(res.statusCode);
      }
    } catch (e) {
      print(e);
      emit(LoginErrorState(e.toString()));
    }
  }

  Future<fauth.UserCredential> signInWithFacebook() async {
    print("FACE");
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final fauth.OAuthCredential facebookAuthCredential
    = fauth.FacebookAuthProvider.credential(loginResult.accessToken!.token);
    // Once signed in, return the UserCredential
    return fauth.FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  userRegister({required String countryCode}) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission();


    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Permission granted');
    } else {
      print('Permission denied');
    }
    String? deviceToken = await FirebaseMessaging.instance.getToken();
    try {
      String phone = '';
      if (countryCode == '+20') {
        phone = countryCode + phoneController.text.trim().replaceFirst('0', '');
      } else {
        phone = countryCode + phoneController.text.trim();
      }

      emit(UserRegisterLoadingState());
      var res = await http.post(Uri.parse(API.userSignup), body: {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "name": nameController.text.trim(),
        "phone": phone,
        "token":deviceToken!
      });

      if (res.statusCode == 200) {
        var resOfSignUp = jsonDecode(res.body);

        print(resOfSignUp);
        if (resOfSignUp['Success'] == true) {

          emit(UserRegisterSuccessState());

          Future.delayed(Duration(seconds: 2)).then((value)=>
          //  autoLogin(email, password)
          userLogin()
            // Get.offAll(UserLoginView(cat: 'user'))
          );
          registerInFireBase(type: 'user', countryCode: countryCode);

          autoLogin(emailController.text, passwordController.text);

          option = true;
        } else {
          print(res.body);
          print("error${res.statusCode}");
          emit(UserRegisterErrorState('not 200'));
        }
      }
    } catch (e) {
      print("ERROR==$e");
      emit(UserRegisterErrorState(e.toString()));
    }
  }

  autoLogin(String email, String password) async {
    if (emailController.text == 'sales@gmail.com' &&
        passwordController.text == '123456') {
      Get.offAll(SalesCodeView());
    } else {
      emit(UserLoginLoadingState());

      try {
        var res = await http.post(Uri.parse(API.userLogin),
            body: {'email': email, 'password': password});

        print("res${res.body}");

        if (res.statusCode == 200) {
          print("200");

          var resOfLogin = jsonDecode((res.body));

          if (resOfLogin['success'] == true) {
            user = User.fromJson(resOfLogin['userData']);

            print("UserINfo====${user.email}");
            final box = GetStorage();
            box.write('email', user.email);
            box.write('userName', user.name);
            box.write('userId', user.id);
            print(user.id);

            print("SUCCESSS");
            // appMessage(text: 'تم تسجيل الدخول بنجاح');

            emit(UserLoginSuccessState());

          } else {
            emit(UserLoginErrorState('not 200'));
          }
        } else {
          print(res.statusCode);
        }
      } catch (e) {
        print(e);
        emit(UserLoginErrorState(e.toString()));
      }
    }
  }

  autoLogin2(String email, String password) async {
    if (emailController.text == 'sales@gmail.com' &&
        passwordController.text == '123456') {
      Get.offAll(SalesCodeView());
    } else {
      emit(UserLoginLoadingState());

      try {
        var res = await http.post(Uri.parse(API.userLogin),
            body: {'email': email, 'password': password});

        print("res${res.body}");

        if (res.statusCode == 200) {
          print("200");

          var resOfLogin = jsonDecode((res.body));

          if (resOfLogin['success'] == true) {
            user = User.fromJson(resOfLogin['userData']);

            print("UserINfo====${user.email}");
            final box = GetStorage();
            box.write('email', user.email);
            box.write('userName', user.name);
            box.write('userId', user.id);
            print(user.id);

            print("SUCCESSS");
            // appMessage(text: 'تم تسجيل الدخول بنجاح');

            emit(UserLoginSuccessState2());
          } else {
            emit(UserLoginErrorState('not 200'));
          }
        } else {
          print(res.statusCode);
        }
      } catch (e) {
        print(e);
        emit(UserLoginErrorState(e.toString()));
      }
    }
  }

  loginWithGoogle(String email, String pass) async {
    if (emailController.text == 'sales@gmail.com' &&
        passwordController.text == '123456') {
      Get.offAll(SalesCodeView());
    } else {
      emit(UserLoginLoadingState());

      try {
        var res = await http.post(Uri.parse(API.userLogin), body: {
          'email': email,
          'password': pass,
        });

        print("res${res.body}");

        if (res.statusCode == 200) {
          print("200");

          var resOfLogin = jsonDecode((res.body));

          if (resOfLogin['success'] == true) {
            user = User.fromJson(resOfLogin['userData']);

            print("UserINfo====${user}");
            final box = GetStorage();
            box.write('email', user.email);
            box.write('userName', user.name);
            box.write('userId', user.id);
            print(user.id);

            print("SUCCESSS");
            // appMessage(text: 'تم تسجيل الدخول بنجاح');

            emit(UserLoginSuccessState());
          } else {
            emit(UserLoginErrorState('not 200'));
          }
        } else {
          print(res.statusCode);
        }
      } catch (e) {
        print(e);
        emit(UserLoginErrorState(e.toString()));
      }
    }
  }


  loginWithFaceBook(String email, String pass) async {
    if (emailController.text == 'sales@gmail.com' &&
        passwordController.text == '123456') {
      Get.offAll(SalesCodeView());
    } else {
      emit(UserLoginLoadingState());
      try {
        var res = await http.post(Uri.parse(API.userLogin), body: {
          'email': email,
          'password': pass,
        });

        print("res${res.body}");

        if (res.statusCode == 200) {
          print("200");

          var resOfLogin = jsonDecode((res.body));

          if (resOfLogin['success'] == true) {

            user = User.fromJson(resOfLogin['userData']);
            print("UserINfo====${user}");
            final box = GetStorage();
            box.write('email', user.email);
            box.write('userName', user.name);
            box.write('userId', user.id);
            print(user.id);

            print("SUCCESSS");
            // appMessage(text: 'تم تسجيل الدخول بنجاح');

            emit(UserLoginSuccessState());
          } else {
            emit(UserLoginErrorState('not 200'));
          }
        } else {
          print(res.statusCode);
        }
      } catch (e) {
        print(e);
        emit(UserLoginErrorState(e.toString()));
      }
    }
  }


  userLogin() async {
    if (emailController.text == 'sales@gmail.com' &&
        passwordController.text == '123456') {
      Get.offAll(SalesCodeView());
    } else {
      emit(UserLoginLoadingState());

      try {
        var res = await http.post(Uri.parse(API.userLogin), body: {
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
        });

        print("res="+res.body.toString()+"xxxxxxxxxxxxxxxx");

        if (res.statusCode == 200) {
          print("200");

          var resOfLogin = jsonDecode((res.body));

          if (resOfLogin['success'] == true) {
            print("SUCCESS");

            user = User.fromJson(resOfLogin['userData']);

            print("UserINfo====${user.email}");
            final box = GetStorage();
            box.write('email', user.email);
            box.write('userName', user.name);
            box.write('userId', user.id);
            print(user.id);

            print("SUCCESSS");
            // appMessage(text: 'تم تسجيل الدخول بنجاح');

            emit(UserLoginSuccessState());


          } else {
            emit(UserLoginErrorState('not 200'));
          }
        } else {
          print(res.statusCode);
        }
      } catch (e) {
        print(e);
        emit(UserLoginErrorState(e.toString()));
      }
    }
  }

  userLoginWithPhone() async {
    final box=GetStorage();
    String countryCode=box.read('countryCode');
    String p='';
    if(phoneController.text.startsWith('0')){
      p=phoneController.text.replaceFirst('0', '');
    }else{
      p=phoneController.text;
    }
    if (emailController.text == 'sales@gmail.com' &&
        passwordController.text == '123456') {
      Get.offAll(SalesCodeView());
    } else {
      emit(UserLoginLoadingState());

      try {
        var res = await http.post(Uri.parse(API.UserPhoneLogin), body: {
          'phone': countryCode+p.trim(),
          'password': passwordController.text.trim(),
        });

        print("res${res.body}");

        if (res.statusCode == 200) {
          print("200");

          var resOfLogin = jsonDecode((res.body));

          if (resOfLogin['success'] == true) {
            user = User.fromJson(resOfLogin['userData']);

            print("UserINfo====${user.email}");
            final box = GetStorage();
            box.write('email', user.email);
            box.write('userName', user.name);
            box.write('userId', user.id);
            print(user.id);

            print("SUCCESSS");
            // appMessage(text: 'تم تسجيل الدخول بنجاح');

            emit(UserLoginSuccessState());
          } else {
            emit(UserLoginErrorState('not 200'));
          }
        } else {
          print(res.statusCode);
        }
      } catch (e) {
        print(e);
        emit(UserLoginErrorState(e.toString()));
      }
    }
  }

  showDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: Colors.white,
            title: const Custom_Text(
              text: 'الصورة ',
              alignment: Alignment.center,
              fontSize: 19,
              color: Colors.black,
            ),
            children: [
              SimpleDialogOption(
                child: const Custom_Text(
                  text: 'كاميرا ',
                  alignment: Alignment.center,
                  fontSize: 14,
                  color: Colors.black,
                ),
                onPressed: () {
                  captureImage();
                },
              ),
              SimpleDialogOption(
                  child: const Custom_Text(
                    text: ' اختر صورة  ',
                    alignment: Alignment.center,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    pickImage();
                  }),
              SimpleDialogOption(
                  child: const Custom_Text(
                    text: 'الغاء  ',
                    alignment: Alignment.center,
                    fontSize: 14,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Get.back();
                  })
            ],
          );
        });
  }

  multiShowDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: Colors.white,
            title: const Custom_Text(
              text: 'الصورة ',
              alignment: Alignment.center,
              fontSize: 19,
              color: Colors.black,
            ),
            children: [

              SimpleDialogOption(
                  child: const Custom_Text(
                    text: ' اختر صورة  ',
                    alignment: Alignment.center,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    pickMultiImage();
                  }),
              SimpleDialogOption(
                  child: const Custom_Text(
                    text: 'الغاء  ',
                    alignment: Alignment.center,
                    fontSize: 14,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Get.back();
                  })
            ],
          );
        });
  }

  captureImage() async {
    pickedImageXFile = await _picker.pickImage(source: ImageSource.camera);
    Get.back();
    pickedImageXFile;

    emit(setImageSuccessState());

    uploadImageToServer();
  }

  pickImage() async {
    pickedImageXFile = await _picker.pickImage(source: ImageSource.gallery);
   // Get.back();
    emit(setImageSuccessState());
    uploadImageToServer();
  }

  pickMultiImage() async {
    pickedImageXFiles = await _picker.pickMultiImage(
      imageQuality: 100,
    );
    isImage = true;
    // if(pickedImageXFiles!.isEmpty){
    //   pickedImageXFiles.add();
    // }
    //Get.back();
    emit(setImageSuccessState());
    uploadMultiImageToServer();
  }

  pickMultiImage2() async {
    pickedImageXFiles2 = await _picker.pickMultiImage(
      imageQuality: 100,
    );
    isImage = true;
    // if(pickedImageXFiles!.isEmpty){
    //   pickedImageXFiles.add();
    // }
  //  Get.back();
    emit(setImageSuccessState());
    uploadMultiImageToServer2();
  }

  uploadImageToServer() async {
    emit(sendImageToServerLoadingState());
    try {
      var requestImgurApi = http.MultipartRequest(
          "POST", Uri.parse("https://api.imgur.com/3/image"));

      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      requestImgurApi.fields['title'] = imageName;
      requestImgurApi.headers['Authorization'] =
          "Client-ID " + "fb8a505f4086bd5";
      //"6ca0d6456311e4d";

      var imageFile = await http.MultipartFile.fromPath(
        'image',
        pickedImageXFile!.path,
        filename: imageName,
      );

      requestImgurApi.files.add(imageFile);
      var responseFromImgurApi = await requestImgurApi.send();

      var responseDataFromImgurApi =
          await responseFromImgurApi.stream.toBytes();
      var resultFromImgurApi = String.fromCharCodes(responseDataFromImgurApi);

      print("RESULT= = = $resultFromImgurApi");

      Map<String, dynamic> jsonRes = json.decode(resultFromImgurApi);
      imageLink = (jsonRes["data"]["link"]).toString();

      emit(setImageSuccessState());
    } catch (e) {
      print(e);

      emit(sendImageToServerErrorState(error: e.toString()));
    }
  }

  uploadMultiImageToServer() async {
    emit(sendImageToServerLoadingState());
    try {
      var requestImgurApi = http.MultipartRequest(
          "POST", Uri.parse("https://api.imgur.com/3/image"));

      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      requestImgurApi.fields['title'] = imageName;
      requestImgurApi.headers['Authorization'] =
          "Client-ID " + "fb8a505f4086bd5";
      //"6ca0d6456311e4d";

      var imageFile = await http.MultipartFile.fromPath(
        'image',
        pickedImageXFiles!.first.path,
        filename: imageName,
      );
      // var imageFile2 = await http.MultipartFile.fromPath(
      //   'image',
      //   pickedImageXFiles!.last.path,
      //   filename: imageName,
      // );

      requestImgurApi.files.add(imageFile);
      // requestImgurApi.files.add(imageFile2);

      var responseFromImgurApi = await requestImgurApi.send();

      var responseDataFromImgurApi =
          await responseFromImgurApi.stream.toBytes();
      var resultFromImgurApi = String.fromCharCodes(responseDataFromImgurApi);

      print("RESULT= = = $resultFromImgurApi");
      Map<String, dynamic> jsonRes = json.decode(resultFromImgurApi);
      imageLink2 = (jsonRes["data"]["link"]).toString();

    //  emit(setImageSuccessState());
    } catch (e) {
      print(e);

     // emit(sendImageToServerErrorState(error: e.toString()));
    }
  }

  uploadMultiImageToServer2() async {
    emit(sendImageToServerLoadingState());
    try {
      var requestImgurApi = http.MultipartRequest(
          "POST", Uri.parse("https://api.imgur.com/3/image"));

      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      requestImgurApi.fields['title'] = imageName;
      requestImgurApi.headers['Authorization'] =
          "Client-ID " + "fb8a505f4086bd5";
      //"6ca0d6456311e4d";

      var imageFile = await http.MultipartFile.fromPath(
        'image',
        pickedImageXFiles2!.first.path,
        filename: imageName,
      );

      requestImgurApi.files.add(imageFile);

      var responseFromImgurApi = await requestImgurApi.send();

      var responseDataFromImgurApi =
          await responseFromImgurApi.stream.toBytes();
      var resultFromImgurApi = String.fromCharCodes(responseDataFromImgurApi);

      print("RESULT= = = $resultFromImgurApi");

      Map<String, dynamic> jsonRes = json.decode(resultFromImgurApi);
      imageLink3 = (jsonRes["data"]["link"]).toString();
    //  emit(setImageSuccessState());
    } catch (e) {
      print(e);

    //  emit(sendImageToServerErrorState(error: e.toString()));
    }
  }
}
