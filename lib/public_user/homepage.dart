import 'package:flutter/material.dart';
import 'package:herbit/login.dart';
import 'package:herbit/public_user/analysis.dart';
import 'package:herbit/public_user/prediction.dart';
import 'package:herbit/public_user/user.dart';


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
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: const Color(0xffd9cac7),
                    height: 120,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:[
                        Text(
                          'WELCOME TO HERBIT',
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                 const Expanded(
                    child:  Image(
                      image: AssetImage(
                          'images/Aloe-Vera-Variegated-planted-pots-home-garden-horticult.jpeg'),
                      fit: BoxFit.cover,
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
                          builder: (context) => const Analysis(),
                        ));
                  },
                  child: Container(
                    height: 60,
                    color: Colors.white,
                    child: const Icon(Icons.analytics, size: 30, color: Colors.green),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Prediction(),
                      ));

                  },
                  child: Container(
                    height: 60,
                    color: Colors.white,
                    child:
                    const Icon(Icons.camera_alt, size: 30, color: Colors.green),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const user(),
                        ));
                  },
                  child: Container(
                    height: 60,
                    color: Colors.white,
                    child: const Icon(Icons.chat, size: 30, color: Colors.green),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ));
                  },
                  child: Container(
                    height: 60,
                    color: Colors.white,
                    child: const Icon(
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