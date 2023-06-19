import 'package:flutter/material.dart';
class view_certificate extends StatefulWidget {
  const view_certificate({Key? key}) : super(key: key);

  @override
  State<view_certificate> createState() => _view_certificateState();
}

class _view_certificateState extends State<view_certificate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:[
        Container(
          height: 300,
          width: 200,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('images/doctor.jpg'),/*fit: BoxFit.fill*/)
          ),
        ),
      ],
      ),

    );
  }
}
