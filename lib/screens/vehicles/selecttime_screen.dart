import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:userapp/screens/api/api_screen.dart';
import '../constants/colors.dart';
import '../constants/spinkit.dart';
import '../constants/utils.dart';
import '../location/location.dart';
import '../models/addvehicle_model.dart';


class VehicleWashTimeScreen extends StatefulWidget {
  static const routeName = '/selectTimeScreen';

  double? latitude;
  double? longitude;

  VehicleWashTimeScreen({Key? key, this.latitude, this.longitude}) : super(key: key);

  @override
  State<VehicleWashTimeScreen> createState() => _VehicleWashTimeScreenState();
}

class _VehicleWashTimeScreenState extends State<VehicleWashTimeScreen> {

  ApiScreen apiScreen = ApiScreen();

  DateTime dateTime = DateTime.now();

  int index = 0;
  String? value;
  var currentDate;
  static List<String> values = [
    '12',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiScreen.vehicleList.clear();
  }

  @override
  Widget build(BuildContext context) {
    print("Latitude ${widget.latitude}");
    print("Longitude ${widget.longitude}");
    print("Value ${value.runtimeType}");
    print(currentDate.runtimeType);
    print(currentDate);
    // DateTime dateTime1 = DateTime.parse(currentDate);
    // DateTime startingTime = DateTime.parse(value.toString());
    // print(dateTime1);
    // print(startingTime);
    return Scaffold(
      backgroundColor: singInWithFacebookButtonColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 15.0,),
            Expanded(
                child: FutureBuilder(
                  future: apiScreen.getVehicles(context),
                  builder: ( context, AsyncSnapshot<List<MyVehicleModel>> snapshot){
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }else if(!snapshot.hasData){
                      return Center(
                        child: Loading(),
                      );
                    }return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: apiScreen.vehicleList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
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
                                            apiScreen.vehicleList[index].nickName,
                                            style: GoogleFonts.actor(
                                                fontWeight: FontWeight.w900,
                                                color: singInWithGoogleButtonColor),
                                          ),
                                          const SizedBox(
                                            height: 2.0,
                                          ),
                                          Text(
                                            "2018",
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
                              onTap: () {
                                selectTimeAndDate();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 100),
                                child: Container(
                                    height: 80,
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.center,
                                    margin:
                                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
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
                                        const SizedBox(
                                          height: 3.0,
                                        ),
                                        Text(
                                          "$currentDate, $value",
                                          style: GoogleFonts.actor(
                                              letterSpacing: 2.0,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                )
            ),

            // Expanded(
            //   child: ListView.builder(
            //     itemCount: 3,
            //     itemBuilder: (context, index) {
            //       return Column(
            //         children: [
            //           Container(
            //             height: 210,
            //             width: MediaQuery.of(context).size.width,
            //             // padding: const EdgeInsets.symmetric(horizontal: 15.0),
            //             margin: const EdgeInsets.symmetric(
            //                 vertical: 3.0, horizontal: 20.0),
            //             decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 borderRadius: BorderRadius.circular(10.0),
            //                 border: Border.all(color: Colors.grey.shade400),
            //                 boxShadow: [
            //                   BoxShadow(
            //                     color: Colors.grey.withOpacity(0.4),
            //                     offset: const Offset(0.1, 0.1),
            //                     blurRadius: 5,
            //                   )
            //                 ]),
            //             child: Column(
            //               children: [
            //                 const SizedBox(
            //                   height: 10,
            //                 ),
            //                 const Padding(
            //                   padding: EdgeInsets.only(left: 10.0),
            //                   child: Align(
            //                       alignment: Alignment.topLeft,
            //                       child: Icon(
            //                         Icons.favorite_border,
            //                         color: Colors.grey,
            //                       )),
            //                 ),
            //                 const SizedBox(
            //                   height: 2.0,
            //                 ),
            //                 Column(
            //                   children: [
            //                     Row(
            //                       children: [
            //                         const SizedBox(width: 198),
            //                         Column(
            //                           children: [
            //                             const Text(
            //                               "Bori Wash",
            //                               style: TextStyle(
            //                                   color:
            //                                   singInWithGoogleButtonColor,
            //                                   fontWeight: FontWeight.w600,
            //                                   fontSize: 20.0),
            //                             ),
            //                             const SizedBox(
            //                               height: 3.0,
            //                             ),
            //                             Row(
            //                               children: const [
            //                                 Text("(82)"),
            //                                 Icon(
            //                                   Icons.star,
            //                                   color: Colors.yellow,
            //                                 ),
            //                                 Icon(
            //                                   Icons.star,
            //                                   color: Colors.yellow,
            //                                 ),
            //                                 Icon(
            //                                   Icons.star,
            //                                   color: Colors.yellow,
            //                                 ),
            //                                 Icon(
            //                                   Icons.star,
            //                                   color: Colors.yellow,
            //                                 ),
            //                                 Icon(
            //                                   Icons.star,
            //                                   color: Colors.yellow,
            //                                 ),
            //                               ],
            //                             ),
            //                           ],
            //                         ),
            //                         Container(
            //                             height: 65,
            //                             width: 64,
            //                             alignment: Alignment.center,
            //                             margin: const EdgeInsets.symmetric(
            //                                 vertical: 3.0, horizontal: 15.0),
            //                             decoration: BoxDecoration(
            //                                 color: Colors.white,
            //                                 borderRadius:
            //                                 BorderRadius.circular(5.0),
            //                                 border: Border.all(
            //                                     color: Colors.grey.shade400),
            //                                 boxShadow: [
            //                                   BoxShadow(
            //                                     color: Colors.grey
            //                                         .withOpacity(0.4),
            //                                     offset: const Offset(0.1, 0.1),
            //                                     blurRadius: 5,
            //                                   )
            //                                 ]),
            //                             child: Image.asset(
            //                               "assets/images/car.png",
            //                               height: 50,
            //                             )),
            //                       ],
            //                     ),
            //                   ],
            //                 ),
            //                 Divider(
            //                   color: Colors.grey.withOpacity(0.2),
            //                   thickness: 2.0,
            //                 ),
            //                 const SizedBox(
            //                   height: 10.0,
            //                 ),
            //                 const Text(
            //                   "Whole Car Wash",
            //                   style: TextStyle(
            //                       color: singInWithGoogleButtonColor,
            //                       fontWeight: FontWeight.w600,
            //                       fontSize: 20.0),
            //                 ),
            //                 const SizedBox(
            //                   height: 4.0,
            //                 ),
            //                 const Text(
            //                   "70 ILS",
            //                   style: TextStyle(
            //                       color: backgroundColorLoginScreen,
            //                       fontWeight: FontWeight.w600,
            //                       fontSize: 20.0),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ],
            //       );
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  // TODO Select Time
  selectTimeAndDate() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 210,
              width: MediaQuery.of(context).size.width,
              child:  Image.asset(
                "assets/images/carwash.jpg",
                fit: BoxFit.cover,
              ),
            ),
            actions: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "SELECT ARRIVAL DATE & TIME",
                  style: GoogleFonts.acme(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      letterSpacing: 1.0,
                      color: singInWithGoogleButtonColor),
                ),
              ),
              const SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    color: backgroundColorLoginScreen,
                    height: 50,
                    minWidth: 100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    onPressed: () {
                      Utils.showSheet(
                        context,
                        child: buildDatePicker(),
                        onClicked: () {
                          setState(() {
                            currentDate = DateFormat('yyyy-MM-dd').format(dateTime);
                          });
                          Utils.showSnackBar(context, 'Selected "$currentDate"');
                          Navigator.pop(context);
                        },
                      );
                    },
                    child: const Text(
                      "Select Date",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  MaterialButton(
                    color: singInWithGoogleButtonColor,
                    height: 50,
                    minWidth: 100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    onPressed: () {
                      Utils.showSheet(
                        context,
                        child: buildCustomPicker(),
                        onClicked: () {
                          setState(() {
                            value = values[index];
                            apiScreen.vehicleList.clear();
                          });

                          Utils.showSnackBar(context, 'Selected "$value"');

                          Navigator.pop(context);
                        },
                      );
                    },
                    child: const Text(
                      "Select Time",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20.0,),
              Center(
                child: MaterialButton(
                  height: 50,
                  minWidth: 100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  color: Colors.green,
                  child: const Text("Selection Completed", style: TextStyle(color: singInWithFacebookButtonColor),),
                ),
              ),
              const SizedBox(height: 20.0,),
            ],
          );
        });
  }


  // TODO For Selecting Date
  Widget buildDatePicker() => SizedBox(
    height: 300,
    child: CupertinoDatePicker(
      minimumYear: 2015,
      maximumYear: DateTime.now().year,
      initialDateTime: dateTime,
      mode: CupertinoDatePickerMode.date,
      onDateTimeChanged: (dateTime) {
        setState(() => this.dateTime = dateTime);
        apiScreen.vehicleList.clear();
      }
    ),
  );

  // TODO Selecting Time
  Widget buildCustomPicker() => SizedBox(
    height: 300,
    child: CupertinoPicker(
      itemExtent: 64,
      diameterRatio: 0.7,
      looping: true,
      onSelectedItemChanged: (index) => setState(() => this.index = index),
      // selectionOverlay: Container(),
      children: Utils.modelBuilder<String>(
        values,
            (index, value) {
          final isSelected = this.index == index;
          final color = isSelected ? Colors.pink : Colors.black;

          return Center(
            child: Text(
              value,
              style: TextStyle(color: color, fontSize: 24),
            ),
          );
        },
      ),
    ),
  );
}

