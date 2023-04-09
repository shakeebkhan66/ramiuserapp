import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:userapp/screens/vehicles/drawer_screen.dart';

import '../authentication/login_screen.dart';
import '../sharedpreference/sharedpref_class.dart';

class ApiScreen {


  // TODO Add Customer
  addCustomer(String loginWith, methodUID, password, email, name, photoUrl,
      context) async {
    print("My loginWith $loginWith");
    print("My methodUID $methodUID");
    print("My password $password");
    print("My email $email");
    print("My name $name");
    print("photoUrl $photoUrl");

    Map<String, dynamic> addCustomerBody = {
      "loginWith": loginWith,
      "methodUID": methodUID,
      "password": password,
      "email": email,
      "name": name,
      "photoUrl": photoUrl,
    };

    try {
      final response = await http.post(
        Uri.parse('https://wosh-dev.herokuapp.com/api/customer/addCustomer'),

        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(addCustomerBody),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print("Data $data");
        print("Customer Added Successfully");
        print(data["id"]);
        print(data["result"]);
        MySharedPrefClass.preferences!.setString("id", data["id"]);
        Fluttertoast.showToast(
            msg: "Customer Added Successfully",
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 18);
      } else {
        print("Failed");
        Fluttertoast.showToast(
            msg: response.body,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 18);
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 18);
    }
  }


  // TODO Customer Login
  customerLogin(String username, password, context) async {
    print("My Username $username");
    print("My Password $password");

    try {
      print("Hello ${MySharedPrefClass.preferences!.getString("id")}");
      final response = await http.post(
        Uri.parse('https://wosh-dev.herokuapp.com/api/authorization/customer/login'),

        body: {
          "username": username,
          "password": password,
        }
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print("Data $data");
        print("Login Successfully");
        // print("Hello ${data["token"]["access"]}");
        // print("Username ${data["details"]["username"]}");
        MySharedPrefClass.preferences!.setBool("loggedIn", true);
        MySharedPrefClass.preferences
            ?.setString("Access_Token", data["token"]);
        // MySharedPrefClass.preferences!.setString("Username", data["details"]["username"]);
        Fluttertoast.showToast(
            msg: "Login Successfully",
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 18);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyDrawer()));
        // Navigator.pushNamed(context, BottomNavigationBarScreen.routeName);
      } else {
        print("Failed");
        Fluttertoast.showToast(
            msg: response.statusCode.toString(),
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 18);
        Navigator.pop(context);
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 18);
    }
  }
}