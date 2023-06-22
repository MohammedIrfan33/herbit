import 'package:flutter/material.dart';

import 'public_user/homepage.dart';
class welcome extends StatefulWidget {
  const welcome({Key? key}) : super(key: key);

  @override
  State<welcome> createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      children: [Expanded(

   child:     Container(
        height: 900,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('aleovera/.jpg'),fit: BoxFit.fill)
        ),),
      ), TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const homepage(),));
            },
            child: const Text(
              'Submit ',
              style: TextStyle(color: Colors.white),
            ),
          ),

        ],

      ),

    );
  }
}
