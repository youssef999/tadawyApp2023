import 'dart:collection';
import 'package:doctors_app/presentaion/bloc/auth/auth_states.dart';
import 'package:doctors_app/presentaion/const/app_message.dart';
import 'package:doctors_app/presentaion/resources/color_manager.dart';
import 'package:doctors_app/presentaion/widgets/Custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../bloc/auth/auth_cubit.dart';


class Map1 extends StatefulWidget {

  double l1, l2;
  num total;


  Map1(this.l1, this.l2, this.total);

  @override
  _Map1State createState() => _Map1State();
}


class _Map1State extends State<Map1> {
  var locationMessage = "";
  var position;
  var l1 = 37.43296265331129;
  var l2 = -122.08832357078792;
  String? country='';
  String? city='';
  String? address='';
  GoogleMapController ? newGooGleMapController;
  LatLng ?latLng;
  CameraPosition ?cameraPosition;
  CameraPosition initCameraPosition() =>
      CameraPosition(target: LatLng(l1, l2), zoom: 6);
  @override
  void initState() {
    super.initState();
    // Coordinates coordinates = Coordinates(latLng.l1, latLng.l2);
    //
    // List<Address> addresses =await Geocoder.google(apiKey,language:'ar').findAddressesFromCoordinates(coordinates);

    getData();
    // getData();
    // getData();
  }
  void currentLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    latLng = LatLng(position.latitude, position.longitude);
    cameraPosition = CameraPosition(target: latLng!, zoom: 14);
    var lastposition = await Geolocator.getLastKnownPosition();
    l1 = position.latitude;
    l2 = position.longitude;

    //collection
    print(lastposition);
    print("lll=" + locationMessage);
    print(
      "ooo=" + position.latitude.toString(),
    );
    print(
      "yyy=" + position.longitude.toString(),
    );

    setState(() {
      locationMessage = "$position";
      l1 = position.latitude;
      l2 = position.longitude;
    });
  }

  Future<void> getData() async {

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.lowest,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    Placemark placemark = placemarks.first;
    print(placemark);
    country = placemark.country!.replaceAll('Egypt', 'مصر');
    city = placemark.administrativeArea!;
        //.replaceAll('Cairo Governorate', 'القاهرة').replaceAll('Alexandria Governorate', 'الاسكندرية');
   address = placemark.toString();
  }

  @override
  Widget build(BuildContext context) {
    var markers = HashSet<Marker>();
    return BlocProvider(
        create: (BuildContext context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthStates>(
            listener: (context, state) async {

            },
            builder: (context, state) {
              AuthCubit authCubit = AuthCubit.get(context);
              return Scaffold(
                appBar: AppBar(
                  toolbarHeight: 1,
                  backgroundColor: ColorsManager.primary,
                  automaticallyImplyLeading: false,
                  // leading: Icon(
                  //   Icons.arrow_back,
                  //   color: Colors.black,
                  // ),
                ),
                body: Column(
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 530,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                            target: LatLng(widget.l1, widget.l2),
                            zoom: 19.151926040649414),
                        onMapCreated: (
                            GoogleMapController googleMapController) {
                          setState(() {
                            markers.add(Marker(
                                markerId: MarkerId('1'),
                                visible: true,
                                draggable: true,
                                position: LatLng(widget.l1, widget.l2),
                                infoWindow:
                                InfoWindow(title: 'Luban 999', snippet: 'ssss'),
                                onTap: () {
                                  print("marker");
                                },
                                onDragEnd: (LatLng) {
                                  print(LatLng);
                                }));
                          });
                        },
                        markers: markers,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    CustomButton(text: 'تاكيد', onPressed: () {
                      getData();
                      print(country);
                      print(city);
                      print(address);

                      final box = GetStorage();
                      box.write('l1', l1);
                      box.write('l2', l2);
                      authCubit.changeLocationButton();
                      Get.back();
                      // currentLocation();
                    }, color1: ColorsManager.primary, color2: Colors.white),

                    SizedBox(
                      height: 25,
                    ),

                  ],
                ),
              );
            }));
  }
}