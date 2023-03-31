import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:userapp/screens/location/location.dart';

import '../constants/colors.dart';
import 'addnewvehicle_screen.dart';

class MyVehicles extends StatefulWidget {
  const MyVehicles({Key? key}) : super(key: key);

  @override
  State<MyVehicles> createState() => _MyVehiclesState();
}

class _MyVehiclesState extends State<MyVehicles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: singInWithFacebookButtonColor,
      appBar: AppBar(
        backgroundColor: backgroundColorLoginScreen,
        automaticallyImplyLeading: false,
        title: const Text(
          "My Vehicles",
          style: TextStyle(
              color: singInWithGoogleButtonColor,
              fontWeight: FontWeight.w600,
              fontSize: 20.0),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width,
                    // padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    margin: const EdgeInsets.symmetric(
                        vertical: 3.0, horizontal: 15),
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
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 65,
                              width: 64,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 3.0, horizontal: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0),
                                  border:
                                      Border.all(color: Colors.grey.shade400),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      offset: const Offset(0.1, 0.1),
                                      blurRadius: 5,
                                    )
                                  ]),
                              child: const Icon(
                                Icons.add_circle_outline_outlined,
                                size: 36,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "KIA, SPORTAGE",
                                  style: GoogleFonts.actor(
                                      fontWeight: FontWeight.w900,
                                      color: singInWithGoogleButtonColor),
                                ),
                                const SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                  "2018, WHITE",
                                  style: GoogleFonts.actor(
                                      fontWeight: FontWeight.w200,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 200,
                            ),
                            InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: Colors.redAccent,
                                ))
                          ],
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.leftToRight,
                                    alignment: Alignment.bottomCenter,
                                    duration: const Duration(milliseconds: 500),
                                    child: const LocationScreen()));
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 35),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.grey.shade400),
                              gradient: const LinearGradient(colors: [
                                backgroundColorLoginScreen,
                                backgroundColorLoginScreen1,
                              ]),
                            ),
                            child: Text(
                              "Time To Wash",
                              style: GoogleFonts.actor(
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.0,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.leftToRight,
                  alignment: Alignment.bottomCenter,
                  child: const AddNewVehicle()));
        },
        child: Container(
            height: 130,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 60),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Colors.grey.shade400),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0.1, 0.1),
                    blurRadius: 5,
                  )
                ]),
            child: ListTile(
              title: const Icon(
                Icons.add_circle_outline_rounded,
                size: 35,
                color: Colors.green,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(left: 90.0, top: 3.0),
                child: Text(
                  "Add New Vehicle",
                  style: GoogleFonts.actor(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                      fontSize: 18,
                      color: Colors.grey),
                ),
              ),
            )),
      ),
    );
  }
}
