import 'package:final_project/config/colors.dart';
import 'package:final_project/cubit/loader_cubit.dart';
import 'package:final_project/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/google_sign_up_widget.dart';
import '../widgets/sign_in_fields.dart';
import '../widgets/sign_up_fields.dart';
import 'signup_screen.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoaderCubit>(create: (context) => LoaderCubit()),
      ],
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 60,),
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 70,bottom: 10),
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.whitecolor),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 30,bottom: 20),
                      child: SignInFields()),
                  Container(
                    margin: EdgeInsets.only(top: 40,bottom: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      Container(height: 1.5,width: 130,color: AppColors.textColor,),
                      Container(child: Text("or",style: TextStyle(color: AppColors.textColor),), ),
                      Container(height: 1.5,width: 130,color: AppColors.textColor,),
                    ],),
                  ),

                  SignUpWidget(labelText: "Sign In with Google"),

                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Do'nt have an Account?",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.textColor,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(), // Replace HomeScreen with your actual home screen widget
                              ),
                            );
                          },
                          child: Text(
                            "Sign Up",
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
      ),
    );
  }
}
