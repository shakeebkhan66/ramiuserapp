
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:userapp/screens/authentication/login_screen.dart';

import '../vehicles/myvehicles.dart';

class GoogleSignInProvider with ChangeNotifier{

  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  // TODO For Login
  Future googleLogIn(context) async{

    try{

      if(!this.isLoading){
        this._isLoading = true;
        notifyListeners();
      }

      final googleUser = await googleSignIn.signIn();
      if(googleUser == null) return;
      _user = googleUser;


      if(_user != null){
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.topToBottom,
                duration: const Duration(milliseconds: 1000),
                alignment: Alignment.bottomCenter,
                child: const MyVehicles()));
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
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
    }
    notifyListeners();
  }

  // TODO For Logout
  Future logout(context) async{
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
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