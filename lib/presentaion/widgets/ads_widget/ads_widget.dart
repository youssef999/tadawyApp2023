import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctors_app/domain/models/ads.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../views/User/Ads/ads_details_view.dart';


 class AdsSlider extends StatelessWidget {

  List <Ads> adsList;
  AdsSlider(this.adsList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box=GetStorage();
    String c=box.read('country')??"x";
    List<Ads>newList=[];
    for(int i=0;i<adsList.length;i++){
      DateTime now = DateTime.now();
      DateTime endDate = DateTime.parse(adsList[i].date_end.toString());
      if(endDate.isAfter(now)&&adsList[i].country==c){
        newList.add(adsList[i]);
      }
    }
    return  CarouselSlider(
      options: CarouselOptions(height: 196.0,autoPlay:true,
        viewportFraction: 0.83,
        autoPlayCurve: Curves.fastLinearToSlowEaseIn,
        autoPlayAnimationDuration:Duration(seconds: 2)

      ),
      items: newList.map((i) {


        return Builder(
          builder: (BuildContext context) {

            return InkWell(
              child: Container(
                  child:
                  Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 178,
                            child: Image.asset('assets/images/mix.jpg',
                              fit:BoxFit.contain,
                            ),
                          ),

                        ],
                      ),
                      Container(
                        height: 178,
                      width: 190,
                      color:ColorsManager.primary,
                      ),
                      Row(
                        children: [
                          SizedBox(width: 3,),
                          Column(
                            children: [
                              SizedBox(height: 30,),
                              Custom_Text(
                                text:i.name.toString(),
                                color:ColorsManager.white,
                                alignment:Alignment.center,
                                fontSize: 15,
                              ),
                              const SizedBox(height:12,),
                              Container(
                                width: 120,
                                height: 40,
                                child: Wrap(
                                  children: [Custom_Text(
                                    text:i.details.toString(),
                                    color:Colors.grey[200]!,
                                    alignment:Alignment.center,
                                    fontSize: 8,
                                  ),],
                                 // child:
                                ),
                              ),
                              const SizedBox(height:32,),
                              CustomButton(
                                text: "احجز الان ",
                                color1:ColorsManager.white,
                                color2:ColorsManager.primary,
                                onPressed:(){
                                  Get.to(AdDetailsView(
                                    ad: i,
                                  ));
                                },
                              ),
                            ],
                          ),
                          SizedBox(width: 6,),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: SizedBox(
                                height:164,
                                width: 114,
                                child: Container(
                                    decoration:BoxDecoration(
                                        borderRadius:BorderRadius.circular(6),
                                        color:Colors.transparent
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Image.network(i.image.toString(),
                                        fit:BoxFit.fill,
                                      ),
                                    ))),
                          ),


                        ],
                      ),
                    ],
                    // child:
                    //

                  )
              ),
              onTap:(){

              },
            );
          },
        );

      }).toList(),
    );
  }
}
