import 'dart:async';
import 'package:core_native_app/Screen/Login_Screen.dart';
import 'package:core_native_app/main.dart';
import 'package:flutter/material.dart';

class SpeshScreen extends StatefulWidget {
  const SpeshScreen({super.key});

  @override
  State<SpeshScreen> createState() => _SpeshScreenState();
}

class _SpeshScreenState extends State<SpeshScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 3), ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/SpleshScreen.jpg'),
      ),
    );
  }
}
