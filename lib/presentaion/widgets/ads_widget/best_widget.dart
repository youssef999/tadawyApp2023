
import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctors_app/presentaion/views/User/Ads/bestDetails_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../domain/models/ads.dart';



class BestSlider extends StatefulWidget {
  List <Ads> adsList;
  BestSlider(this.adsList, {Key? key}) : super(key: key);

  @override
  State<BestSlider> createState() => _BestSliderState();
}

class _BestSliderState extends State<BestSlider> {
  @override
  Widget build(BuildContext context) {

    CarouselController _controller = CarouselController();
    final box=GetStorage();
    String c=box.read('country')??"x";

    List<Ads>newList=[];
     // List<Best> newList = adsList.where((now2) =>endDate.isBefore(now) ).toList();

    for(int i=0;i<widget.adsList.length;i++){
      print('HEREXXX');
      DateTime now = DateTime.now();
      DateTime endDate = DateTime.parse(widget.adsList[i].date_end.toString());
      if(endDate.isAfter(now)&& widget.adsList[i].country==c&& widget.adsList[i].best=='true') {
        print('HERETRUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE');
        newList.add(widget.adsList[i]);
     }else{
        print('no data');
      }

    }
    print("LIST000============"+newList.toString());

    return
      CarouselSlider(
        carouselController:_controller,
      options: CarouselOptions(height: 210.0,autoPlay:true,
autoPlayAnimationDuration: Duration(milliseconds: 10),
        viewportFraction: 0.8,
      ),
      items:newList.map((i){
      //widget.adsList.map((i) {
        print('COUNTRYYYYYYYYYYYYYYY');
        print(i.country);
        print(c);
          return Builder(
            builder: (BuildContext context) {

              return InkWell(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(

                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white,
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.transparent,
                            Colors.transparent
                          ],

                        )

                    ),
                    child:
                    Column(
                      children: [
                        SizedBox(
                            height:160,
                            width: 420,
                            child: Image.network(i.image.toString(),fit:BoxFit.fill)),
                        const SizedBox(height:8,),

                      ],
                    )
                ),
                onTap:(){
                  Get.to(BestDetailsView(
                            ad: i,
                          ));
                },
              );
            },
          );
        // }
        //
        // else{
        //
        //   setState(() {
        //     _controller.nextPage();
        //   });
        //   return Container(
        //     width: 290,
        //     decoration: BoxDecoration(
        //         borderRadius:BorderRadius.circular(17),
        //         color:ColorsManager.primary
        //     ),
        //     child:Image.asset('assets/images/logo.png'),
        //   );
        // }
      }).toList(),

    );
  }
}
