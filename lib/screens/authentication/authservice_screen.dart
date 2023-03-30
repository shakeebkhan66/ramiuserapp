import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;

class AuthService {

  final auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
   String? email;
   String? name;
   String? imageUrl;
   String? phoneNo;


  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);

    final UserCredential authResult = await auth.signInWithCredential(credential);
    final User? user = authResult.user;

    assert(user!.email != null);
    assert(user!.displayName != null);
    assert(user!.photoURL != null);

    name = user!.displayName!;
    email = user.email!;
    imageUrl = user.photoURL!;

    print("name $name");
    print("email $email");
    print("imageUrl $imageUrl");
    print("user id ${user.uid}");
    print("PhoneNo ${user.phoneNumber ?? "No Number Found"}");

    final User? currentUser = auth.currentUser;
    assert(user.uid == currentUser!.uid);

    return 'signInWithGoogle succeeded : $user';
  }

  void signOutFunction() async {
    await googleSignIn.signOut();
  }


  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential
    = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

}





