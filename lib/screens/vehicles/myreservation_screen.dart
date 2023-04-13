import 'package:flutter/material.dart';
import 'package:userapp/screens/constants/colors.dart';

class MyReservationScreen extends StatefulWidget {
  static const routeName = '/myReservationScreen';
  const MyReservationScreen({Key? key}) : super(key: key);

  @override
  State<MyReservationScreen> createState() => _MyReservationScreenState();
}

class _MyReservationScreenState extends State<MyReservationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: singInWithFacebookButtonColor,
      body: SafeArea(
        child: ListView.builder(
          itemCount: 3,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(
                      vertical: 3.0, horizontal: 15.0),
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
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.grey,
                            )),
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 198),
                              Column(
                                children: [
                                  const Text(
                                    "Bori Wash",
                                    style: TextStyle(
                                        color:
                                        singInWithGoogleButtonColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.0),
                                  ),
                                  const SizedBox(
                                    height: 3.0,
                                  ),
                                  Row(
                                    children: const [
                                      Text("(82)"),
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
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
                                      borderRadius:
                                      BorderRadius.circular(5.0),
                                      border: Border.all(
                                          color: Colors.grey.shade400),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey
                                              .withOpacity(0.4),
                                          offset: const Offset(0.1, 0.1),
                                          blurRadius: 5,
                                        )
                                      ]),
                                  child: Image.asset(
                                    "assets/images/car.png",
                                    height: 50,
                                  )),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(0.2),
                        thickness: 2.0,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        "Whole Car Wash",
                        style: TextStyle(
                            color: singInWithGoogleButtonColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0),
                      ),
                      const SizedBox(
                        height: 7.0,
                      ),
                      const Text(
                        "29 Mar, 8:00 - 9:00 PM",
                        style: TextStyle(
                            color: backgroundColorLoginScreen,
                            fontSize: 20.0),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      const Text(
                        "Status: Waiting for My Confirmation",
                        style: TextStyle(
                            color: backgroundColorLoginScreen,
                            fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        )
      ),
    );
  }
}
