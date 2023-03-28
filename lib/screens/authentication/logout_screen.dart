import 'package:flutter/material.dart';

import 'googleandfacebookfunction_screen.dart';


class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Out Page'),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            // here signOutFunction() method will be called
            signOutFunction();
            Navigator.pop(context);
          },
          child: const Text('Sign out'),
        ),
      ),
    );
  }
}