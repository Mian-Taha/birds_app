import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/screens/home_screen.dart';
import 'package:final_project/utils/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../config/colors.dart';

class SignUpFields extends StatefulWidget {
  const SignUpFields({Key? key}) : super(key: key);

  @override
  _SignUpFieldsState createState() => _SignUpFieldsState();
}

class _SignUpFieldsState extends State<SignUpFields> {
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';

  bool _obscureText = true;
  late FocusNode _passwordFocusNode;
  bool _isPasswordFocused = false;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    _passwordFocusNode.addListener(_onPasswordFocusChange);
  }

  @override
  void dispose() {
    _passwordFocusNode.removeListener(_onPasswordFocusChange);
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _onPasswordFocusChange() {
    setState(() {
      _isPasswordFocused = _passwordFocusNode.hasFocus;
    });
  }

  void _storeUserDataInFirebase() async {
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      print('Please fill in all fields.');
      return;
    }

    if (password != confirmPassword) {
      print('Passwords do not match.');
      return;
    }

    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String customDocumentId = email;
      DocumentReference documentReference = firestore.collection('users').doc(customDocumentId);

      // Register user with FirebaseAuth
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {

        UserData.storeUserData(email, name,password);
        // User registration successful, store additional data in Firestore
        await documentReference.set({
          'name': name,
          'email': email,
          'password':password,
          // ... other fields ...
        });
        // Navigate to the home screen after successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()), // Replace HomeScreen with your actual home screen widget
        );

        print('User registered and data stored in Firestore');
      } else {
        print('User registration failed');
      }
    } catch (e) {
      print('Error storing user data or registering user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: _buildTextField(
              labelText: 'Name',
              hintText: '',
              icon: Icons.person,
              obscureText: false,
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: _buildTextField(
              labelText: 'Email',
              hintText: '',
              icon: Icons.email,
              obscureText: false,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: _buildTextField(
              icon: Icons.lock,
              labelText: 'Password',
              hintText: '',
              obscureText: _obscureText,
              suffixIcon:
              _showPassword ? Icons.visibility_off : Icons.visibility,
              onSuffixIconPressed: _togglePasswordVisibility,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: _buildTextField(
              icon: Icons.lock,
              labelText: 'Confirm Password',
              hintText: '',
              obscureText: _obscureText,
              suffixIcon:
              _showPassword ? Icons.visibility_off : Icons.visibility,
              onSuffixIconPressed: _togglePasswordVisibility,
            ),
          ),


          Container(
            margin: EdgeInsets.only(top: 40),
            child: ElevatedButton(
              onPressed: _storeUserDataInFirebase,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade700,
                padding:
                EdgeInsets.symmetric(vertical: 15, horizontal: 125),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Register',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
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
    bool autofocus = false,
  }) {
    return Container(
      height: 50,
      child: TextField(
        obscureText: obscureText && !_showPassword,
        focusNode: autofocus ? _passwordFocusNode : null,
        onChanged: (value) {
          setState(() {
            if (labelText == 'Name') {
              name = value;
            } else if (labelText == 'Email') {
              email = value;
            } else if (labelText == 'Password') {
              password = value;
            } else if (labelText == 'Confirm Password') {
              confirmPassword = value;
            }
          });
        },
        style: TextStyle(color: AppColors.whitecolor), // Set the text color
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: AppColors.textColor),
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.textColor),
          prefixIcon: Icon(icon, color: AppColors.textColor, size: 22),
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
          contentPadding: EdgeInsets.only(left: 8, right: 8, top: 24),
          suffixIcon: suffixIcon != null
              ? IconButton(
            icon: Icon(
              suffixIcon,
              color: _isPasswordFocused ? Colors.grey : Colors.grey,
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
