
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:doctors_app/presentaion/views/Doctor/doctor_reg/register_view.dart';
import 'package:doctors_app/presentaion/views/User/user_auth/user_login_view.dart';
import 'package:doctors_app/presentaion/views/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'bloc_obs.dart';



 void main() async{
  Bloc.observer = MyBlocObserver();
  await GetStorage.init();
  HttpOverrides.global = MyHttpOverrides();
 await Firebase.initializeApp();
  runApp(const MyApp());
}


 class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        textDirection: TextDirection.rtl,
        debugShowCheckedModeBanner: false,
        title: '',
        theme: ThemeData(
            primarySwatch: Colors.blue
        ),
        home:SplashView()
        // UserLoginView(
        //    cat: 'doctor',
        //  )
    // RegisterView(
    //       days: 3,
    //       sales: false,
    //       adsNum: 3,
    //     )
   //   const SplashView()
        //Test()
        // ToogleScreen(
        //   name: 'joo',
        //   email: 'youssefmak2020@gmail.com',
        //   code: '1111',
        //   total: '444',
        //   phone: '+201097970465',
        //   d_app: '',
        //   from: '',
        //   nsba_offer: '',
        //   num: '4444',
        //   point: '',
        //   status: '',
        //   to: '',
        //   trip: '',
        //
        //
        // )
        //OtpView()
       // const SplashView()
    );
  }
 }

 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
