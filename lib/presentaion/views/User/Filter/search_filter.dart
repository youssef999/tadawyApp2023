
import 'dart:convert';
import 'package:doctors_app/Data/api_connection/api_connection.dart';
import 'package:doctors_app/domain/models/places2.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../doctors/doctor-details_view.dart';
import 'Filter_doctors_view.dart';



class SearchFilter extends StatefulWidget {
  String txt;
  SearchFilter({Key? key,required this.txt}) : super(key: key);

  @override
  State<SearchFilter> createState() => _SearchLayoutState();
}

List<Places2>searchFilter= [];

Future<List<Places2>> searchFilters(String name) async {

  try {
    var res = await http.post(Uri.parse(API.SEARCHFilters), body: {
      'typedkeyWords': name,
    });

    print("res${res.body}");
    if (res.statusCode == 200) {
      print("......HERE...SEARCH........");

      var resOfFavValidate = jsonDecode((res.body));

      if (resOfFavValidate['success'] == true) {
        (resOfFavValidate['Data'] as List).forEach((eachRecord) {
          searchFilter.add(Places2.fromJson(eachRecord));
        });
        print("success");

      } else {
        print("errrorr");

      }
    }
  } catch (e) {
    print("ERROR22::$e");

  }
  return searchFilter;
}




List<Places2>displayList=List.from(searchFilter);
TextEditingController nameController= TextEditingController();

class _SearchLayoutState extends State<SearchFilter> {
  @override
  void initState() {
    if(widget.txt!=''){
      nameController.text=widget.txt;
      searchFilters( nameController.text);
      updateList(nameController.text);
    }
    super.initState();
    searchFilters( nameController.text);
  }

  void updateList(String value){
    print("UP");
    setState((){
      displayList=searchFilter.where((element) => element.name!.toLowerCase()
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


                      hintText: "ادخل اسم المنطقة  ",
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
                          height:90,
                          width: double.infinity,
                          child:
                          Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height:50,
                                  width:double.infinity*0.50,
                                  child: const Card(

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

                    //if (displayList[index].country == country) {
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
                                height: 60,
                                width: double.infinity,
                                child:
                                Custom_Text(
                                  text: displayList[index].name
                                      .toString(),
                                  fontSize: 21,
                                  color: Colors.white,
                                  alignment: Alignment.center,
                                ),
                              ),
                              const SizedBox(height: 10,),
                            ],
                          ),
                          onTap: () {

                            Get.to(FiltersDoctorView(
                              place2:  displayList[index].name.toString()
                            ));
                       //     Get.to(DoctorDetailsView(displayList[index]));
                          },
                        ),
                      );
                    //}
                    // else{
                    //   return const SizedBox(height: 2,);
                    // }
                  }



                }

            )

          ],
        )



    );
  }

}

