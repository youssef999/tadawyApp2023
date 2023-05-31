import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:flutter/material.dart';

class NoDataView extends StatelessWidget {
  const NoDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        toolbarHeight: 6,
        elevation: 0,
        backgroundColor:ColorsManager.primary,
      ),
      body:
      Container(
        color:Colors.white,
        child:

        Center(
          child:
          Column(
            mainAxisAlignment:MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height:220,
                child:Image.asset("assets/images/data.png"),
              ),
              const SizedBox(height: 11,),
              const Custom_Text(
                text: 'لا يوجد بيانات بهذا الاسم ',
                fontSize: 22,
                color:Colors.black,
                alignment:Alignment.center,
              )
            ],
          ),
        ),
      )
    );
  }
}
