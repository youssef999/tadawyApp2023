

import 'package:doctors_app/presentaion/pay_mob/constants/const.dart';
import 'package:doctors_app/presentaion/pay_mob/models/first_token.dart';
import 'package:doctors_app/presentaion/pay_mob/modules/payment/cubit/cubit.dart';
import 'package:doctors_app/presentaion/pay_mob/modules/payment/cubit/states.dart';
import 'package:doctors_app/presentaion/pay_mob/modules/payment/cubit/visacard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ToogleScreen extends StatelessWidget {


  String ? name,email,phone,code,d_app,from,point,to,trip,nsba_offer,num,status,total;


  ToogleScreen({
      this.name,
      this.email,
      this.phone,
      this.code,
      this.d_app,
      this.from,
      this.point,
      this.to,
      this.trip,
      this.nsba_offer,
      this.num,
      this.status,
      this.total
  });

  @override
   Widget build(BuildContext context) {
    return  BlocProvider(
        create:(BuildContext context)=>paymentCubit(),
        child: BlocConsumer<paymentCubit,PaymentStates>(
        listener:(context,state){

    },
    builder:(context,state){


     return Scaffold(
       appBar: AppBar(
         toolbarHeight: 0,
         elevation: 0,
         backgroundColor: Colors.yellow,
         iconTheme: IconThemeData(
           color: Colors.yellow,
         ),
       ),
       body:Container(
         child: Column(
           crossAxisAlignment:CrossAxisAlignment.center,
           children: [
             SizedBox(height: 30,),
             InkWell(
               child: Container(
                 child: Column(
                   children: [
                     Container(
                       width: double.infinity,
                       height:120,
                       child:   Image.asset('assets/v1t.png')
                     ),
                     SizedBox(height:5,),

                     Text("65".tr,
                       style:TextStyle(color:Colors.black,fontSize:21,fontWeight:FontWeight.w700),)
                   ],
                 ),
               ),
               onTap:(){
                 paymentCubit.get(context).getFirstToken(
                  price:  '333',
                     email: 'youssefmak2020@gmail.com',
                     lname: 'yousef',
                     fname: 'omar',
                     city: 'egy',
                   phonenum:   '+201097970465');
                 print("firstTOKEN");
                 // print(paymobFirstToken);
                 // print(FirstToken());

    // Get.to(VisaCard(
    //                    name: name,
    //                    email: email,
    //                    code: code??"",
    //                    d_app: d_app??"",
    //                   from: from,
    //                   nsba_offer: nsba_offer,
    //                  num: num,
    //                phone: phone,
    //                point: point,
    //                status: status,
    //                to: to,
    //                total: total,
    //                trip: trip,
    //
    //              ));
               },
             ),
// SizedBox(
//   height: 10,
// ),
//              InkWell(
//                child: Container(
//                  child: Column(
//                    children: [
//                      Container(
//                          width: double.infinity,
//                          height:120,
//                          child:   Image.asset('assets/v2t.png')
//                      ),
//                      SizedBox(height:5,),
//                      Text("66".tr,
//                        style:TextStyle(color:Colors.black,fontSize:21,fontWeight:FontWeight.w700),)
//                    ],
//                  ),
//                ),
//                onTap:() async {
//                  await Firestore.instance.collection('orders').add({
//                    'name': name ?? "",
//                    'email': email ?? "",
//                    'phone': phone ?? "",
//                    'code': code?? "",
//                    'd_app': d_app ?? "",
//                    'from': from,
//                     'type':'voucher',
//                    'point': "it will be updated soon",
//                    'to': to,
//                    'trip': trip,
//                    // 'price':widget.price.toString(),
//                    'nsba_offer': nsba_offer,
//                    'num': num.toString(),
//                    "status": "pending",
//                    "total": total,
//                    "date": "Waiting..",
//                    "time": "Waiting..",
//                    "bus":"Waiting.."
//                  });
//                  Get.to(RefCode2());
//                },
//              ),



             SizedBox(
               height: 10,
             ),
             InkWell(
               child: Container(
                 child: Column(
                   children: [
                     Container(
                         width: double.infinity,
                         height:120,
                         child:   Image.asset('assets/vod3.png')
                     ),
                     SizedBox(height:5,),
                     Text("67".tr,
                       style:TextStyle(color:Colors.black,fontSize:21,fontWeight:FontWeight.w700),)
                   ],
                 ),
               ),
               onTap:() async {


                 print("total"+total.toString());

                 // Get.to(VodafoneCash(
                 //    name: name,
                 //    email: email,
                 //    phone: phone,
                 //    code: code,
                 //    d_app: d_app,
                 //    from: from,
                 //    point: point,
                 //    to: to,
                 //    trip: trip,
                 //    nsba_offer: nsba_offer,
                 //    num: num,
                 //    status: status,
                 //    total: total
                 // ));


               },
             )
           ],
         ),

       ),
     );
    }));
  }
}