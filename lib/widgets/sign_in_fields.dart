import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/cubit/loader_cubit.dart';
import 'package:final_project/screens/home_screen.dart';
import 'package:final_project/utils/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SignInFields extends StatefulWidget {
  const SignInFields({Key? key}) : super(key: key);

  @override
  _SignInFieldsState createState() => _SignInFieldsState();
}

class _SignInFieldsState extends State<SignInFields> {
  bool _obscureText = true;
  bool _showPassword = false;

  String email = '';
  String password = '';
  String name = '';

  void _signInUser() async {
    try {
      // Start loading
      context.read<LoaderCubit>().startLoading();

      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Fetch user data from Firestore
      DocumentSnapshot userSnapshot = await firestore.collection('users').doc(email).get();

      if (userSnapshot.exists) {
        Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
        String storedPassword = userData['password'];
        name = userData['name'];

        if (password == storedPassword) {
          UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );

          if (userCredential.user != null) {
            print('User is signed in: ${userCredential.user!.uid}');
            // Stop loading and show success state
            context.read<LoaderCubit>().loadingSuccess();

            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('isLoggedIn', true);
            UserData.storeUserData(email, name, password);

            // Navigate to the home page or any other desired screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else {
            // Stop loading and show error state
            context.read<LoaderCubit>().loadingError();
            print('Sign-in failed');
          }
        } else {
          // Stop loading and show error state
          context.read<LoaderCubit>().loadingError();
          print('Password does not match');
        }
      } else {
        // Stop loading and show error state
        context.read<LoaderCubit>().loadingError();
        print('User not registered');
      }
    } catch (e) {
      // Stop loading and show error state
      context.read<LoaderCubit>().loadingError();
      debugPrint('Sign-in error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: _buildTextField(
              labelText: 'Email',
              hintText: '',
              icon: Icons.person,
              obscureText: false,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: _buildTextField(
              icon: Icons.lock,
              labelText: 'Password',
              hintText: '',
              obscureText: _obscureText,
              suffixIcon: _showPassword
                  ? Icons.visibility_off
                  : Icons.visibility,
              onSuffixIconPressed: _togglePasswordVisibility,
            ),
          ),
          TextButton(
            onPressed: () {
              // Add your navigation logic here
            },
            child: Text(
              "Forgot Password?",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.blue,
              ),
            ),
          ),
          // Inside the build method of _SignInFieldsState class
          Container(
            margin: EdgeInsets.only(top: 16),
            child: ElevatedButton(
              onPressed: _signInUser,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade700,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 135),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: BlocBuilder<LoaderCubit, LoaderState>(
                builder: (context, state) {
                  if (state == LoaderState.Loading) {
                    // Show loading indicator here
                    return CircularProgressIndicator(); // You can use your own loading widget
                  } else {
                    return Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    );
                  }
                },
              ),
            ),
          ),



        ],
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required String hintText,
    IconData? icon,
    required bool obscureText,
    IconData? suffixIcon,
    VoidCallback? onSuffixIconPressed,
  }) {
    return Container(
      height: 50,
      child: TextField(
        obscureText: obscureText && !_showPassword,
        onChanged: (value) {
          setState(() {
            if (labelText == 'Email') {
              email = value;
            } else if (labelText == 'Password') {
              password = value;
            }
          });
        },
        style: TextStyle(color: AppColors.whitecolor), // Set the text color
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: AppColors.textColor),
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.textColor),
          prefixIcon:
          Icon(icon, color: AppColors.textColor, size: 22),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade900,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          filled: true,
          fillColor: Colors.grey[800],
          contentPadding: EdgeInsets.only(top: 30,), // Adjust the padding as needed
          suffixIcon: suffixIcon != null
              ? IconButton(
            icon: Icon(
              suffixIcon,
              color: Colors.grey, // Change the color of the suffix icon
              size: 22,
            ),
            onPressed: onSuffixIconPressed,
          )
              : null,
        ),
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
}

