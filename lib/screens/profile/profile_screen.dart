import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/screens/api/api_screen.dart';

import '../constants/colors.dart';
import '../constants/customtextfield_screen.dart';


class ProfileScreen extends StatefulWidget {
  static const routeName = '/profileScreen';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  // TODO Form Key
  final _formKey = GlobalKey<FormState>();

  // TODO TextEditingControllers
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  // TODO Instance of ApiScreen
  ApiScreen apiScreen = ApiScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: singInWithFacebookButtonColor,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFieldScreen(
                myController: nameController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Field is required";
                  } else {
                    return null;
                  }
                },
                text: "Enter your nickname",
                labelText: "Nickname",
              ),
              const SizedBox(
                height: 15.0,
              ),
              CustomTextFieldScreen(
                myController: numberController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Field is required";
                  } else {
                    return null;
                  }
                },
                text: "Enter your phone number",
                labelText: "Phone Number",
              ),
              const SizedBox(height: 30.0,),
              MaterialButton(
                splashColor: backgroundColorLoginScreen1,
                hoverColor: backgroundColorLoginScreen,
                minWidth: 180.0,
                height: 40.0,
                color: singInWithGoogleButtonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    apiScreen.customerExtraDetails(nameController.text.toString(),
                        numberController.text.toString(), context);
                    print("Validate");
                  } else {
                    print("Not Validate");
                  }
                },
                child: Text(
                  "Submit",
                  style: GoogleFonts.oswald(
                      color: singInWithFacebookButtonColor, fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
