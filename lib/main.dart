import 'package:e_shoeapp/screens/landingpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      textTheme: Theme.of(context).textTheme,
      accentColor: Color(0xFFFF1F00)
    ),
      home: LandingPage(),
    );
  }
}

