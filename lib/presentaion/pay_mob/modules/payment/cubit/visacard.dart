import 'dart:async';
import 'dart:convert';
import 'package:doctors_app/presentaion/const/app_message.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/views/Doctor/doctor_ads/create_ad_view.dart';
import 'package:doctors_app/presentaion/views/Doctor/doctor_reg/register_view.dart';
import 'package:doctors_app/presentaion/views/Doctor/sales_code/sales_code.dart';
import 'package:doctors_app/presentaion/views/splash/splash_screen.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../../Data/api_connection/api_connection.dart';
import '../../../constants/const.dart';
import 'package:http/http.dart' as http;

class VisaCard extends StatelessWidget {
  bool sales;
  bool paid;
  String finalToken;
  bool ads;
  String type;
  int days;
  int adsNum;
  int freeAds;

  VisaCard(
      {required this.sales,
      required this.ads,
        required this.type,
        required this.paid,
      required this.days,
        required this.finalToken,
      required this.adsNum,
      required this.freeAds});

// https://accept.paymobsolutions.com/api/acceptance/post_pay?
  @override
  Widget build(BuildContext context) {
    final box=GetStorage();
    //final Completer<WebViewController> _controller =
    Completer<WebViewController>();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: ColorsManager.primary,

      ),
      bottomNavigationBar: CustomButton(text: 'عودة', onPressed:(){

         Get.back();
      }, color1: ColorsManager.primary, color2: Colors.white),
      body: WebView(
        initialUrl:
        //'https://accept.paymob.com/api/acceptance/iframes/422698?payment_token=$FinalTokenCard',
        'https://accept.paymob.com/api/acceptance/iframes/757156?payment_token=$FinalTokenCard',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          // _controller.complete(webViewController);
        },
        onProgress: (int progress) {
          print('WebView is loading (progress : $progress%)');
        },
        javascriptChannels: <JavascriptChannel>{
          _toasterJavascriptChannel(context),
        },
        navigationDelegate: (NavigationRequest request) {
          // if (request.url.startsWith('https://www.google.com/')) {
          //
          //   print('blocking navigation to $request}');
          //   return NavigationDecision.prevent;
          // }
          print('allowing navigation to $request');
          return NavigationDecision.navigate;
        },
        onPageStarted: (String url) {
          print('Page started loading: $url');
        },
        onPageFinished: (String url) {
          print('FINSH');

          print('Page finished loading: $url');
          if (url.contains('success=true')) {
            print("SUCCESS");
            appMessage(text: 'تمت العملية بنجاح ');
            increaseNumOfAds(adsNum, freeAds);
            if (ads == true) {
              box.write('payAds', 'payAds');
              box.write('days', days);

              Future.delayed(Duration(seconds: 3)).then((value) {

                Get.offAll(CreateAdView(
                  days: days,
                  sales: sales,
                  numOfAds: adsNum,
                  free: false,
                  type: type,
                ));

              } );

            } else {

              if(paid==true){


              updateData();


              }else{
                box.write('pay', 'pay');
                Future.delayed(Duration(seconds: 3)).then((value) {
                  Get.offAll(RegisterView(
                    sales: sales,
                    adsNum: adsNum,
                    days: days,
                  ));
                });
              }



            }
          } else {
            print("FAilded");
            // Future.delayed(Duration(seconds: 5)).then((value) {
            //   Get.offAll(SplashView());
            // });
          }
        },
        gestureNavigationEnabled: true,
        backgroundColor: const Color(0x00000000),
      ),


    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}




  void updateData() async{

  final box=GetStorage();
  final doctorId=box.read('doc_Id');
    try{

      var res =await http.post(Uri.parse(API.UpdatePaid),body: {
        'doctor_id':doctorId,
      },
      );

      if(res.statusCode==200){

        var responseBody =jsonDecode(res.body);

        if(responseBody["success"]==true) {
          print("UPDATE DONE");
          Get.offAll(SalesCode());
        }


      }
      else{
        print(res.statusCode);


      }
    }
    catch(e){
      print(e.toString());

    }
  }









increaseNumOfAds(int numOfAds, int numOfNewAds) async {
  final box = GetStorage();
  String Id = box.read('doc_Id') ?? 'x';
  print("ID" + Id);

  String num = (numOfAds + numOfNewAds).toString();

  try {
    var res = await http.post(Uri.parse(API.ChangeNumAds),
        body: {"doctor_id": Id, 'free_ads': num});

    if (res.statusCode == 200) {
      var resOfSignUp = jsonDecode(res.body);

      print(resOfSignUp);
      if (resOfSignUp['success'] == true) {
      } else {
        print(res.body);
        print("error${res.statusCode}");
      }
    }
  } catch (e) {
    print("ERROR==$e");
  }
}
