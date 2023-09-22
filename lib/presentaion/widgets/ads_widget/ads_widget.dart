import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctors_app/domain/models/ads.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../views/User/doctors/get_doctor_data_id.dart';


 class AdsSlider extends StatefulWidget {

  List <Ads> adsList;
  AdsSlider(this.adsList, {Key? key}) :
        super(key: key);

  @override
  State<AdsSlider> createState() => _AdsSliderState();
}

class _AdsSliderState extends State<AdsSlider> {


   @override
  void initState() {

    // TODO: implement initStateF
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print("ADSlist.///////");
    return  CarouselSlider(
      options: CarouselOptions(height: 196.0,
          autoPlay:true,
        viewportFraction: 0.83,
        autoPlayCurve: Curves.fastLinearToSlowEaseIn,
        autoPlayAnimationDuration:Duration(seconds: 1)
      ),
      items: widget.adsList.map((i) {

        bool view=true;
        if(i.date_end.toString().length>2){
          DateTime currentDate = DateTime.now();
          String date=i.date_end.toString();
          DateTime date2 = DateTime.parse(date);
          int result = currentDate.compareTo(date2);
          print("/////");
          print(currentDate);
          print(date2);
          print(result);
          print("//////////");
          String comparisonResult;
          if (result < 0) {
            comparisonResult = 'Date 1 is before Date 2';

          } else if (result == 0) {
            comparisonResult = 'Date 1 is equal to Date 2';
          } else {
            comparisonResult = 'Date 1 is after Date 2';
            view=false;
          }
          print(comparisonResult);
        }


        return Builder(
          builder: (BuildContext context) {
            if (view == true) {
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
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 178,
                          width: 190,
                          color: ColorsManager.primary,
                        ),
                        Row(
                          children: [
                            SizedBox(width: 3,),
                            Column(
                              children: [
                                SizedBox(height: 30,),
                                Custom_Text(
                                  text: i.name.toString(),
                                  color: ColorsManager.white,
                                  alignment: Alignment.center,
                                  fontSize: 15,
                                ),
                                const SizedBox(height: 12,),
                                Container(
                                  width: 120,
                                  height: 40,
                                  child: Wrap(
                                    children: [Custom_Text(
                                      text: i.details.toString(),
                                      color: Colors.grey[200]!,
                                      alignment: Alignment.center,
                                      fontSize: 8,
                                    ),
                                    ],
                                    // child:
                                  ),
                                ),
                                const SizedBox(height: 32,),
                                CustomButton(
                                  text: "احجز الان ",
                                  color1: ColorsManager.white,
                                  color2: ColorsManager.primary,
                                  onPressed: () {
                             Get.to( DoctorDatadocWithId(
                               id: i.doctor_id.toString(),
                               ad: i,
                             ));

                                    // Get.to(AdDetailsView(
                                    //   ad: i.doctor_id,
                                    // ));
                                  },
                                ),
                              ],
                            ),
                            SizedBox(width: 6,),
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: SizedBox(
                                  height: 164,
                                  width: 114,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              6),
                                          color: Colors.transparent
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Image.network(i.image.toString(),
                                          fit: BoxFit.fill,
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
                onTap: () {

                },
              );
            } else {
              return Text('xx');
            }
          });


      }).toList(),
    );
  }
}
