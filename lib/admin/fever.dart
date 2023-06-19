import 'package:flutter/material.dart';
class Fever extends StatefulWidget {
  const Fever({Key? key}) : super(key: key);

  @override
  State<Fever> createState() => _FeverState();
}

class _FeverState extends State<Fever> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text('Fever'),
      ),
          body: Column(
            children: [
              Text('PRESCRIPTION',style: TextStyle(color: Colors.green,fontSize: 24,fontWeight: FontWeight.bold),),
             Text('*Maha herbals'),
              Text('*pyrin tablet'),
              Text('*feverodin'),
              Text('*sarvjwahar loha'),




            ],

    ),
    );
  }
}
