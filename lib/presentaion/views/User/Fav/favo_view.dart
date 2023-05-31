//
//
//
//   import 'package:doctors_app/domain/models/fav.dart';
// import 'package:doctors_app/presentaion/controller/fav_controller.dart';
// import 'package:doctors_app/presentaion/resources/color_manager.dart';
// import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class FavoView extends StatefulWidget {
//    const FavoView({Key? key}) : super(key: key);
//
//   @override
//   State<FavoView> createState() => _FavoViewState();
// }
// final controller=Get.put(FavController());
//
//   @override
//   initState() {
//     controller.getUserFav();
//     print("initState Called");
//   }
//
// class _FavoViewState extends State<FavoView> {
//    @override
//    Widget build(BuildContext context) {
//      return Scaffold(
//        appBar:AppBar(
//          toolbarHeight: 5,
//          backgroundColor:ColorsManager.primary,
//        ),
//        body:     GetBuilder(
//          builder: (context) {
//        // var controller1=Get.put(FavController());
//        // controller1.getUserFav();
//
//        return SingleChildScrollView(
//          child: Container(
//            height: 1230,
//            color: Colors.grey[100],
//            //width:double.infinity,
//            padding: const EdgeInsets.only(top: 9, left: 7, right: 7),
//            child: ListView.builder(
//                physics: const NeverScrollableScrollPhysics(),
//                itemCount:controller.favList.length,
//                itemBuilder: (context, index) {
//                  return Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: InkWell(
//                      child: Container(
//                        decoration: BoxDecoration(
//                            borderRadius: BorderRadius.circular(15),
//                            color: Colors.white70),
//                        child: Directionality(
//                          textDirection: TextDirection.rtl,
//                          child: Column(
//                            children: [
//                              const SizedBox(
//                                height: 12,
//                              ),
//                              Row(
//                                children: [
//                                  SizedBox(
//                                      height: 80,
//                                      width: MediaQuery.of(context).size.width * 0.3,
//                                      child: Image.network(
//                                          controller.favList[index].doctor_image.toString())),
//
//                                  const SizedBox(
//                                    width: 30,
//                                  ),
//
//                                  SizedBox(
//                                    width: MediaQuery.of(context).size.width * 0.3,
//                                    child: Column(
//                                      children: [
//                                        Custom_Text(
//                                          text: controller.favList[index].doctor_name.toString(),
//                                          color: ColorsManager.black,
//                                          fontSize: 16,
//                                          alignment: Alignment.center,
//                                        ),
//                                        const SizedBox(
//                                          height: 10,
//                                        ),
//                                        Custom_Text(
//                                          text: controller.favList[index].doctor_cat.toString(),
//                                          color: ColorsManager.primary,
//                                          fontSize: 16,
//                                          alignment: Alignment.center,
//                                        ),
//                                        const SizedBox(
//                                          height: 10,
//                                        ),
//                                        Row(
//                                          children: [
//                                            Custom_Text(
//                                              text: 'سعر الكشف '.toString(),
//                                              color: Colors.grey,
//                                              fontSize: 14,
//                                              alignment: Alignment.center,
//                                            ),
//                                            SizedBox(
//                                              width: 12,
//                                            ),
//                                            Custom_Text(
//                                              text: controller.favList[index].price.toString(),
//                                              color: ColorsManager.primary,
//                                              fontSize: 16,
//                                              alignment: Alignment.center,
//                                            ),
//                                          ],
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//
//                                  SizedBox(
//                                      width: MediaQuery.of(context).size.width * 0.1),
//                                  GetBuilder(
//                                      init:FavController(),
//                                      builder: (con) {
//
//                                        var controller=Get.put(FavController());
//                                        return Positioned(
//                                          top: MediaQuery.of(context).padding.top,
//                                          left: 0,
//                                          right: 0,
//                                          child: Row(
//                                            children: [
//                                              IconButton(onPressed: (){
//                                                if(controller.fav){
//
//                                                  print('x');
//                                                  //
//                                                  //  cubit.deleteFromFavList(listApp[index]);
//
//                                                }
//                                                else{
//                                                  print('y');
//                                                  // cubit.addToFavList(listApp[index]);
//                                                }
//                                              }, icon:
//
//                                              Icon(
//                                                controller.fav?Icons.bookmark:Icons.bookmark_border_outlined,
//                                                color:ColorsManager.purple2,
//                                              ))
//                                            ],
//                                          ),
//                                          //
//                                        );
//                                      }
//                                  )
//                                  //Image.asset('assets/images/vec1.png')
//                                ],
//                              ),
//                              const SizedBox(
//                                height: 12,
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),
//                      onTap: () {
//                        // Get.to(DoctorDetailsView(listApp[index]));
//                      },
//                    ),
//                  );
//                }),
//          ),
//        );
//      }
//      )
//      );
//    }
// }
//
