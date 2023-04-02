import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userapp/screens/vehicles/myreservation_screen.dart';
import 'package:userapp/screens/vehicles/myvehicles.dart';
import 'package:userapp/screens/vehicles/selecttime_screen.dart';

import '../constants/colors.dart';


class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  var currentPage = DrawerSections.myVehicles;


  String name = "Rami";
  String email = "Rami@gmail.com";

  // Future getData() async{
  //   User? user = await FirebaseAuth.instance.currentUser;
  //   var variable = await FirebaseFirestore.instance.collection("Customers").doc(user?.uid).get();
  //
  //   setState(() {
  //     name = variable.data()!['username'];
  //     email = variable.data()!['email'];
  //   });
  // }


  // @override
  // void initState() {
  //   getData();
  //   super.initState();
  // }



  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.myVehicles) {
      container = const MyVehicles();
    } else if (currentPage == DrawerSections.myReservations) {
      container = const MyReservationScreen();
    } else if(currentPage == DrawerSections.logout){
      container = const VehicleWashTimeScreen();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColorLoginScreen,
          iconTheme: const IconThemeData(color: singInWithGoogleButtonColor),
        title: const Text(
          "Dashboard",
          style: TextStyle(
              color: singInWithGoogleButtonColor,
              fontWeight: FontWeight.w600,
              fontSize: 20.0),
        ),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  singInWithFacebookButtonColor,
                  singInWithFacebookButtonColor
                ])),
            child: Column(
              children: [

                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                      color: singInWithFacebookButtonColor
                  ),
                  accountName: Text(
                    name,
                    style: const TextStyle(
                        color: singInWithGoogleButtonColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  accountEmail: Text(
                    email,
                    style: const TextStyle(
                      color: singInWithGoogleButtonColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget MyDrawerList() {
    return Container(
      padding: const EdgeInsets.only(top: 40),
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              singInWithFacebookButtonColor,
              singInWithFacebookButtonColor
            ])),
        child: Column(
          // shows the list of menu drawer
          children: [
            menuItem(1, "My Vehicles", Icons.person,
                currentPage == DrawerSections.myVehicles ? true : false),
            const Divider(thickness: 2),
            menuItem(2, "My Reservations", Icons.settings,
                currentPage == DrawerSections.myReservations ? true : false),
            const Divider(thickness: 2),
            menuItem(3, "Logout", Icons.home_repair_service_sharp,
                currentPage == DrawerSections.logout ? true : false
            ),
            const Divider(thickness: 2),
          ],
        ),
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? backgroundColorLoginScreen1 : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.myVehicles;
            } else if (id == 2) {
              currentPage = DrawerSections.myReservations;
            } else if(id == 3){
              currentPage = DrawerSections.logout;
            }
            else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Wrong Choice")));
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: singInWithGoogleButtonColor,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(
                      color: singInWithGoogleButtonColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  myVehicles,
  myReservations,
  logout,
}
