import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:doctors_app/presentaion/resources/strings_manager.dart';
import 'package:doctors_app/presentaion/views/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'bloc_obs.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


 void main() async{
  Bloc.observer = MyBlocObserver();
  await GetStorage.init();
  HttpOverrides.global = MyHttpOverrides();
 await Firebase.initializeApp();
  configureFirebaseMessaging();
  runApp(const MyApp());
 }

FirebaseMessaging messaging = FirebaseMessaging.instance;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();


 Future<void> configureFirebaseMessaging() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails('your_channel_id', 'your_channel_name',
      importance: Importance.max, priority: Priority.high);
  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  print("NOTIF");
  FirebaseMessaging.instance
      .getInitialMessage()
      .then((RemoteMessage? message) async {
    // Handle the initial message when the app is opened from a notification
    if (message != null) {

      print("Initial message: ${message.notification?.title}");

      await flutterLocalNotificationsPlugin.show(
          0, AppStrings.APPNAME, message.notification?.title, platformChannelSpecifics,
          payload: '');


    }
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    // Handle notification when the app is in the foreground
    print("Foreground message: ${message.notification?.title}");
    await flutterLocalNotificationsPlugin.show(
        0, AppStrings.APPNAME, message.notification?.title, platformChannelSpecifics,
        payload: '');
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    // Handle notification when the app is in the background or terminated
    print("Opened app message: ${message.notification?.title}");
    await flutterLocalNotificationsPlugin.show(
        0, 'Notification title', 'Notification body', platformChannelSpecifics,
        payload: 'your_custom_data');
    Future.delayed(Duration(minutes: 2)).then((value) async {
      print("open app message ");
      await flutterLocalNotificationsPlugin.show(0, 'Notification title',
          'Notification body', platformChannelSpecifics,
          payload: 'your_custom_data');
    });
  });

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // Handle the received message here
    print("OPEN APP: ${message.notification?.title}");
    await flutterLocalNotificationsPlugin.show(
        0, 'Notification title', 'Notification body', platformChannelSpecifics,
        payload: 'your_custom_data');
    Future.delayed(Duration(minutes: 2)).then((value) async {
      print("2 MIN BACK");
      await flutterLocalNotificationsPlugin.show(0, 'Notification title',
          'Notification body', platformChannelSpecifics,
          payload: 'your_custom_data');
    });
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
