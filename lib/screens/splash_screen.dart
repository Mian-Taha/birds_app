import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';
import 'signin_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  bool _hasTapped = false; // Add a flag to track if the splash screen has been tapped

  @override
  void initState() {
    super.initState();
    _checkLoggedInStatus();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _animationController.forward();
  }
  void _checkLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(), // Redirect to home screen if already logged in
        ),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleGetStarted() {
    if (!_hasTapped) {
      _hasTapped = true;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SignInScreen(), // Redirect to login screen if not logged in
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'images/splash_screen_image2.jpg', // Replace with your actual image path
            height: screenSize.height,
            width: screenSize.width,
            fit: BoxFit.fill,
          ),
          Positioned(
            bottom: 0,
            child: SlideTransition(
              position: _slideAnimation,
              child: Container(
                height: screenSize.height / 1.2,
                width: screenSize.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.95), // Adjust the opacity as needed
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 8),
                  child: _buildDelayedItems(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDelayedItems() {
    return StaggeredAnimation(
      duration: Duration(milliseconds: 300),
      children: [
        Image.asset(
          'images/bird-cage.png', // Replace with the actual path to your "bird_cage.png" file
          width: 64, // Set the desired width of the image
          height: 64, // Set the desired height of the image
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            'Buy The Best Supplies From Us',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 60),
          child: Text(
            'Deliver your products in just one hour',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(height: 40),
        CustomButton(
          onPressed: _handleGetStarted,
        ),
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;

  CustomButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 80),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17),
        ),
      ),
      child: Text(
        'Get Started',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    );
  }
}

class StaggeredAnimation extends StatefulWidget {
  final Duration duration;
  final List<Widget> children;

  const StaggeredAnimation({Key? key, required this.duration, required this.children}) : super(key: key);

  @override
  _StaggeredAnimationState createState() => _StaggeredAnimationState();
}

class _StaggeredAnimationState extends State<StaggeredAnimation> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = widget.children.map((child) {
      return AnimationController(
        vsync: this,
        duration: widget.duration,
      );
    }).toList();

    // Start the animations one by one with a delay
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(widget.duration * i, () {
        _controllers[i].forward();
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: widget.children.asMap().entries.map((entry) {
        final index = entry.key;
        final child = entry.value;
        return ScaleTransition(
          scale: _controllers[index].drive(Tween<double>(begin: 0.0, end: 1.0)),
          child: FadeTransition(
            opacity: _controllers[index],
            child: child,
          ),
        );
      }).toList(),
    );
  }
}