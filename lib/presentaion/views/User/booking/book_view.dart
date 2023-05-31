import 'package:doctors_app/presentaion/bloc/booking/booking_cubit.dart';
import 'package:doctors_app/presentaion/bloc/booking/booking_states.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/widgets/Custom_Text.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:doctors_app/presentaion/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../resources/assets_manager.dart';
import '../Home/dash_board.dart';

 class BookingView extends StatefulWidget {

  String doctorId,days,doctorToken;

 BookingView({required this.doctorId,required this.days,required this.doctorToken});

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {

  DateTime  dateTime=DateTime.now();
  String? day;

  @override
  Widget build(BuildContext context) {


    return BlocProvider(
        create: (BuildContext context) => BookingCubit(),
        child: BlocConsumer<BookingCubit, BookingStates>(
        listener: (context, state) {

          if( state is AddBookingSuccessState){
            print("DDDDONNNNE");
            Get.offAll(const DashBoardFragment());

          }

        },
    builder: (context, state) {
      BookingCubit cubit = BookingCubit.get(context);

    return Scaffold(
      backgroundColor: ColorsManager.primaryx,
      appBar:AppBar(
        toolbarHeight: 6,
        elevation: 0,
        backgroundColor:ColorsManager.primary,
      ),
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children:
          [
        Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                 color:Colors.white
              ),
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsManager.Logo),
              ),
            ),
            const SizedBox(height: 6,),
          Custom_Text(text: 'قم بادخال بيانات الحجز',fontSize: 21,color:Colors.black,alignment:Alignment.center,),
          SizedBox(height: 20,),
          Column(
            children: [
              const SizedBox(height: 10,),
              CustomTextFormField(hint: 'الاسم',
                  obx: false, ontap:(){},
                  type:TextInputType.text, obs: false,
                  color: Colors.black, controller:cubit.nameController),

              const SizedBox(height: 30,),
              CustomTextFormField(hint: 'رقم الهاتف ',
                  obx: false, ontap:(){},
                  type:TextInputType.phone, obs: false,
                  color: Colors.black, controller:cubit.phoneController),

              const SizedBox(height: 30,),

              CustomTextFormField(hint: 'مدينتك  ',
                  obx: false, ontap:(){},
                  type:TextInputType.text, obs: false,
                  color: Colors.black, controller:cubit.cityController),

              const SizedBox(height: 30,),
              CustomTextFormField(hint: 'السن ',
                  obx: false, ontap:(){},
                  type:TextInputType.number, obs: false,
                  color: Colors.black, controller:cubit.ageController),

              const SizedBox(height: 30,),
              SizedBox(
                height:100,
                child: TextFormField(
                  validator: (value) {
                    if (value.toString() == '' || value == null) {
                      return 'ادخل الميعاد ';
                    }
                  },
                  controller: cubit.dayController,
                  style:TextStyle(fontSize:14,color:ColorsManager.primary),
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    hintText:'ميعاد الكشف',
                    hintStyle:  TextStyle(fontSize:16,color:ColorsManager.primary),
                    fillColor: Colors.white,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.timelapse_sharp),
                      onPressed: () {
                        showTimePicker(context: context,
                            initialTime: TimeOfDay.now()).then((value) {
                          print(value!.format(context).toString());
                          cubit.dayController.text =
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
                      cubit.dayController.text =
                          value.format(context).toString();
                    });
                  },
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              SizedBox(height: 30,),

              if(widget.days.split(',').length>2)
              Container(
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(30),
                  color:Colors.white
                ),
               height: 180,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount:widget.days.split(',').length,
                  itemBuilder: (context, index) {
                    return RadioListTile(
                      title: Text(widget.days.split(',')[index]),
                      value: widget.days.split(',')[index],
                      groupValue: day,
                      onChanged: (value){
                        setState(() {
                         day = value.toString();
                        });
                      },
                    );
                  }),
              ),

              if(widget.days.split(',').length<=2)
                Container(
                  decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(30),
                      color:Colors.white
                  ),
                  height: 130,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:widget.days.split(',').length,
                      itemBuilder: (context, index) {
                        return RadioListTile(
                          title: Text(widget.days.split(',')[index]),
                          value: widget.days.split(',')[index],
                          groupValue: day,
                          onChanged: (value){
                            setState(() {
                              day = value.toString();
                            });
                          },
                        );
                      }),
                ),

              Divider(
                color: Colors.black,
              ),
              const SizedBox(height: 30,),
              CustomTextFormField(hint: 'تفاصيل',
                  obx: false, ontap:(){},
                  type:TextInputType.text, obs: false,
                  max: 5,
                  color: Colors.black, controller:cubit.dataController)

            ],
          ),


            const SizedBox(height: 30,),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomButton(text: 'تاكيد الحجز ', onPressed: (){


                cubit.addNewBooking(widget.doctorId,day.toString(),widget.doctorToken);

              }, color1: ColorsManager.primary, color2: Colors.white),
            )
          ],
        ),
      )
    );
    }));
  }
}


