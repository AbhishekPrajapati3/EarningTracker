import 'dart:async';

import 'package:earning_tracker/Screens/HomePage.dart';
import 'package:flutter/material.dart';



class Splashscreen extends StatefulWidget {
  
  const Splashscreen({super.key});
  

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 5),(){Navigator.pushReplacement(context, MaterialPageRoute(builder: (Context)=>EarningsHomePage())); });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full-screen background image
          Positioned.fill(
            child: Image.asset(
              "assets/SplashScreen.png", // Update with your image path
              fit: BoxFit.cover, // Ensures the image covers the screen
            ),
          ),
          // Optional: Overlay color if needed
          Positioned.fill(
            child: Container(
              color: Colors.cyan.withOpacity(0.5), // Adjust opacity as desired
            ),
          ),
        ],
      ),
    );
  }
}

