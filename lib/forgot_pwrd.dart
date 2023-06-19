

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herbit/Login.dart';

class Forgotpwd extends StatefulWidget {
  const Forgotpwd({Key? key}) : super(key: key);

  @override
  State<Forgotpwd> createState() => _ForgotpwdState();
}

class _ForgotpwdState extends State<Forgotpwd> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  void resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        /* decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("images/img_8.png"),
                fit: BoxFit.cover)
        ),*/
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("FORGET PASSWORD", style: TextStyle(fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),),
              /* Image.asset("images/img_8.png",
                width: 800, height: 300,
              ),*/
              SizedBox(height: 25,),
              Align(
                alignment: Alignment.center,
                child: Text("we will send  a verification code to your email",
                  style: TextStyle(fontSize: 15, color: Colors.purple),
                  textAlign: TextAlign.center,),
              ),
              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email, color: Colors.purple),
                        label: Text(
                          "Email", style: TextStyle(color: Colors.purple),),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Colors.purple,
                                width: 1.5
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Colors.purple,
                                width: 1.5
                            )
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                            borderRadius: BorderRadius.circular(20)

                        ))

                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: () {
                openAlert();
                resetPassword(_emailController.text);  },
                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(29.0)),
                    primary: Colors.purple,
                    fixedSize: Size(350, 57)),
                child: Text("SUBMIT", style: TextStyle(
                    fontSize: 15, color: Colors.white
                )),),
            ]),
      ),
    );
  }


  Future openAlert() =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(

              content: Text(
                'Please check your email for create a new password',
                textAlign: TextAlign.center, style: TextStyle(fontSize: 17),),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                    },
                    child: Text('OK', style: TextStyle(fontSize: 17),)
                )
              ],
            ),
      );
}
