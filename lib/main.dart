import 'package:earning_tracker/Screens/SplashScreen.dart';
import 'package:flutter/material.dart';

import 'Screens/HomePage.dart';

void main() {
  runApp(EarningsApp());
}

class EarningsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Earnings Graph',
      home:EarningsHomePage(),
    );
  }
}




