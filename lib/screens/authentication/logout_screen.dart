import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:userapp/screens/authentication/login_screen.dart';
import 'package:userapp/screens/constants/colors.dart';
import 'package:userapp/screens/constants/spinkit.dart';

import 'authservice_screen.dart';


class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Out Page'),
      ),
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: Loading(),);
          }else if(snapshot.hasData){
            return LoggedInWidget();
          }else if(snapshot.hasError){
            return Center(child: Text("Something went wrong"),);
          }else {
            return const LoginScreen();
          }
        },
      )
    );
  }
}


// TODO LoggedIn

class LoggedInWidget extends StatelessWidget {
  const LoggedInWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("ID ${user!.uid}"),
          Text("username ${user.displayName}"),
          Text("email ${user.email}"),
          MaterialButton(
              onPressed: (){},
            color: backgroundColorLoginScreen,
            child: const Text("Logout", style: TextStyle(color: singInWithGoogleButtonColor),),
          )
        ],
      ),
    );
  }
}
