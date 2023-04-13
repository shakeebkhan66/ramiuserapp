
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import 'package:userapp/screens/vehicles/myvehicles.dart';

class FacebookSignInProvider with ChangeNotifier{

  void signInWithFacebook(context) async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(permissions: (['email', 'public_profile']));
      final token = result.accessToken!.token;
      print('Facebook token userID : ${result.accessToken!.grantedPermissions}');
      final graphResponse = await http.get(Uri.parse( 'https://graph.facebook.com/'
          'v2.12/me?fields=name,first_name,last_name,email&access_token=${token}'));

      final profile = jsonDecode(graphResponse.body);
      print("Profile is equal to $profile");
      try {
        final AuthCredential facebookCredential = FacebookAuthProvider.credential(result.accessToken!.token);
        final userCredential = await FirebaseAuth.instance.signInWithCredential(facebookCredential);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  MyVehicles()),
        );
      }catch(e)
      {
        final snackBar = SnackBar(
          margin: const EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content:  Text(e.toString()),
          backgroundColor: (Colors.redAccent),
          action: SnackBarAction(
            label: 'dismiss',
            onPressed: () {
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

    } catch (e) {
      print("error occurred");
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

}
