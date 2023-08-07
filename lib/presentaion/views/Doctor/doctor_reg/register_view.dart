import 'dart:io';
import 'package:doctors_app/presentaion/bloc/auth/auth_cubit.dart';
import 'package:doctors_app/presentaion/bloc/auth/auth_states.dart';
import 'package:doctors_app/presentaion/const/app_message.dart';
import 'package:doctors_app/presentaion/resources/assets_manager.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:doctors_app/presentaion/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../User/user_auth/Login.dart';
import '../../sales/sales_view.dart';


class RegisterView extends StatefulWidget {
  bool sales;
  int adsNum;
  int days;
  RegisterView({required this.sales,required this.adsNum,required this.days});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  List<String> _options = ['طبيب', 'مستشفي', 'صيدلية','علاج نفسي','مركز تجميل','مركز اشاعة'
    ,'معامل تحاليل','تمريض','اخري'];


  String dropdownValue = 'طبيب';

  List<String> medicalSpecialties = [
    "جهة متعددة التخصصات",
    "أمراض القلب والأوعية الدموية",
    "طب الأطفال",
    "أمراض الكلى",
    "طب النساء والتوليد",
    "طب العيون",
    "أمراض الأنف والأذن والحنجرة",
    "طب الجهاز الهضمي",
    "علم الأورام",
    "طب الأمراض الجلدية",
    "أمراض الجهاز التنفسي",
    "طب الأمراض العقلية",
    "جراحة المخ والأعصاب",
    "طب الطوارئ",
    "باطنة",
    "طب الأمراض المعدية",
    "طب الأشعة التشخيصية",
    "علم الأعصاب",
    "جراحة العظام",
    "طب الطوارئ",
    "جراحة الأورام",
    "طب الأعصاب السريري",
    "طب الرئة وأمراض الصدر",
    "طب الغدد الصماء",
    "علاج الألم",
    "جراحة الجهاز الهضمي",
    "طب الأسرة",
    "طب القلب النسائي",
    "علاج الطب البديل والتكميلي",
    "طب العناية المركزة",
    "علم الأورام السريري",
    "جراحة الأعصاب",
    "طب الروماتيزم",
    "علم الأمراض العدوائية",
    "علم الأمراض الجينية",
    "جراحة الأوعية الدموية",
    "طب الأطفال الحديثي الولادة",
    "جراحة العيون",
    "جراحة القلب",
    "جراحة التجميل",
    "اخري"
  ];


  String dropdownCatValue =    "أمراض القلب والأوعية الدموية";

  final box=GetStorage();



  Widget _buildDropDownWidget(){
    return Container(

      decoration:BoxDecoration(
        borderRadius:BorderRadius.circular(20),
        color:ColorsManager.primary,
      ),
      width: 350,
      child: Center(
        child: DropdownButton<String>(
          value: dropdownValue,
          dropdownColor:ColorsManager.primary,
          iconDisabledColor:Colors.white,
          iconEnabledColor:Colors.white,
          icon: Icon(Icons.arrow_drop_down),
          onChanged: (String  ?newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items:
        _options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,style:TextStyle(color:Colors.white)),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildDropDownWidget2(){
    return Container(
      decoration:BoxDecoration(
        borderRadius:BorderRadius.circular(20),
        color:ColorsManager.primary,
      ),
      width: 360,
      child: Center(
        child: DropdownButton<String>(
          value: dropdownCatValue,
          dropdownColor:ColorsManager.primary,
          iconDisabledColor:Colors.white,
          iconEnabledColor:Colors.white,
          icon: Icon(Icons.arrow_drop_down),
          onChanged: (String  ?newValue) {
            setState(() {
              dropdownCatValue = newValue!;
            });
          },
          items:
          medicalSpecialties.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,style:TextStyle(color:Colors.white)),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String countryCode=box.read('countryCode');

    return BlocProvider(
        create: (BuildContext context) => AuthCubit(),
          //..getData(),
        child: BlocConsumer<AuthCubit, AuthStates>(
            listener: (context, state) async {


              if(state is RegisterSuccessState){

                appMessage(text: 'تم انشاء حسابك بنجاح');

                if(widget.sales==true){

                  Get.offAll(SalesView());

                }
                else{
                  Get.offAll(UserLoginView(
                    cat: 'doctor',
                  ));
                }
              }

              if(state is RegisterErrorState){

                appMessage(text: 'حدث خطا ربما ادخلت بيانات بشكل خاطئ');
              }
            },
            builder: (context, state) {
              AuthCubit authCubit = AuthCubit.get(context);
              return Scaffold(
                backgroundColor:Colors.white,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: ColorsManager.primary,
                  toolbarHeight: 1,
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0,right:8),
                        child: Column(
                          children:  [
                            CircleAvatar(
                              radius: 70,
                                backgroundColor:ColorsManager.white,
                                child: Image.asset(AssetsManager.Logo)),
                            const SizedBox(height: 10,),
                            const Custom_Text(text: 'انت جزء من فريقنا قم بتعبئة البيانات كاملة ',
                              fontSize:15,
                              alignment:Alignment.center,
                              color:Colors.grey,
                            ),

                            SizedBox(height: 30,),
                            const Custom_Text(text: 'قم باختيار نوع الحساب ',
                              fontSize:15,
                              alignment:Alignment.center,
                              color:Colors.black,
                            ),
                            SizedBox(height: 10,),
                            _buildDropDownWidget(),
                            SizedBox(height: 33,),
                            (dropdownValue=='طبيب')?
                            Column(
                              children: [
                                Custom_Text(text: 'القسم الخاص بك',fontSize:16,color:Colors.black,alignment:Alignment.center),
                                SizedBox(height: 12,),
                                _buildDropDownWidget2(),
                              ],
                            ):SizedBox(),

                           // _buildRadioList(),

                            const SizedBox(height: 40,),
                            authCubit.pickedImageXFile != null?
                             InkWell(
                              child: Container(
                                height:  MediaQuery.of(context).size.width*0.5,
                                width: MediaQuery.of(context).size.width*0.6,
                                decoration:BoxDecoration(
                                  borderRadius:BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image:FileImage(
                                            File(authCubit.pickedImageXFile!.path)),
                                        fit:BoxFit.fill
                                    )
                                ),
                              ),
                              onTap:(){
                                authCubit.showDialogBox(context);
                              },
                            ):InkWell(
                              child: Column(
                                children: [

                                  Container(
                                    height: 130,
                                    decoration: BoxDecoration(
                                      borderRadius:BorderRadius.circular(6),
                                      color:Colors.transparent,
                                    ),

                                 //   radius: 100,
                                    child:Image.asset('assets/images/doc4.png'),
                                  ),
                                  const SizedBox(height: 10,),
                                  const Custom_Text(text: 'اضف صورتك',color:Colors.black,
                                    fontSize:21,alignment:Alignment.center,
                                  ),
                                ],
                              ),
                              onTap:(){
                                authCubit.showDialogBox(context);
                              },
                            ),
                            const SizedBox(height: 20,),
                            (dropdownValue=='طبيب')?
                            CustomTextFormField(
                              controller:authCubit.nameController,
                              color:Colors.black,
                              hint: "الاسم بالكامل",
                              max: 2,
                              obs: false,
                              obx: false,
                              ontap:(){},
                              type:TextInputType.text,
                            ):SizedBox(),
                            const SizedBox(height: 10,),
                            CustomTextFormField(
                              controller:authCubit.emailController,
                              color:Colors.black,
                              hint: "البريد الالكتروني ",
                              max: 2,
                              obs: false,
                              obx: false,
                              ontap:(){},
                              type:TextInputType.text,
                            ),
                            const SizedBox(height: 10,),
                            Container(
                              padding: const EdgeInsets.only(right: 16,bottom: 20,left:14,top: 20),
                              decoration:BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:Colors.white
                              ),
                              child: TextFormField(
                                controller: authCubit.phoneController,
                                decoration: InputDecoration(
                                    suffixIcon: Container(

                                        child: Text(countryCode,style:TextStyle(fontSize:17),)),
                                    hintText: 'رقم الهاتف '
                                ),
                              ),
                            ),

                            const SizedBox(height: 10,),



                            SizedBox(height: 11,),

                            (authCubit.locatate==false)?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.location_on,color:ColorsManager.primary,),
                                CustomButton(text: 'اضغط هنا لتحديد موقعك ', onPressed: (){
                                  authCubit.getData();
                                  // print(getCurrentLocation());

                                  appMessage(text: 'جاري تحديد الموقغ');
                                  print("xxx");
                                  authCubit.getData();


                                }, color1: ColorsManager.primary, color2: Colors.white),
                              ],
                            ):SizedBox(),


                            (authCubit.lat!=0.0)?
                            Column(
                              children: [
                                SizedBox(height: 10,),
                                Custom_Text(text: 'تم تحديد الموقع',alignment: Alignment.center,fontSize: 18,color:Colors.black,),
                                SizedBox(height: 10,),
                                Card(
                                  child:Column(
                                    children: [
                                      SizedBox(height: 6,),
                                      Custom_Text(text: authCubit.country,fontSize: 15,alignment:Alignment.center,),
                                    //  Custom_Text(text: authCubit.city,fontSize: 15,alignment:Alignment.center,),
                                      Custom_Text(text: authCubit.address,fontSize: 15,alignment:Alignment.center,),
                                      SizedBox(height: 6,),
                                    ],
                                  ),
                                )
                              ],
                            ):SizedBox(height: 1,),
                            const SizedBox(height: 10,),

                            CustomTextFormField(
                              controller:authCubit.clinkName1,
                              color:Colors.black,
                              hint: " الاسم الخاص بجهة العمل  ",
                              obs: false,
                              max:2,
                              obx: false,
                              ontap:(){},
                              type:TextInputType.text,
                            ),

                            const SizedBox(height: 10,),
                            CustomTextFormField(
                              controller:authCubit.placeController,
                              color:Colors.black,
                              hint: " المدينة",
                              obs: false,
                              max:2,
                              obx: false,
                              ontap:(){},
                              type:TextInputType.text,
                            ),
                            const SizedBox(height: 10,),

                            CustomTextFormField(
                              controller:authCubit.place2Controller,
                              color:Colors.black,
                              hint: " المنطقة مثل : مدينة نصر او الهرم ...  ",
                              obs: false,
                              max:2,
                              obx: false,
                              ontap:(){},
                              type:TextInputType.text,
                            ),
                            SizedBox(height: 10,),

                            SizedBox(height: 10,),
                            (dropdownValue=='طبيب')?
                            Column(
                              children: [
                                CustomTextFormField(
                                  controller:authCubit.clinkPhone1,
                                  color:Colors.black,
                                  hint: " رقم العيادة ارضي   ",
                                  obs: false,
                                  max:2,
                                  obx: false,
                                  ontap:(){},
                                  type:TextInputType.phone,
                                ),
                                SizedBox(height: 10,),
                                CustomTextFormField(
                                  controller:authCubit.clinkPhone2,
                                  color:Colors.black,
                                  hint: " رقم العيادة موبايل  ",
                                  obs: false,
                                  max:2,
                                  obx: false,
                                  ontap:(){},
                                  type:TextInputType.phone,
                                ),

                                SizedBox(height: 10,),
                                CustomTextFormField(
                                  controller:authCubit.clinkPhone3,
                                  color:Colors.black,
                                  hint: " رقم العيادة واتس  ",
                                  obs: false,
                                  max:2,
                                  obx: false,
                                  ontap:(){},
                                  type:TextInputType.phone,
                                ),



                                SizedBox(height: 10,),
                                CustomTextFormField(
                                  controller:authCubit.clinkPosition1,
                                  color:Colors.black,
                                  hint: " منصبك في هذا المكان  ",
                                  obs: false,
                                  max:2,
                                  obx: false,
                                  ontap:(){},
                                  type:TextInputType.text,
                                ),
                              ],
                            ):SizedBox(),


                            const SizedBox(height: 10,),
                            CustomTextFormField(
                              controller:authCubit.infoController,
                              color:Colors.black,
                              hint: "معلومات و تفاصيل ",
                              obs: false,
                              max:6,
                              obx: false,
                              ontap:(){},
                              type:TextInputType.text,
                            ),
                            const SizedBox(height: 40,),

                            (authCubit.pickedImageXFiles!=null)?
                            InkWell(
                              child: Container(
                                height:  MediaQuery.of(context).size.width*0.5,
                                width: MediaQuery.of(context).size.width*0.6,
                                decoration:BoxDecoration(
                                    borderRadius:BorderRadius.circular(20),
                                    image:
                                    (authCubit.pickedImageXFiles!.isNotEmpty)?
                                    DecorationImage(
                                        image:FileImage(
                                            File(authCubit.pickedImageXFiles!.first.path)),
                                        fit:BoxFit.fill
                                    ):DecorationImage(image:NetworkImage('https://cdn3d.iconscout.com/3d/premium/thumb/business-success-6814314-5603427.png'))
                                ),
                              ),
                              onTap:(){
                                authCubit.pickMultiImage();
                                //authCubit.showDialogBox2(context);
                              },
                            )
                                :InkWell(
                              child: Column(
                                children: [

                                  Container(
                                    width: 160,
                                    decoration: BoxDecoration(
                                      borderRadius:BorderRadius.circular(20),
                                      color:ColorsManager.primary,
                                    ),
                                    //   radius: 100,
                                    child:Image.asset('assets/images/img2.jpg'),
                                  ),
                                  const SizedBox(height: 10,),
                                  const Custom_Text(text: 'صور لاهم ما يميزك ',color:Colors.black,
                                    fontSize:21,alignment:Alignment.center,
                                  ),
                                ],
                              ),
                              onTap:(){
                                authCubit.pickMultiImage();
                              },
                            ),

                            ( authCubit.pickedImageXFiles!=null)?

                            (authCubit.pickedImageXFiles!.length>1)?
                            InkWell(
                              child: Container(
                                height:  MediaQuery.of(context).size.width*0.5,
                                width: MediaQuery.of(context).size.width*0.6,
                                decoration:BoxDecoration(
                                    borderRadius:BorderRadius.circular(20),
                                    color: Colors.black,
                                    image:
                                    (authCubit.pickedImageXFiles!.isNotEmpty)?
                                    DecorationImage(
                                        image:FileImage(
                                            File(authCubit.pickedImageXFiles!.last.path)),
                                        fit:BoxFit.fill
                                    ):DecorationImage(image:NetworkImage('https://cdn3d.iconscout.com/3d/premium/thumb/business-success-6814314-5603427.png'))
                                ),
                              ),
                              onTap:(){
                                authCubit.pickMultiImage();
                              },
                            ):SizedBox():SizedBox(height: 1,),

                            ( authCubit.pickedImageXFiles!=null)?

                            (authCubit.pickedImageXFiles!.length>2)?
                            InkWell(
                              child: Container(
                                height:  MediaQuery.of(context).size.width*0.5,
                                width: MediaQuery.of(context).size.width*0.6,
                                decoration:BoxDecoration(
                                    borderRadius:BorderRadius.circular(20),
                                    color: Colors.black,
                                    image:
                                    (authCubit.pickedImageXFiles!.isNotEmpty)?
                                    DecorationImage(
                                        image:FileImage(
                                            File(authCubit.pickedImageXFiles![1].path)),
                                        fit:BoxFit.fill
                                    ):DecorationImage(image:NetworkImage('https://cdn3d.iconscout.com/3d/premium/thumb/business-success-6814314-5603427.png'))
                                ),
                              ),
                              onTap:(){
                                authCubit.pickMultiImage();
                                //authCubit.showDialogBox2(context);
                              },
                            ):SizedBox():SizedBox(height: 1,),




                            const SizedBox(height: 20,),
                            const SizedBox(height: 10,),
                            const SizedBox(height: 10,),
                            const Custom_Text(text: 'ايام العمل تضاف بهذا الشكل مثلا سبت , احد , ثلاثاء',
                            alignment:Alignment.center,
                              color:Colors.red,
                              fontSize: 15,
                            ),
                            const SizedBox(height: 10,),
                            CustomTextFormField(
                              controller:authCubit.daysController,
                              color:Colors.black,
                              hint: " ايام العمل    ",
                              max:3,
                              obs: false,
                              obx: false,
                              ontap:(){},
                              type:TextInputType.text,
                            ),
                            const SizedBox(height: 10,),
                            CustomTextFormField(
                              controller:authCubit.priceController,
                              color:Colors.black,
                              hint: " متوسط السعر     ",
                              max:2,
                              obs: false,
                              obx: false,
                              ontap:(){},
                              type:TextInputType.number,
                            ),

                            const SizedBox(height: 10,),

                            CustomTextFormField(
                              controller:authCubit.passwordController,
                              color:Colors.black,
                              hint: "كلمة المرور ",
                              obs: true,
                              obx: true,
                              ontap:(){},
                              type:TextInputType.text,
                            ),
                            const SizedBox(height: 10,),

                            (dropdownCatValue=='طبيب')?
                            CustomTextFormField(
                              controller:authCubit.degreeController,
                              color:Colors.black,
                              hint: "الدرجة العلمية ",
                              obs: false,
                              max:3,
                              obx: false,
                              ontap:(){},
                              type:TextInputType.text,
                            ):SizedBox(),
                            const SizedBox(height: 40,),

                            (authCubit.pickedImageXFiles2!=null)?

                            InkWell(
                              child: Container(
                                height:  MediaQuery.of(context).size.width*0.5,
                                width: MediaQuery.of(context).size.width*0.6,
                                decoration:BoxDecoration(
                                    borderRadius:BorderRadius.circular(20),
                                    image:
                                    (authCubit.pickedImageXFiles2!.isNotEmpty)?
                                    DecorationImage(
                                        image:FileImage(
                                            File(authCubit.pickedImageXFiles2!.first.path)),
                                        fit:BoxFit.fill
                                    ):DecorationImage(image:NetworkImage('https://cdn3d.iconscout.com/3d/premium/thumb/business-success-6814314-5603427.png'))
                                ),
                              ),
                              onTap:(){
                                authCubit.pickMultiImage2();
                                //authCubit.showDialogBox2(context);
                              },
                            )
                                :InkWell(
                              child: Column(
                                children: [


                                  (dropdownValue=='طبيب')?
                                  Column(
                                    children: [

                                      Container(
                                        width: 160,
                                        decoration: BoxDecoration(
                                          borderRadius:BorderRadius.circular(20),
                                          color:ColorsManager.primary,
                                        ),
                                        //   radius: 100,
                                        child:Image.asset('assets/images/img2.jpg'),
                                      ),
                                      const SizedBox(height: 20,),

                                      const Custom_Text(text: 'صور لمؤهلات او شهادات او ما يميز ',color:Colors.black,
                                        fontSize:21,alignment:Alignment.center,
                                      ),
                                    ],
                                  ):SizedBox()
                                ],
                              ),
                              onTap:(){
                                authCubit.pickMultiImage2();
                                // authCubit.showDialogBox2(context);
                              },
                            ),
                          SizedBox(height: 18,),
                          Divider(
                            color:Colors.black,
                            thickness: 1,
                          ),
                            ( authCubit.pickedImageXFiles2!=null)?

                            (authCubit.pickedImageXFiles2!.length>1)?
                            InkWell(
                              child: Container(
                                height:  MediaQuery.of(context).size.width*0.5,
                                width: MediaQuery.of(context).size.width*0.6,
                                decoration:BoxDecoration(
                                    borderRadius:BorderRadius.circular(20),
                                    color: Colors.black,
                                    image:
                                    (authCubit.pickedImageXFiles2!.isNotEmpty)?
                                    DecorationImage(
                                        image:FileImage(
                                            File(authCubit.pickedImageXFiles2!.last.path)),
                                        fit:BoxFit.fill
                                    ):DecorationImage(image:NetworkImage('https://cdn3d.iconscout.com/3d/premium/thumb/business-success-6814314-5603427.png'))
                                ),
                              ),
                              onTap:(){
                                authCubit.pickMultiImage();
                                //authCubit.showDialogBox2(context);
                              },
                            ):SizedBox():SizedBox(height: 1,),

                            ( authCubit.pickedImageXFiles2!=null)?

                            (authCubit.pickedImageXFiles2!.length>2)?
                            InkWell(
                              child: Container(
                                height:  MediaQuery.of(context).size.width*0.5,
                                width: MediaQuery.of(context).size.width*0.6,
                                decoration:BoxDecoration(
                                    borderRadius:BorderRadius.circular(20),
                                    color: Colors.black,
                                    image:
                                    (authCubit.pickedImageXFiles2!.isNotEmpty)?
                                    DecorationImage(
                                        image:FileImage(
                                            File(authCubit.pickedImageXFiles2![1].path)),
                                        fit:BoxFit.fill
                                    ):DecorationImage(image:NetworkImage('https://cdn3d.iconscout.com/3d/premium/thumb/business-success-6814314-5603427.png'))
                                ),
                              ),
                              onTap:(){
                                authCubit.pickMultiImage();
                                //authCubit.showDialogBox2(context);
                              },
                            ):SizedBox():SizedBox(height: 1,),




                            // بيانات العيادة

                            const SizedBox(height: 30,),
                            const Custom_Text(text: 'بيانات خاصة بعملك',
                            color:Colors.black,
                              fontSize:23,
                              alignment:Alignment.center,
                            ),

                            const SizedBox(height: 10,),
                            Column(
                              children: [


                                SizedBox(
                                  height:80,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value.toString() == '' || value == null) {
                                        return 'ميعاد العمل  ';
                                      }
                                    },
                                    controller:  authCubit.timeController,
                                    style: TextStyle(fontSize:14,color:ColorsManager.primary),
                                    keyboardType: TextInputType.datetime,
                                    decoration: InputDecoration(
                                      hintText:'ميعاد بدا العمل ',
                                      hintStyle:  TextStyle(fontSize:13,color:ColorsManager.primary),
                                      fillColor: Colors.white,
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.timelapse_sharp),
                                        onPressed: () {
                                          showTimePicker(context: context,
                                              initialTime: TimeOfDay.now()).then((value) {
                                            print(value!.format(context).toString());
                                            authCubit.timeController.text =
                                                value.format(context).toString();
                                          });
                                        },
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(5.5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(5.5),

                                      ),
                                      filled: true,
                                    ),
                                    onTap: () {
                                      showTimePicker(context: context,
                                          initialTime: TimeOfDay.now()).then((value) {
                                        print(value!.format(context).toString());
                                        authCubit.timeController.text =
                                            value.format(context).toString();
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(height: 10,),
                                SizedBox(
                                  height:80,
                                  child: TextFormField(
                                    controller:  authCubit.timeControllerX,
                                    style: TextStyle(fontSize:14,color:ColorsManager.primary),
                                    keyboardType: TextInputType.datetime,
                                    decoration: InputDecoration(
                                      hintText:'ميعاد نهاية العمل ',
                                      hintStyle: TextStyle(fontSize:14,color:ColorsManager.primary),
                                      fillColor: Colors.white,
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.timelapse_sharp),
                                        onPressed: () {
                                          showTimePicker(context: context,
                                              initialTime: TimeOfDay.now()).then((value) {
                                            print(value!.format(context).toString());
                                            authCubit.timeControllerX.text =
                                                value.format(context).toString();
                                          });
                                        },
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(5.5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(5.5),

                                      ),
                                      filled: true,
                                    ),
                                    onTap: () {
                                      showTimePicker(context: context,
                                          initialTime: TimeOfDay.now()).then((value) {
                                        print(value!.format(context).toString());
                                        authCubit.timeControllerX.text =
                                            value.format(context).toString();
                                      });
                                    },
                                  ),
                                ),

                                const SizedBox(height: 10,),


                              ],
                            ),
                            (authCubit.x1==false)?
                            InkWell(child:
                            Column(
                              children: [
                                Icon(Icons.add,color:ColorsManager.primary,size:30,),
                                Custom_Text(text: 'اضافة مكان عمل ',
                                color:Colors.black, alignment:Alignment.center,
                                )
                              ],
                            ),
                            onTap:(){
                              authCubit.addNew();
                            },
                            ):  InkWell(child:
                           Icon(Icons.minimize,color:ColorsManager.primary,size:30,),
                              onTap:(){
                                authCubit.removeNew();
                              },
                            ),
                            const SizedBox(height: 10,),

                             // العيادة 2
                            (authCubit.x1==true)?
                            Column(
                              children: [

                                SizedBox(height: 10,),
                                CustomTextFormField(
                                  controller:authCubit.clinkName2,
                                  color:Colors.black,
                                  hint: "اسم مكان العمل  ",
                                  obs: false,
                                  max:2,
                                  obx: false,
                                  ontap:(){},
                                  type:TextInputType.text,
                                ),
                                SizedBox(height: 10,),
                                CustomTextFormField(
                                  controller:authCubit.clinkPhone4,
                                  color:Colors.black,
                                  hint: " رقم للتواصل  ",
                                  obs: false,
                                  max:2,
                                  obx: false,
                                  ontap:(){},
                                  type:TextInputType.phone,
                                ),
                                (dropdownCatValue=='طبيب')?
                                Column(
                                  children: [

                                    SizedBox(height: 10,),
                                    CustomTextFormField(
                                      controller:authCubit.clinkPhone5,
                                      color:Colors.black,
                                      hint: " رقم العيادة موبايل  ",
                                      obs: false,
                                      max:2,
                                      obx: false,
                                      ontap:(){},
                                      type:TextInputType.phone,
                                    ),

                                    SizedBox(height: 10,),
                                    CustomTextFormField(
                                      controller:authCubit.clinkPhone6,
                                      color:Colors.black,
                                      hint: " رقم العيادة واتس  ",
                                      obs: false,
                                      max:2,
                                      obx: false,
                                      ontap:(){},
                                      type:TextInputType.phone,
                                    ),



                                    SizedBox(height: 10,),
                                    CustomTextFormField(
                                      controller:authCubit.clinkPosition2,
                                      color:Colors.black,
                                      hint: " منصبك في هذا المكان  ",
                                      obs: false,
                                      max:2,
                                      obx: false,
                                      ontap:(){},
                                      type:TextInputType.text,
                                    ),
                                  ],
                                ):SizedBox(),



                                SizedBox(height: 10,),
                                CustomTextFormField(
                                  controller:authCubit.addressController2,
                                  color:Colors.black,
                                  hint: " المنطقة   ",
                                  max:2,
                                  obs: false,
                                  obx: false,
                                  ontap:(){},
                                  type:TextInputType.text,
                                ),

                                SizedBox(
                                  height:80,
                                  child: TextFormField(

                                    controller:  authCubit.timeController2,
                                    style:const TextStyle(fontSize:14,color:Colors.blue),
                                    keyboardType: TextInputType.datetime,
                                    decoration: InputDecoration(
                                      hintText:'ميعاد بدا العمل ',
                                      hintStyle: const  TextStyle(fontSize:13,color:Colors.blue),
                                      fillColor: Colors.white,
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.timelapse_sharp),
                                        onPressed: () {
                                          showTimePicker(context: context,
                                              initialTime: TimeOfDay.now()).then((value) {
                                            print(value!.format(context).toString());
                                            authCubit.timeController2.text =
                                                value.format(context).toString();
                                          });
                                        },
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(5.5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(5.5),

                                      ),
                                      filled: true,
                                    ),
                                    onTap: () {
                                      showTimePicker(context: context,
                                          initialTime: TimeOfDay.now()).then((value) {
                                        print(value!.format(context).toString());
                                        authCubit.timeController2.text =
                                            value.format(context).toString();
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                SizedBox(
                                  height:80,
                                  child: TextFormField(

                                    controller:  authCubit.timeControllerX2,
                                    style:const TextStyle(fontSize:14,color:Colors.blue),
                                    keyboardType: TextInputType.datetime,
                                    decoration: InputDecoration(
                                      hintText:'ميعاد نهاية العمل ',
                                      hintStyle: const TextStyle(fontSize:13,color:Colors.blue),
                                      fillColor: Colors.white,
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.timelapse_sharp),
                                        onPressed: () {
                                          showTimePicker(context: context,
                                              initialTime: TimeOfDay.now()).then((value) {
                                            print(value!.format(context).toString());
                                            authCubit.timeControllerX2.text =
                                                value.format(context).toString();
                                          });
                                        },
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(5.5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(5.5),

                                      ),
                                      filled: true,
                                    ),
                                    onTap: () {
                                      showTimePicker(context: context,
                                          initialTime: TimeOfDay.now()).then((value) {
                                        print(value!.format(context).toString());
                                        authCubit.timeControllerX2.text =
                                            value.format(context).toString();
                                      });
                                    },
                                  ),
                                ),


                                const SizedBox(height: 10,),

                              ],
                            ):const SizedBox(height: 10,),


                            (authCubit.x2==false)?
                            InkWell(child:
                            Column(
                              children:  [
                                Icon(Icons.add,color:ColorsManager.primary,size:30,),
                                Custom_Text(text: 'اضافة مكان عمل ',
                                  color:Colors.black, alignment:Alignment.center,
                                )
                              ],
                            ),
                              onTap:(){
                                authCubit.addNew2();
                              },
                            ):  InkWell(child:
                             Icon(Icons.minimize,color:ColorsManager.primary,size:30,),
                              onTap:(){
                                authCubit.removeNew2();
                              },
                            ),

                            // عيادة 3
                            (authCubit.x2==true)?
                            Column(
                              children: [
                                SizedBox(height: 10,),
                                CustomTextFormField(
                                  controller:authCubit.clinkName3,
                                  color:Colors.black,
                                  hint: "اسم مكان العمل  ",
                                  obs: false,
                                  max:2,
                                  obx: false,
                                  ontap:(){},
                                  type:TextInputType.text,
                                ),
                                SizedBox(height: 10,),
                                CustomTextFormField(
                                  controller:authCubit.clinkPhone7,
                                  color:Colors.black,
                                  hint: " رقم للتواصل   ",
                                  obs: false,
                                  max:2,
                                  obx: false,
                                  ontap:(){},
                                  type:TextInputType.phone,
                                ),

                                SizedBox(height: 10,),
                                (dropdownValue=='طبيب')?
                                Column(
                                  children: [
                                    CustomTextFormField(
                                      controller:authCubit.clinkPhone8,
                                      color:Colors.black,
                                      hint: " رقم العيادة موبايل  ",
                                      obs: false,
                                      max:2,
                                      obx: false,
                                      ontap:(){},
                                      type:TextInputType.phone,
                                    ),
                                    SizedBox(height: 10,),
                                    CustomTextFormField(
                                      controller:authCubit.clinkPosition3,
                                      color:Colors.black,
                                      hint: " منصبك في هذا المكان  ",
                                      obs: false,
                                      max:2,
                                      obx: false,
                                      ontap:(){},
                                      type:TextInputType.text,
                                    ),
                                  ],
                                ):SizedBox(),

                                SizedBox(height: 10,),
                                CustomTextFormField(
                                  controller:authCubit.clinkPhone9,
                                  color:Colors.black,
                                  hint: " رقم العيادة واتس  ",
                                  obs: false,
                                  max:2,
                                  obx: false,
                                  ontap:(){},
                                  type:TextInputType.phone,
                                ),





                                CustomTextFormField(
                                  controller:authCubit.addressController3,
                                  color:Colors.black,
                                  hint: " المنطقة   ",
                                  max:2,
                                  obs: false,
                                  obx: false,
                                  ontap:(){},
                                  type:TextInputType.text,
                                ),

                                const SizedBox(height: 10,),
                                SizedBox(
                                  height:80,
                                  child: TextFormField(
                                    controller:  authCubit.timeController3,
                                    style:const TextStyle(fontSize:14,color:Colors.blue),
                                    keyboardType: TextInputType.datetime,
                                    decoration: InputDecoration(
                                      hintText:'ميعاد بدا العمل ',
                                      hintStyle: const TextStyle(fontSize:13,color:Colors.blue),
                                      fillColor: Colors.white,
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.timelapse_sharp),
                                        onPressed: () {
                                          showTimePicker(context: context,
                                              initialTime: TimeOfDay.now()).then((value) {
                                            print(value!.format(context).toString());
                                            authCubit.timeController3.text =
                                                value.format(context).toString();
                                          });
                                        },
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(5.5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(5.5),

                                      ),
                                      filled: true,
                                    ),
                                    onTap: () {
                                      showTimePicker(context: context,
                                          initialTime: TimeOfDay.now()).then((value) {
                                        print(value!.format(context).toString());
                                        authCubit.timeController3.text =
                                            value.format(context).toString();
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height:80,
                                  child: TextFormField(

                                    controller:  authCubit.timeControllerX3,
                                    style:const TextStyle(fontSize:14,color:Colors.blue),
                                    keyboardType: TextInputType.datetime,
                                    decoration: InputDecoration(
                                      hintText:'ميعاد نهاية العمل ',
                                      hintStyle: const TextStyle(fontSize:13,color:Colors.blue),
                                      fillColor: Colors.white,
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.timelapse_sharp),
                                        onPressed: () {
                                          showTimePicker(context: context,
                                              initialTime: TimeOfDay.now()).then((value) {
                                            print(value!.format(context).toString());
                                            authCubit.timeControllerX3.text =
                                                value.format(context).toString();
                                          });
                                        },
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(5.5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(5.5),

                                      ),
                                      filled: true,
                                    ),
                                    onTap: () {
                                      showTimePicker(context: context,
                                          initialTime: TimeOfDay.now()).then((value) {
                                        print(value!.format(context).toString());
                                        authCubit.timeControllerX3.text =
                                            value.format(context).toString();
                                      });
                                    },
                                  ),
                                ),

                                const SizedBox(height: 10,),

                              ],
                            ):const SizedBox(height: 10,),


                            const SizedBox(height: 20,),
                            CustomButton(text: "تسجيل",
                                onPressed: (){

                                final box=GetStorage();
                                box.remove('pay');

                                authCubit.addNewFilter();

                                authCubit.addNewPlaces();

                                authCubit.addNewPlaces2();

                                authCubit.validateDocPhone(
                                     dropdownValue, dropdownCatValue,
                                    widget.sales,widget.adsNum,widget.days
                                );


                                }, color1:ColorsManager.primary,
                                color2: Colors.white),
                            const SizedBox(height: 30,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }));
  }



}
