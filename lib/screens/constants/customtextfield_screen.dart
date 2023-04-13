import 'package:flutter/material.dart';
import 'colors.dart';

class CustomTextFieldScreen extends StatelessWidget {
  String? text;
  String? labelText;
  TextEditingController myController;
  String? Function(String?)? validator;
  CustomTextFieldScreen(
      {Key? key,
        required this.text,
        required this.labelText,
        required this.myController,
        required this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        controller: myController,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          filled: true,
            fillColor: singInWithFacebookButtonColor,
            hintText: text,
            hintStyle: const TextStyle(color: backgroundColorLoginScreen),
            labelText: labelText,
            labelStyle: const TextStyle(color: singInWithGoogleButtonColor),
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black54),
                borderRadius: BorderRadius.circular(10.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: backgroundColorLoginScreen),
                borderRadius: BorderRadius.circular(10.0))),
      ),
    );
  }
}

class CustomTextFieldPassword extends StatelessWidget {
  String? text;
  String? labelText;
  final TextEditingController myController;
  final String? Function(String?)? validator;
  Widget? icon;
  bool isObscure;
  CustomTextFieldPassword(
      {Key? key,
        required this.isObscure,
        this.icon,
        required this.text,
        required this.labelText,
        required this.myController,
        required this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        controller: myController,
        validator: validator,
        obscureText: isObscure,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            filled: true,
            fillColor: singInWithFacebookButtonColor,
            suffixIcon: icon,
            hintText: text,
            hintStyle: const TextStyle(color: backgroundColorLoginScreen),
            labelText: labelText,
            labelStyle: const TextStyle(color: singInWithGoogleButtonColor),
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black54),
                borderRadius: BorderRadius.circular(10.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: backgroundColorLoginScreen),
                borderRadius: BorderRadius.circular(10.0))),
      ),
    );
  }
}

