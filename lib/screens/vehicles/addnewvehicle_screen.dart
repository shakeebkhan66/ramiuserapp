import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:userapp/screens/constants/colors.dart';
import 'package:userapp/screens/providers/googlesigninprovider.dart';
import 'package:userapp/screens/vehicles/drawer_screen.dart';
import 'package:userapp/screens/vehicles/myvehicles.dart';
import 'dart:io';
import '../api/api_screen.dart';
import '../models/addvehicle_model.dart';

class AddNewVehicle extends StatefulWidget {
  static const routeName = '/addNewVehicleScreen';
  const AddNewVehicle({Key? key}) : super(key: key);

  @override
  State<AddNewVehicle> createState() => _AddNewVehicleState();
}

class _AddNewVehicleState extends State<AddNewVehicle> {
  int? tappedIndex;
  File? pickedImage;
  String? imagePath;

  // TODO Instance of ApiScreen
  ApiScreen apiScreen = ApiScreen();

  // TODO TextEditingController
  TextEditingController nickNameController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();

  String? image;
  String? typeOfVehicle;

  List<String> namesList = [
    "sedan, coupe, sport, mini, or similar",
    "suv 7 seater, long pickups",
    "vans all kinds",
    "caravans, all kinds"
  ];
  List imageList = [
    "https://cdn-icons-png.flaticon.com/512/744/744465.png",
    "https://cdn-icons-png.flaticon.com/512/3772/3772837.png",
    "https://cdn-icons-png.flaticon.com/512/3063/3063760.png",
    "https://cdn-icons-png.flaticon.com/512/10225/10225738.png",
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: singInWithFacebookButtonColor,
      appBar: AppBar(
        backgroundColor: backgroundColorLoginScreen,
        automaticallyImplyLeading: false,
        title: const Text(
          "Add Vehicle",
          style: TextStyle(
              color: singInWithGoogleButtonColor,
              fontWeight: FontWeight.w600,
              fontSize: 20.0),
        ),
        actions: [
          IconButton(
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout(context);
              },
              icon: const Icon(Icons.logout)),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 20),
            child: MaterialButton(
              onPressed: () {
                apiScreen.addVehicle(
                    nickNameController.text,
                    yearController.text,
                    tappedIndex,
                    plateNumberController.text,
                    image,
                    context);
              },
              minWidth: 90,
              color: singInWithFacebookButtonColor,
              child: const Text(
                "Done",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: singInWithGoogleButtonColor),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                "Select Vehicle Type",
                style: TextStyle(
                    color: singInWithGoogleButtonColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0),
              ),
            ),
            const SizedBox(height: 25),
            ListView.builder(
                shrinkWrap: true,
                itemCount: namesList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                          height: 110,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 15),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.grey.shade400),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  offset: const Offset(0.1, 0.1),
                                  blurRadius: 5,
                                )
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                imageList[index],
                                height: 50,
                              ),
                              ListTile(
                                trailing: Visibility(
                                  visible: tappedIndex == index,
                                  child: const Icon(
                                    FontAwesomeIcons.circleCheck,
                                    color: backgroundColorLoginScreen,
                                  ),
                                ),
                                title: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    namesList[index],
                                    style: GoogleFonts.actor(
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.0,
                                        fontSize: 16,
                                        color: Colors.grey),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    tappedIndex = index;
                                    print("Image ${imageList[tappedIndex!]}");
                                    print("Type ${namesList[tappedIndex!]}");
                                    image = imageList[tappedIndex!];
                                    typeOfVehicle = namesList[tappedIndex!];
                                  });
                                },
                                onLongPress: () {
                                  setState(() {
                                    tappedIndex = -1;
                                  });
                                },
                              ),
                            ],
                          ))
                    ],
                  );
                }),
            const SizedBox(height: 15),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                "Vehicle Details",
                style: TextStyle(
                    color: singInWithGoogleButtonColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 25),
              child: const Text(
                "Nic Name",
                style: TextStyle(
                    color: singInWithGoogleButtonColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 27, vertical: 7.0),
              child: TextFormField(
                controller: nickNameController,
                decoration: InputDecoration(
                    hintText: "KIA, SPORTAGE",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: backgroundColorLoginScreen),
                      borderRadius: BorderRadius.circular(8.0),
                    )),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 25),
              child: const Text(
                "Year",
                style: TextStyle(
                    color: singInWithGoogleButtonColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 27, vertical: 7.0),
              child: TextFormField(
                controller: yearController,
                decoration: InputDecoration(
                    hintText: "2018",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: backgroundColorLoginScreen),
                      borderRadius: BorderRadius.circular(8.0),
                    )),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 25),
              child: const Text(
                "PlateNumber",
                style: TextStyle(
                    color: singInWithGoogleButtonColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 27, vertical: 7.0),
              child: TextFormField(
                controller: plateNumberController,
                decoration: InputDecoration(
                    hintText: "NC54-86-74",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: backgroundColorLoginScreen),
                      borderRadius: BorderRadius.circular(8.0),
                    )),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            // Padding(
            //     padding: const EdgeInsets.only(
            //       top: 10,
            //     ),
            //     child: Column(
            //       children: [
            //         Container(
            //           alignment: Alignment.topLeft,
            //           padding: const EdgeInsets.only(left: 25),
            //           child: pickedImage != null ? const Text(
            //             "Picked",
            //             style: TextStyle(
            //                 color: singInWithGoogleButtonColor,
            //                 fontWeight: FontWeight.w500,
            //                 fontSize: 15.0),
            //           ) : const Text(
            //             "Picked",
            //             style: TextStyle(
            //                 color: singInWithGoogleButtonColor,
            //                 fontWeight: FontWeight.w500,
            //                 fontSize: 15.0),
            //           )
            //         ),
            //         InkWell(
            //             onTap: () {
            //               showDialog(
            //                 context: context,
            //                 builder: (ctx) => AlertDialog(
            //                   title: const Text(
            //                     "Select One",
            //                     style: TextStyle(
            //                         fontSize: 20.0,
            //                         fontWeight: FontWeight.w600,
            //                         color: singInWithGoogleButtonColor),
            //                   ),
            //                   actions: <Widget>[
            //                     Row(
            //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                       children: [
            //                         TextButton(
            //                             onPressed: () {
            //                               getImage(ImageSource.camera);
            //                               Navigator.pop(context);
            //                             },
            //                             child: const Text(
            //                               "Camera",
            //                               style: TextStyle(
            //                                   fontSize: 15.0,
            //                                   color: Colors.black87),
            //                             )),
            //                         TextButton(
            //                             onPressed: () {
            //                               getImage(ImageSource.gallery);
            //                               Navigator.pop(context);
            //                             },
            //                             child: const Text(
            //                               "Gallery",
            //                               style: TextStyle(
            //                                   fontSize: 15.0,
            //                                   color: Colors.black87),
            //                             )),
            //                       ],
            //                     )
            //                   ],
            //                 ),
            //               );
            //             },
            //             child: pickedImage != null
            //                 ? CircleAvatar(
            //               radius: 50.0,
            //               backgroundColor: Colors.white,
            //               child: ClipOval(
            //                   child: Image.file(
            //                     File(pickedImage!.path),
            //                     fit: BoxFit.cover,
            //                   )),
            //             )
            //                 : CircleAvatar(
            //               radius: 50.0,
            //               backgroundColor: Colors.white,
            //               child: Image.asset("assets/images/car.png"),
            //             ))
            //       ],
            //     )
            // ),
            // const SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
