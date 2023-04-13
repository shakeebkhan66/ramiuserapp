import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:userapp/screens/constants/logout_screen.dart';
import 'package:userapp/screens/profile/profile_screen.dart';
import 'package:userapp/screens/providers/googlesigninprovider.dart';
import 'package:userapp/screens/vehicles/myreservation_screen.dart';
import 'package:userapp/screens/vehicles/myvehicles.dart';
import 'package:userapp/screens/vehicles/selecttime_screen.dart';

import '../authentication/login_screen.dart';
import '../constants/colors.dart';
import '../sharedpreference/sharedpref_class.dart';

class MyDrawer extends StatefulWidget {
  static const routeName = '/myDrawerScreen';
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

  // TODO Text Widget For Changing AppBar
  Widget appBarText(){
    if(currentPage == DrawerSections.profile){
      return const Text(
        "My Profile",
        style: TextStyle(
            color: singInWithGoogleButtonColor,
            fontWeight: FontWeight.w600,
            fontSize: 20.0),
      );
    } else if (currentPage == DrawerSections.myVehicles){
      return const Text(
        "My Vehicles",
        style: TextStyle(
            color: singInWithGoogleButtonColor,
            fontWeight: FontWeight.w600,
            fontSize: 20.0),
      );
    } else if (currentPage == DrawerSections.myReservations){
      return const Text(
        "My Reservations",
        style: TextStyle(
            color: singInWithGoogleButtonColor,
            fontWeight: FontWeight.w600,
            fontSize: 20.0),
      );
    } else {
      return const Text(
        "Dashboard",
        style: TextStyle(
            color: singInWithGoogleButtonColor,
            fontWeight: FontWeight.w600,
            fontSize: 20.0),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final googleSignInProvider = Provider.of<GoogleSignInProvider>(context);
    var container;
    if (currentPage == DrawerSections.myVehicles) {
      container =  MyVehicles();
    } else if (currentPage == DrawerSections.myReservations) {
      container = const MyReservationScreen();
    } else if(currentPage == DrawerSections.profile){
      container = const ProfileScreen();
    } else if (currentPage == DrawerSections.logout) {
      container = const LogoutScreen();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColorLoginScreen,
        iconTheme: const IconThemeData(color: singInWithGoogleButtonColor),
        title: appBarText(),
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
                  decoration:
                      const BoxDecoration(color: singInWithFacebookButtonColor),
                  accountName: Consumer<GoogleSignInProvider>(
                    builder: (context, authProvider, child) => Text(
                      googleSignInProvider.name.toString(),
                      style: const TextStyle(
                          color: singInWithGoogleButtonColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  accountEmail: Text(
                    googleSignInProvider.email.toString(),
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
            menuItem(1, "My Vehicles", Icons.car_repair_rounded,
                currentPage == DrawerSections.myVehicles ? true : false),
            const Divider(thickness: 2),
            menuItem(2, "My Reservations", Icons.settings,
                currentPage == DrawerSections.myReservations ? true : false),
            const Divider(thickness: 2),
            menuItem(3, "Profile", Icons.person_2_outlined,
                currentPage == DrawerSections.profile ? true : false),
            const Divider(thickness: 2),
            menuItem(4, "Logout", Icons.home_repair_service_sharp,
                currentPage == DrawerSections.logout ? true : false),

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
            } else if (id == 3) {
              currentPage = DrawerSections.profile;
            } else if(id == 4) {
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
  profile,
  logout,
}
