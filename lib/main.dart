import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userapp/screens/authentication/login_customer_screen.dart';
import 'package:userapp/screens/authentication/login_screen.dart';
import 'package:userapp/screens/providers/facebooksigninprovider.dart';
import 'package:userapp/screens/providers/googlesigninprovider.dart';
import 'package:userapp/screens/sharedpreference/sharedpref_class.dart';
import 'package:userapp/screens/vehicles/drawer_screen.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MySharedPrefClass.preferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GoogleSignInProvider>(create: (context) => GoogleSignInProvider()),
        ChangeNotifierProvider<FacebookSignInProvider>(create: (context) => FacebookSignInProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MySharedPrefClass.preferences?.getBool("loggedIn") == true
            ?  MyDrawer()
            : const LoginScreen(),
        builder: (context, child) => ResponsiveWrapper.builder(
            child,
            maxWidth: 1200,
            minWidth: 480,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(480, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
            ],
            background: Container(color: const Color(0xFFF5F5F5))),
        initialRoute: "/",
        routes: {
          LoginScreen.routeName: (context) => const LoginScreen(),
          CustomerLoginScreen.routeName: (context) => const CustomerLoginScreen()
          // AllRecipesScreen.routeName: (context) => const AllRecipesScreen(),
        },
      ),
    );
  }
}

