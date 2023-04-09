import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:userapp/screens/api/api_screen.dart';
import 'package:userapp/screens/authentication/login_screen.dart';
import 'package:userapp/screens/vehicles/drawer_screen.dart';

import '../authentication/login_customer_screen.dart';
import '../sharedpreference/sharedpref_class.dart';
import '../vehicles/myvehicles.dart';

class GoogleSignInProvider with ChangeNotifier{

  ApiScreen apiScreen = ApiScreen();

  String? loginWith = "Google";
  String? methodUID;
  String? password;
  String? email;
  String? name;
  String? photoUrl;


  final googleSignIn = GoogleSignIn(scopes: ['email', 'profile', 'openid', 'https://www.googleapis.com/auth/user.phonenumbers.read']);
  final auth = FirebaseAuth.instance;

  User? user1 =  FirebaseAuth.instance.currentUser;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;


  // TODO For Login
  Future googleLogIn(context) async{

    try{
      isLoading = true;
      final googleUser = await googleSignIn.signIn();
      if(googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
      );

      final UserCredential authResult = await auth.signInWithCredential(credential);
      final User? user = authResult.user;


      print("name ${user?.displayName}");
      print("email ${user?.email}");
      print("methodUID ${user?.uid}");
      print("photo ${user?.photoURL}");
      print("Phone Number ${user?.providerData}");

      password = user?.uid;
      email = user?.email;
      name = user?.displayName;
      photoUrl = "";
      methodUID = user?.uid;

      // for(var i in user!.providerData){
      //   print(i.providerId);
      // }

      if(_user != null){
        apiScreen.addCustomer(
            loginWith.toString(),
            methodUID, password,
            email,
            name, photoUrl, context);

        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.topToBottom,
                duration: const Duration(milliseconds: 1000),
                alignment: Alignment.bottomCenter,
                child: const CustomerLoginScreen()));
      }return;


    }catch(e){
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
              dismissDirection: DismissDirection.startToEnd,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 200,
                right: 20,
                left: 20
              ),
              content: Text(e.toString(),
            style: const TextStyle(color: Colors.white,
                fontSize: 17, fontWeight: FontWeight.w600),)));
    } finally{
      isLoading = false;
    }
    notifyListeners();
  }

  // TODO For Logout
  Future logout(context) async{
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    MySharedPrefClass.preferences!.setBool("loggedIn", false);
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.topToBottom,
            duration: const Duration(milliseconds: 1000),
            alignment: Alignment.bottomCenter,
            child: const LoginScreen()));
    notifyListeners();
  }

}