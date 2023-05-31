







import 'package:doctors_app/presentaion/const/app_message.dart';
import 'package:doctors_app/presentaion/resources/assets_manager.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/views/Doctor/Home/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../User/Home/dash_board.dart';

class OtpView extends StatefulWidget {

  String verId;
  String type;
  OtpView({required this.verId,required this.type});

  @override
  State<OtpView> createState() => _MyVerifyState();
}

String code='';
class _MyVerifyState extends State<OtpView> {
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: ColorsManager.primary,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 90,
                  child: Image.asset(
                    AssetsManager.Logo,
                    width: 150,
                    height: 150,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "رمز التاكيد ",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "ادخل الرقم المرسل اليك ",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Pinput(
                  length: 6,
                  onChanged:(value){
                    code=value;
                  },
                  // defaultPinTheme: defaultPinTheme,
                  // focusedPinTheme: focusedPinTheme,
                  // submittedPinTheme: submittedPinTheme,

                  showCursor: true,
                  onCompleted: (pin) => print(pin),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: ColorsManager.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        FirebaseAuth auth = FirebaseAuth.instance;
                        try{
                          PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(verificationId: widget.verId,
                              smsCode: code);
                          // Sign the user in (or link) with the credential
                          await auth.signInWithCredential(credential).then((value) {

                            if(widget.type=='user'){
                              Get.offAll(DashBoardFragment());

                            }

                            else{

                              Get.offAll(DashBoardDoctorView(
                                type: 'doctor',
                              ));
                            }

                          //  Get.offAll(hh());
                          });
                        }catch(e){
                          print(e);
                          appMessage(text: 'كود خاطئ');
                        }


                      },
                      child: Text("تاكيد ")),
                ),
                // Row(
                //   children: [
                //     TextButton(
                //         onPressed: () {
                //           Navigator.pushNamedAndRemoveUntil(
                //             context,
                //             'phone',
                //                 (route) => false,
                //           );
                //         },
                //         child: Text(
                //           "Edit Phone Number ?",
                //           style: TextStyle(color: Colors.black),
                //         ))
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}