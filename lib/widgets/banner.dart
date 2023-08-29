import 'package:flutter/material.dart';

class AnimatedBanner extends StatefulWidget {
  @override
  _AnimatedBannerState createState() => _AnimatedBannerState();
}

class _AnimatedBannerState extends State<AnimatedBanner> {
  bool isAnimating = false;

  void toggleAnimation() {
    setState(() {
      isAnimating = !isAnimating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Banner'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: toggleAnimation,
          child: AnimatedContainer(
            duration: Duration(seconds: 2), // Set the animation duration
            curve: Curves.linear, // Set the animation curve
            width: 300, // Set the desired width for your banner
            height: 200, // Set the desired height for your banner
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background_image.jpg'), // Replace with your background image asset
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Text(
                'Your Text Here', // Replace with your desired text
                style: TextStyle(
                  fontSize: 24, // Set your desired font size
                  color: Colors.white, // Set your desired text color
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
