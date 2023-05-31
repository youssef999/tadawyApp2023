
import 'dart:convert';

import 'package:doctors_app/Data/api_connection/api_connection.dart';
import 'package:doctors_app/domain/models/user.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../doctors/doctor-details_view.dart';



class SearchLayout extends StatefulWidget {
  String txt;
   SearchLayout({Key? key,required this.txt}) : super(key: key);

  @override
  State<SearchLayout> createState() => _SearchLayoutState();
}

List<DoctorModel>searchList= [];

 Future<List<DoctorModel>> searchData(String name)async {


  try{
    var res = await http.post(Uri.parse(API.SEARCH), body: {
      'typedkeyWords':name,
    });

    print("res${res.body}");
    if (res.statusCode == 200) {
      print("......HERE...SEARCH........");

      var resOfFavValidate = jsonDecode((res.body));

      if (resOfFavValidate['success'] == true) {
        (resOfFavValidate['Data'] as List).forEach((eachRecord) {

          searchList.add(DoctorModel.fromJson(eachRecord));

        });
        print("success");





      } else {
        print("errrorr");


      }
    }
  }catch(e){

    print("ERROR22::$e");

  }
  return searchList;
}




 List<DoctorModel>displayList=List.from(searchList);
 TextEditingController nameController= TextEditingController();

class _SearchLayoutState extends State<SearchLayout> {
  @override
  void initState() {
if(widget.txt!=''){
  nameController.text=widget.txt;
  searchData( nameController.text);
  updateList(nameController.text);
}
    super.initState();
    searchData( nameController.text);
  }

  void updateList(String value){
    print("UP");
    setState((){
      displayList=searchList.where((element) => element.doctor_name!.toLowerCase()
          .contains(value.toLowerCase())).toList();
    });
    print("DIS=$displayList");
    print("DIS=${displayList.length}");

  }


  @override
  Widget build(BuildContext context) {

    if(displayList.isEmpty){
      print("xxxxx");
      return Scaffold(
          appBar: AppBar(
            elevation: 1,

            backgroundColor: ColorsManager.primary,
            toolbarHeight: 6,

            iconTheme:  const IconThemeData(color: Colors.black),
          ),
          body:



          ListView(
            children: [
              const SizedBox(height:25,),

              Container(
                padding: const EdgeInsets.all(10),
                height: 70,
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      onChanged:(value)=>updateList(value),
                      onFieldSubmitted:(txt){
                        updateList(txt);
                      },
                      controller: nameController,
                      decoration:  InputDecoration(

                        suffixIcon: InkWell(
                            child:  Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                  backgroundColor:ColorsManager.primary,
                                  child: Icon(Icons.search,textDirection:TextDirection.rtl,size:30,
                                    color:Colors.white,)),
                            ),

                            onTap:(){
                              updateList(nameController.text);
                            }),


                        hintText: "ادخل اسم الطبيب او جهة العلاج ",
                        hintStyle: const TextStyle(color: Colors.grey),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide:  BorderSide(
                            color: ColorsManager.primary,
                            width: 2.0,
                          ),
                        ),
                      ),
                    )),
                //   ),
              ),
              const SizedBox(height: 10,),
              // if(displayList==[])
              const Custom_Text(
                text: "لا توجد نتائج بحث",
                fontSize: 22,
                alignment:Alignment.center,
                color: Colors.black,
              ),


            ],
          )



      );
    }else{

    }
      return Scaffold(
          appBar: AppBar(
            elevation: 5,
            backgroundColor: ColorsManager.primary,
            toolbarHeight: 11,

            iconTheme:  const IconThemeData(color: Colors.black),
          ),
          body:



          ListView(
            children: [
              const SizedBox(height:25,),

              Container(
                padding: const EdgeInsets.all(10),
                height: 70,
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      onChanged:(value)=>updateList(value),
                      onFieldSubmitted:(txt){
                        updateList(txt);
                      },
                      controller: nameController,
                      decoration:  InputDecoration(

                        suffixIcon: InkWell(
                            child:  Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                  backgroundColor:ColorsManager.primary,
                                  child: Icon(Icons.search,textDirection:TextDirection.rtl,size:30,
                                    color:Colors.white,)),
                            ),

                            onTap:(){
                              updateList(nameController.text);
                            }),


                        hintText: "ادخل اسم الطبيب او الجهة  ",
                        hintStyle: const TextStyle(color: Colors.grey),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide:  BorderSide(
                            color: ColorsManager.primary,
                            width: 2.0,
                          ),
                        ),
                      ),
                    )),
                //   ),
              ),


              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:displayList.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {





                    if(displayList==[]){
                      print("EMPTYYY====");
                      return Column(
                        mainAxisAlignment:MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10,),
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.cyan.withOpacity(0.1),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(15),
                                gradient: const LinearGradient(
                                  colors: [
                                    ColorsManager.white,
                                    ColorsManager.white,
                                  ],
                                  begin: FractionalOffset(0.0, 0.4),
                                  end: Alignment.topRight,
                                )),
                            height:140,
                            width: double.infinity,
                            child:
                            Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height:90,
                                    width:double.infinity*0.50,
                                    child: const Card(
                                      // child: Image.network(
                                      //   displayList[index].image.toString(),
                                      //   fit:BoxFit.fill,
                                      // )
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 3,),

                                Custom_Text(text: 'tttt'
                                    .toString(),
                                  fontSize:16,
                                  color:Colors.black,
                                  alignment:Alignment.center,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10,),
                        ],
                      );
                    }
                    else {
                      final box = GetStorage();
                      String country = box.read('country') ?? 'x';
                      if (displayList[index].country == country) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 8, left: 22.0, right: 22),
                          child: InkWell(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10,),
                                Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.purple.withOpacity(0.3),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(15),
                                      gradient:  LinearGradient(
                                        colors: [
                                          ColorsManager.primary,
                                          ColorsManager.primary,

                                        ],
                                        begin: FractionalOffset(0.0, 0.4),
                                        end: Alignment.topRight,
                                      )),
                                  height: 170,
                                  width: double.infinity,
                                  child:
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          height: 120,
                                       //   width: double.infinity * 0.50,
                                          child: Card(
                                              child: Image.network(
                                                displayList[index].doctor_image
                                                    .toString(),
                                                fit: BoxFit.scaleDown,
                                              )),
                                        ),
                                      ),
                                      const SizedBox(height: 3,),

                                      Custom_Text(
                                        text: displayList[index].doctor_name
                                            .toString(),
                                        fontSize: 21,
                                        color: Colors.white,
                                        alignment: Alignment.center,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10,),
                              ],
                            ),
                            onTap: () {
                              Get.to(DoctorDetailsView(displayList[index]));
                            },
                          ),
                        );
                      }
                      else{
                        return const SizedBox(height: 2,);
                      }
                    }



                  }

              )

            ],
          )



      );
    }

  }

