import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'buttons_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/home_screen.dart';

class SignUpWidget extends StatelessWidget {
  final String labelText;

  const SignUpWidget({Key? key, required this.labelText}) : super(key: key);


  signInWithGoogle() async {
    print("googlelogin method called");
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      var result = await _googleSignIn.signIn();
      if (result == null) {
        return;
      }
      print(result.displayName);
      print(result.email);
      final userData = await result.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: userData.accessToken,
        idToken: userData.idToken,
      );
      var finalResult =
      await FirebaseAuth.instance.signInWithCredential(credential);
      print("Result $finalResult");

      // Store name and email in Firestore database
      if (finalResult.user != null) {
        var user = finalResult.user!;
        var trackingCollection =
        FirebaseFirestore.instance.collection('Tracking-Record');
        var businessDoc = trackingCollection.doc('Business-1');
        var userDoc = businessDoc.collection(user.email!);
      }
    } catch (error) {
      print(error);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Center(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding:
            EdgeInsets.symmetric(vertical: 15, horizontal: 80),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () async {
            await signInWithGoogle();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
          icon: const FaIcon(FontAwesomeIcons.google, color: Colors.red),
          label: Text(labelText,style: TextStyle(color: Colors.black)),
        ),
      ),
    );
  }
}
