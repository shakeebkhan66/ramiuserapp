import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:userapp/screens/constants/colors.dart';
import 'package:userapp/screens/providers/googlesigninprovider.dart';

class AddNewVehicle extends StatefulWidget {
  const AddNewVehicle({Key? key}) : super(key: key);

  @override
  State<AddNewVehicle> createState() => _AddNewVehicleState();
}

class _AddNewVehicleState extends State<AddNewVehicle> {
  int? tappedIndex;

  List<String> namesList = [
    "sedan, coupe, sport, mini, or similar",
    "suv 7 seater, long pickups",
    "vans all kinds",
    "caravans, all kinds"
  ];
  List imageList = [
    "assets/images/car.png",
    "assets/images/car.png",
    "assets/images/car.png",
    "assets/images/car.png",
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
              onPressed: (){
                final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout(context);
              },
              icon: const Icon(Icons.logout)),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 20),
            child: MaterialButton(
              onPressed: () {
                Navigator.pop(context);
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
                      // const Divider(
                      //   thickness: 1.0,
                      //   color: Colors.green,
                      // ),
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
                              Image.asset(
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
            const SizedBox(height: 25),
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
              padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 7.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "KIA, SPORTAGE",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: backgroundColorLoginScreen),
                    borderRadius: BorderRadius.circular(8.0),
                  )
                ),
              ),
            ),
            const SizedBox(height: 20),
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
              padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 7.0),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "2018",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: backgroundColorLoginScreen),
                      borderRadius: BorderRadius.circular(8.0),
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
