
import 'package:doctors_app/presentaion/bloc/tdawa/tdawa_cubit.dart';
import 'package:doctors_app/presentaion/bloc/tdawa/tdawa_states.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/widgets/BAKA/baka_widget.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../resources/assets_manager.dart';


 class TdawaPlusView extends StatelessWidget {
  bool sales;
  int numAds;
 TdawaPlusView({required this.sales,required this.numAds,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create:(BuildContext context)=> TdawaCubit()..getPriceCountry()..getAllBouquet(),
        child: BlocConsumer<TdawaCubit,TdawaStates>(
        listener:(context,state){

    },
    builder:(context,state) {
      TdawaCubit tdawaCubit = TdawaCubit.get(context);

   return Scaffold(
     backgroundColor:Colors.white,
     appBar: AppBar(
       toolbarHeight: 50,
       backgroundColor: ColorsManager.primary,
       leading: IconButton(icon: Icon(Icons.arrow_back_ios,size: 21,color:ColorsManager.white,
       ),onPressed:(){
         Get.back();
       },),
     ),
        body:Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            children: [
              const SizedBox(height: 20,),
              SizedBox(
                height: 120,
                child:Image.asset(AssetsManager.Logo),
              ),
              const SizedBox(height: 20,),
              const Custom_Text(
                text: 'تداوي بلس',
                alignment:Alignment.center,
                fontSize:22,
               color:Colors.black,
              ),
              const SizedBox(height: 20,),
              const Custom_Text(text: 'أشترك في نظام الاعلانات الان ',
              alignment: Alignment.center,
                fontSize:16,
                color:Colors.grey,
              ),

      const SizedBox(height: 23,),

      const Padding(
          padding: EdgeInsets.only(right:15.0,top:15),
          child: Custom_Text(text: ' حدد الباقة التي تناسبك',
          alignment: Alignment.topRight,
          fontSize:16,
          color:Colors.black,
          ),
      ),
              const SizedBox(height: 23,),


              BakaWidget(bakaList: tdawaCubit.bakaList,sales:sales,numAds:numAds,type: '',
              price:tdawaCubit.countryPrice
              )

            ],
          ),
        ),
      );
    }

        )
    );
  }
}

