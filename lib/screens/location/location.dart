import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:userapp/screens/constants/colors.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart' as location;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;

import '../vehicles/selecttime_screen.dart';


class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double? latitude;
  double? longitude;
  List<Marker> marker = [];
  List<Marker> list = [];

  TextEditingController controller = TextEditingController();
  var uuid = const Uuid();

  String sessionToken = "12234";
  List<dynamic> placesList = [];

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();


  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 19,
  );

  void onChange() {
    if (sessionToken == null) {
      setState(() {
        sessionToken = uuid.v4();
      });
    }
    getSuggestion(controller.text);
  }

  // TODO Get Suggestion From Google Api
  void getSuggestion(String input) async {
    String kPLACES_API_KEY = "AIzaSyBuVSOPCqda10ViO3L28Om0v2z_Pd8wgQg";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$sessionToken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print("data");
    print(data);

    if (response.statusCode == 200) {
      setState(() {
        placesList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception("Failed to load data");
    }
  }

  // TODO My Modal Bottom Sheet
  _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        isDismissible: true,
        enableDrag: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
        builder: (context) => DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.4,
              maxChildSize: 0.8,
              minChildSize: 0.4,
              builder: (context, scrollController) => Column(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  InkWell(
                    onTap: (){
                      animateCameraPosition();
                    },
                    child: const Icon(
                      Icons.my_location,
                      color: singInWithGoogleButtonColor,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: "Search places with name",
                        hintStyle:
                            const TextStyle(color: singInWithGoogleButtonColor),
                        fillColor: singInWithFacebookButtonColor,
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.flag,
                          color: singInWithGoogleButtonColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                                color: backgroundColorLoginScreen)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                                color: singInWithGoogleButtonColor)),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 30, top: 10),
                    child: const Text(
                      "Suggested Destinations",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: placesList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () async {
                            List<Location> locations =
                                await locationFromAddress(
                                    placesList[index]['description']);
                            print(locations.last.latitude);
                            print(locations.last.longitude);
                            setState(() {
                              controller.text =
                                  placesList[index]['description'];
                              latitude = locations.last.latitude;
                              longitude = locations.last.longitude;
                            });
                            animateCameraPosition();
                          },
                          title: Text(placesList[index]['description']),
                          leading: const Icon(
                            Icons.location_on_rounded,
                            color: singInWithGoogleButtonColor,
                          ),
                        );
                      },
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.leftToRight,
                              alignment: Alignment.bottomCenter,
                              duration: const Duration(milliseconds: 500),
                              child: const VehicleWashTimeScreen()));
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 90),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.grey.shade400),
                        gradient: const LinearGradient(colors: [
                          backgroundColorLoginScreen,
                          backgroundColorLoginScreen1,
                        ]),
                      ),
                      child: Text(
                        "Next",
                        style: GoogleFonts.actor(
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.0,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ));
  }

  // TODO Animate Camera Function
  Future<void> animateCameraPosition() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(latitude!, longitude!), zoom: 20)));

    list =  [
      Marker(
          markerId: const MarkerId("1"),
          position: LatLng(latitude!, longitude!)
      )
    ];
  }


  // TODO GetBytesFromData
  Future<Uint8List> getBytesFromAsset({String? path,int? width})async {
    ByteData data = await rootBundle.load(path!);
    ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: width
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(
        format: ui.ImageByteFormat.png))
        !.buffer.asUint8List();
  }



  // TODO OnMapCreated Function
  void _onMapCreated(GoogleMapController controller) async{
    _controller.complete(controller);
  }


  // TODO Location Permission
  locationPermission() async {
    PermissionStatus locationStatus = await Permission.location.request();
    if(locationStatus == PermissionStatus.granted) {
      _showModalBottomSheet(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Permission Granted")));
    }
    if (locationStatus == PermissionStatus.denied) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("We need your location to keep working")));
    }
    if (locationStatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Now you need to go  app setting and allow permission")));
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(() {
      onChange();
    });

    marker.addAll(list);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: singInWithFacebookButtonColor,
      appBar: AppBar(
        backgroundColor: backgroundColorLoginScreen,
        automaticallyImplyLeading: false,
        title: const Text(
          "Google Map",
          style: TextStyle(
              color: singInWithGoogleButtonColor,
              fontWeight: FontWeight.w600,
              fontSize: 20.0),
        ),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        onMapCreated: _onMapCreated,
        markers: Set<Marker>.of(marker)
      ),
      floatingActionButton: InkWell(
        onTap: () {
          locationPermission();
        },
        child: Container(
          height: 60,
          width: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: backgroundColorLoginScreen,
              borderRadius: BorderRadius.circular(30.0)),
          child: const Text(
            "Search\nLocation",
            style: TextStyle(
                color: singInWithGoogleButtonColor,
                fontSize: 13,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
