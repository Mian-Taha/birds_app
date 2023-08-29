import 'package:final_project/config/colors.dart';
import 'package:flutter/material.dart';

import '../widgets/google_sign_up_widget.dart';
import '../widgets/sign_up_fields.dart';
import 'signin_screen.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 70,),
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Sign Up",
                    style:
                        TextStyle(fontSize: 40.0,fontWeight: FontWeight.bold, color: AppColors.whitecolor),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "Create an Account",
                    style: TextStyle(
                        fontSize: 24.0,
                        color: AppColors.whitecolor),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 30,top: 30),
                    child: SignUpFields()),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an Account?",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: AppColors.whitecolor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Add your navigation logic here

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(), // Replace HomeScreen with your actual home screen widget
                              ),
                            );
                        },
                        child: Text(
                          "Log In",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
            // You can add more widgets here if needed
          ],
        ),
      ),
    );
  }
}
