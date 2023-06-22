import 'dart:async';

import 'package:flutter/material.dart';


import 'public_user/homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  void initState() {
    // TODO: implement initState
    Timer(const Duration(seconds: 3),()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const homepage(),)));
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
      body: Center(


    // body: Container(
        // width: double.infinity,
        //  height: double.infinity,
          child: CircleAvatar(
           radius: 60,
            backgroundImage: AssetImage('images/splashimage.jpg'),
          )),
    );
  }
}
