import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:userapp/screens/providers/googlesigninprovider.dart';

import '../api/api_screen.dart';
import '../constants/colors.dart';
import '../constants/customtextfield_screen.dart';
import '../constants/spinkit.dart';

class CustomerLoginScreen extends StatefulWidget {
  static const routeName = '/customerLoginScreen';

  const CustomerLoginScreen({Key? key}) : super(key: key);

  @override
  State<CustomerLoginScreen> createState() => _CustomerLoginScreenState();
}

class _CustomerLoginScreenState extends State<CustomerLoginScreen> {
  // TODO TextEditingControllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ApiScreen apiScreen = ApiScreen();

  // TODO Form Key
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isPassword = true;

  // TODO Email Validator Regex
  RegExp regExpEmail = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\'
      r'[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)'
      r'+[a-zA-Z]{2,}))$');

  // TODO Password Validation Regex
  RegExp regexPassword =
  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');


  @override
  Widget build(BuildContext context) {
    GoogleSignInProvider googleSignInProvider = Provider.of<GoogleSignInProvider>(context);
    emailController.text = googleSignInProvider.email.toString();
    passwordController.text = googleSignInProvider.methodUID.toString();
    return isLoading
        ? Loading()
        : Scaffold(
      backgroundColor: backgroundColorLoginScreen1,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Customer Login",
                    style: GoogleFonts.actor(
                        fontSize: 34.0,
                        letterSpacing: -1.0,
                        color: singInWithGoogleButtonColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 50.0),
                CustomTextFieldScreen(
                  myController: emailController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Field is required";
                    } else if (!regExpEmail.hasMatch(value)) {
                      return "Please enter valid email";
                    } else {
                      return null;
                    }
                  },
                  text: "Enter your email",
                  labelText: "Email",
                ),
                const SizedBox(
                  height: 7.0,
                ),
                CustomTextFieldPassword(
                    myController: passwordController,
                    isObscure: isPassword,
                    icon: IconButton(
                      onPressed: (){
                        setState(() {
                          isPassword = !isPassword;
                        });
                      },
                      icon: Icon(
                        isPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: isPassword ? backgroundColorLoginScreen : Colors.blueGrey,
                      ),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      } else {
                        return null;
                      }
                    },
                    text: "Enter your password",
                  labelText: "Password",
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
                      apiScreen.customerLogin(emailController.text.toString(),
                          passwordController.text.toString(), context);
                      print("Validate");
                    } else {
                      print("Not Validate");
                    }
                  },
                  child: Text(
                    "Log in",
                    style: GoogleFonts.oswald(
                        color: singInWithFacebookButtonColor, fontSize: 20.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        width: 140.0,
                        child: Divider(
                          color: singInWithGoogleButtonColor,
                          thickness: 1.0,
                        ),
                      ),
                      Text("OR",
                          style: GoogleFonts.roboto(
                              color: Colors.black87,
                              fontSize: 17.0,
                              fontWeight: FontWeight.w700)),
                      const SizedBox(
                        width: 140.0,
                        child: Divider(
                          color: singInWithGoogleButtonColor,
                          thickness: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25.0),
                Text(
                  "Forgot password?",
                  style: GoogleFonts.openSans(
                      color: singInWithGoogleButtonColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ),
              ],
            ),
          )),
    );
  }
}
