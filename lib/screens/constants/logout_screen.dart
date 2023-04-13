import 'package:flutter/material.dart';

import '../authentication/login_screen.dart';
import '../sharedpreference/sharedpref_class.dart';
import '../vehicles/drawer_screen.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Text(
            "Do you want to logout?",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
          )),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              color: Colors.redAccent,
              onPressed: () {
                MySharedPrefClass.preferences?.setBool("loggedIn", false);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => const LoginScreen()));
              },
              child: const Text(
                "Yes",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            MaterialButton(
              color: Colors.green,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyDrawer()));
              },
              child: const Text(
                "No",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )
          ],
        )
      ],
    );
  }
}
