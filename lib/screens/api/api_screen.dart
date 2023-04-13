import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:userapp/screens/models/addvehicle_model.dart';
import 'package:userapp/screens/vehicles/addnewvehicle_screen.dart';
import 'package:userapp/screens/vehicles/drawer_screen.dart';
import 'package:userapp/screens/vehicles/myvehicles.dart';
import 'dart:io';
import '../authentication/login_screen.dart';
import '../sharedpreference/sharedpref_class.dart';

class ApiScreen {

  // TODO Creating a List of OrdersModel
  List<MyVehicleModel> vehicleList = [];
  var data;
  bool isLoggedIn = false;

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
          Uri.parse(
              'https://wosh-dev.herokuapp.com/api/authorization/customer/login'),
          body: {
            "username": username,
            "password": password,
          });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print("Data $data");
        print("Login Successfully");
        MySharedPrefClass.preferences!.setBool("loggedIn", true);
        MySharedPrefClass.preferences?.setString("Access_Token", data["token"]);
        Fluttertoast.showToast(
            msg: "Login Successfully",
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 18);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyDrawer()));
        // Navigator.pushNamed(context, BottomNavigationBarScreen.routeName);
      } else if(response.statusCode == 401){
        Fluttertoast.showToast(
            msg: "User with this email is already exist",
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 18);
      }
      else {
        print("Failed");
        Fluttertoast.showToast(
            msg: response.statusCode.toString(),
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 18);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 18);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }

  // TODO addCustomerExtraDetails
  customerExtraDetails(String name, phoneNumber, context) async{

    print("My name $name");
    print("My phoneNumber $phoneNumber");
    print("Id is ${MySharedPrefClass.preferences!.getString("id")}");

    Map<String, dynamic> addExtraDetails = {
      "id": MySharedPrefClass.preferences!.getString("id"),
      "nickName": name,
      "preferredPhoneNumber": phoneNumber,
    };

    try {
      final response = await http.post(
        Uri.parse('https://wosh-dev.herokuapp.com/api/customer/addCustomerExtraDetails'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(addExtraDetails),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print("Data $data");
        print("Extra Details Added");
        Fluttertoast.showToast(
            msg: "Extra Details Added",
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 18);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyDrawer()));
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

  // TODO addVehicle
  addVehicle(String nickName, year, typeOfVehicle, plateNumber, image, context) async{

    print("My name $nickName");
    print("My year $year");
    print("My typeOfVehicle $typeOfVehicle");
    print("My plateNumber $plateNumber");
    print("My image $image");

    print("Id is ${MySharedPrefClass.preferences!.getString("id")}");


    Map<String, dynamic> addVehicle = {
      "nickName": nickName,
      "year":  year,
      "type": typeOfVehicle,
      "plateNumber": plateNumber,
      "image": image,
      "customer" : {
        "id": MySharedPrefClass.preferences!.getString("id")
      }
    };

    try {
      final response = await http.post(
        Uri.parse('https://wosh-dev.herokuapp.com/api/customer/addVehicle'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(addVehicle),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print("Data $data");
        print("Added");
        MySharedPrefClass.preferences?.setString("vehicleID", data["id"]);
        Fluttertoast.showToast(
            msg: "Added Vehicle",
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 18);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyDrawer()));
      } else {
        print("Failed");
        Fluttertoast.showToast(
            msg: response.body,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 18);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const AddNewVehicle()));
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 18);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const AddNewVehicle()));
    }
  }


  // TODO Get Vehicles
  Future<List<MyVehicleModel>> getVehicles(context) async {
    var id = MySharedPrefClass.preferences!.getString("id");
    var token = MySharedPrefClass.preferences?.getString("Access_Token");

    print("Id isss $id");
    print("Token is $token");

    Map<String, dynamic> getVehicle = {
      "id": id,
    };


    final response = await http
        .post(Uri.parse('https://wosh-dev.herokuapp.com/api/customer/myVehicles'),
        body: jsonEncode(getVehicle),
        headers: <String, String>{'Content-Type': 'application/json'},
    );

    print("Hello ${response.body}");


    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());

        print("response ${response.statusCode}");
        print(data);


        for (var item in data) {
          vehicleList.add(MyVehicleModel.fromJson(item));
        }
        return vehicleList;
       }
      else {
        Fluttertoast.showToast(msg: "Failed to get vehicle data");
        return vehicleList;
      }
    }catch(e){
      print(e.toString());
      Fluttertoast.showToast(msg: "Failed ${e.toString()}");
      Navigator.pushNamed(context, MyVehicles.routeName);
    }
    return vehicleList;
  }

}
