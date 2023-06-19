import 'package:flutter/material.dart';
import 'package:herbit/public_user/analysis.dart';
import 'package:herbit/user/chat.dart';
import 'package:herbit/user/profile_user.dart';
import 'package:herbit/public_user/prediction.dart';
import 'package:herbit/public_user/user.dart';
import '../Login.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children: [

          Expanded(
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: Color(0xffd9cac7),
                    height: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'WELCOME TO HERBIT',
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Image(
                        image: AssetImage(
                            'images/Aloe-Vera-Variegated-planted-pots-home-garden-horticult.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => analysis(),
                        ));
                  },
                  child: Container(
                    height: 60,
                    color: Colors.white,
                    child: Icon(Icons.analytics, size: 30, color: Colors.green),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Prediction(),
                      ));

                  },
                  child: Container(
                    height: 60,
                    color: Colors.white,
                    child:
                    Icon(Icons.camera_alt, size: 30, color: Colors.green),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => user(),
                        ));
                  },
                  child: Container(
                    height: 60,
                    color: Colors.white,
                    child: Icon(Icons.chat, size: 30, color: Colors.green),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ));
                  },
                  child: Container(
                    height: 60,
                    color: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ],
          )

        ],
      ),
    );
  }
}