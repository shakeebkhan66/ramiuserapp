import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColorLoginScreen,
        automaticallyImplyLeading: false,
        title: const Text(
          "Payment",
          style: TextStyle(
              color: singInWithGoogleButtonColor,
              fontWeight: FontWeight.w600,
              fontSize: 20.0),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: 90),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Colors.grey.shade400),
                  gradient: const LinearGradient(colors: [
                    backgroundColorLoginScreen,
                    backgroundColorLoginScreen1,
                  ]),
                ),
                child: Text(
                  "Confirm and Continue",
                  style: GoogleFonts.actor(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
