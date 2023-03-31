import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class VehicleWashTimeScreen extends StatefulWidget {
  const VehicleWashTimeScreen({Key? key}) : super(key: key);

  @override
  State<VehicleWashTimeScreen> createState() => _VehicleWashTimeScreenState();
}

class _VehicleWashTimeScreenState extends State<VehicleWashTimeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: singInWithFacebookButtonColor,
      appBar: AppBar(
        backgroundColor: backgroundColorLoginScreen,
        automaticallyImplyLeading: false,
        title: const Text(
          "Select Arrival Time",
          style: TextStyle(
              color: singInWithGoogleButtonColor,
              fontWeight: FontWeight.w600,
              fontSize: 20.0),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              // padding: const EdgeInsets.symmetric(horizontal: 15.0),
              margin: const EdgeInsets.symmetric(
                  vertical: 3.0, horizontal: 5),
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
                    ],
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: (){},
              child: Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                      vertical: 1.0, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(color: Colors.grey.shade400),
                    gradient: const LinearGradient(colors: [
                      backgroundColorLoginScreen,
                      backgroundColorLoginScreen1,
                    ]),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ARRIVAL TIME",
                        style: GoogleFonts.actor(
                            color: singInWithFacebookButtonColor),
                      ),
                      const SizedBox(height: 3.0,),
                      Text(
                        "TODAY, 6 PM - 7 PM",
                        style: GoogleFonts.actor(
                            letterSpacing: 2.0,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
              ),
            ),
            const SizedBox(height: 30.0,),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index){
                  return Column(
                    children: [
                      Container(
                        height: 210,
                        width: MediaQuery.of(context).size.width,
                        // padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        margin: const EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 20.0),
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
                          children:  [
                            const SizedBox(
                              height: 10,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Icon(Icons.favorite_border, color: Colors.grey,)),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Column(
                              children:  [
                                Row(
                                  children: [
                                    const SizedBox(width: 198),
                                    Column(
                                      children: [
                                        const Text(
                                          "Bori Wash",
                                          style: TextStyle(
                                              color: singInWithGoogleButtonColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20.0),
                                        ),
                                        const SizedBox(height: 3.0,),
                                        Row(
                                          children:  const [
                                            Text("(82)"),
                                            Icon(Icons.star, color: Colors.yellow,),
                                            Icon(Icons.star, color: Colors.yellow,),
                                            Icon(Icons.star, color: Colors.yellow,),
                                            Icon(Icons.star, color: Colors.yellow,),
                                            Icon(Icons.star, color: Colors.yellow,),

                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                        height: 65,
                                        width: 64,
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 3.0, horizontal: 15.0),
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
                                        child: Image.asset("assets/images/car.png", height: 50,)
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Divider(color: Colors.grey.withOpacity(0.2), thickness: 2.0,),
                            const SizedBox(height: 10.0,),
                            const Text(
                              "Whole Car Wash",
                              style: TextStyle(
                                  color: singInWithGoogleButtonColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0),
                            ),
                            const SizedBox(height: 4.0,),
                            const Text(
                              "70 ILS",
                              style: TextStyle(
                                  color: backgroundColorLoginScreen,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0),
                            ),

                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

