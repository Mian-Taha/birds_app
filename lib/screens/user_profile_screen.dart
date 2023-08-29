import 'package:final_project/config/colors.dart';
import 'package:final_project/screens/signin_screen.dart';
import 'package:final_project/utils/app_utils.dart';
import 'package:final_project/utils/user_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late String email = '';
  late String name = '';
  late String password = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    Map<String, String> fetchedData = await UserData.getUserData();
    setState(() {
      email = fetchedData['email']!;
      name = fetchedData['name']!;
      password = fetchedData['password']!;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[900],
        title: Container(margin: EdgeInsets.only(top: 30,right: AppUtils.calculateDynamicWidth(context, 0.17)), child: Center(child: Text("PROFILE"))),
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.grey[800],
                child: Container(

                  margin: EdgeInsets.only(top:AppUtils.calculateDynamicMargin(context, 0.4)),
                  child: Column(
                    children: [
                      _buildMenuItem(context,Icons.person_2_outlined, 'Profile Name', name),
                      _buildMenuItem(context,Icons.email_outlined, 'Email Address',email),
                      _buildMenuItem(context,Icons.lock_outline, 'Your Password', password),
                      _buildLogoutButton(context),
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                color: Colors.grey[900],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.05,
                left: MediaQuery.of(context).size.height * 0.04,
                right: MediaQuery.of(context).size.height * 0.04,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey[800],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  height: MediaQuery.of(context).size.height * 0.24,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[900],
                        child: Text(
                          (name.isNotEmpty ? name[0] : 'P'),
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            name.isNotEmpty ? name : 'person',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color :AppColors.textColor),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildMenuItem(BuildContext context, IconData icon, String heading, String subheading) {
  return ListTile(
    leading: Icon(icon, color: Colors.white),
    title: Text(heading, style: TextStyle(fontSize: 16, color: Colors.white)),
    subtitle: Text(subheading, style: TextStyle(fontSize: 12, color: Colors.white70)),
  );
}


Widget _buildLogoutButton(BuildContext context) {
  return ListTile(
    leading: Icon(Icons.logout, color: Colors.white),
    title: Text('Logout', style: TextStyle(fontSize: 16, color: Colors.white)),
    onTap: () async {
      // Clear user data from shared preferences
      await UserData.clearUserData();

      // Clear session data from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);

      // Implement any other logout-related logic here

      // Navigate to the login screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()), // Replace with your login screen
            (Route<dynamic> route) => false,
      );
    },
  );
}



