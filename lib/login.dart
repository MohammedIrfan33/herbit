import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herbit/doctor/home_doctor.dart';
import 'package:herbit/register_dash.dart';
import 'package:herbit/user/home_user.dart';

import 'admin/home_admin.dart';
import 'forgot_pwrd.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordVisible = false;
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  String status = '';
  String st2 = '';
  String role = '';
  String name = "user";
  String name1 = "admin";
  String name2 = "doctor";

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  Future<void> loginWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      // Authenticate user with email and password
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.trim(), password: password.trim());

      // Get the user's ID
      String userId = userCredential.user!.uid;

      // Retrieve the user's role from the Firestore collection
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('login')
          .doc(userId)
          .get();

      // Check if the document exists and retrieve the 'role' field
      if (snapshot.exists) {
        Map<String, dynamic>? userData =
            snapshot.data() as Map<String, dynamic>?;
        if (userData != null && userData['role'] != null) {
          role = userData['role'] as String;
          bool isAccepted = userData['isAccepted'];

          print("role$role");

          if (role == 'user') {
            if (isAccepted == true) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Homeuser(),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Admin not Verified')));
            }
          } else if (role == 'doctor') {
            print(isAccepted);
            if (isAccepted == true) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const home_doctor(),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Admin not Verified')));
            }
          } else if (role == 'admin') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const home_admin(),
              ),
            );
          } else {
            final snackBar = SnackBar(
              content: Text("Something wronng".toString()),
              duration: const Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            // Unknown role, handle appropriately
            print('Unknown role');
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "Document exists, but data is null",
              style: TextStyle(fontSize: 16),
            ),
          ));
          // Document exists, but data is null
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Document doesn't exist, handle appropriately",
            style: TextStyle(fontSize: 16),
          ),
        ));
        // Document doesn't exist, handle appropriately
      }
    } catch (e) {
      // Error occurred during login
      print('Login error: $e');
      // Handle error
    }
  }
/*  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      // Authenticate user with email and password
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Get the user's ID
      String userId = userCredential.user!.uid;
      print("userid$userId");

      // Retrieve the user's role from the Firestore collection
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('login')
          .doc(userId)
          .get();
      DocumentSnapshot snapshotrole = await FirebaseFirestore.instance
          .collection('user_Tb')
          .doc(userId)
          .get();
      DocumentSnapshot doctrole = await FirebaseFirestore.instance
          .collection('doctor')
          .doc(userId)
          .get();

      status = snapshotrole['status']as String;
      st2 = doctrole['status']as String;
      print("st2$st2");
      // Check if the document exists and retrieve the 'role' field
      if (snapshot.exists  ) {
        Map<String, dynamic>? userData =
        snapshot.data() as Map<String, dynamic>?;
        if (userData != null && userData['role'] != null) {
          role = userData['role'] as String;
          print("role$role");


          if (role == 'user'*/ /* && status =="accepted"*/ /*) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Homeuser(),
              ),
            );
          } else if (role == 'doctor'*/ /* && status =="accepted"*/ /*) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => home_doctor(),
              ),
            );
          } else if (role == 'admin') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => home_admin(),
              ),
            );
          } else {
            final snackBar = SnackBar(
              content: Text("Something wronng".toString()),
              duration: Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);

            // Unknown role, handle appropriately
            print('Unknown role');
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Document exists, but data is null",
              style: TextStyle(fontSize: 16),
            ),
          ));
          // Document exists, but data is null
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Document doesn't exist, handle appropriately",
            style: TextStyle(fontSize: 16),
          ),
        ));
        // Document doesn't exist, handle appropriately
      }
    } catch (e) {
      // Error occurred during login
      print('Login error: $e');
      // Handle error
    }
  }*/

  @override
  Widget build(BuildContext context) {
    var child;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 300,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/leaf1.jpeg'),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40))),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Column(
                              children: [
                                const Text(
                                  'Sign in',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 16),
                                  child: TextField(
                                    controller: _emailcontroller,
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey[300],
                                      filled: true,
                                      suffixIcon: const Icon(Icons.person),
                                      // prefixIcon: Icon(Icons.person),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      border: InputBorder.none,
                                      hintText: 'username',
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 16),
                                  child: TextField(
                                    controller: _passwordcontroller,
                                    obscureText: passwordVisible,
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey[300],
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      border: InputBorder.none,
                                      hintText: 'password',
                                      suffixIcon: IconButton(
                                        icon: Icon(passwordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                        onPressed: () {
                                          setState(
                                            () {
                                              passwordVisible =
                                                  !passwordVisible;
                                            },
                                          );
                                        },
                                      ),
                                      alignLabelWithHint: false,
                                      filled: true,
                                    ),
                                    keyboardType: TextInputType.visiblePassword,
                                    textInputAction: TextInputAction.done,
                                  ),
                                ),
                              ],
                            ),
                            /*ElevatedButton(
                      onPressed: () {},
                      child: Text('LOGIN',
                          style: TextStyle(fontSize: 15, color: Colors.black))),*/
                            Column(
                              children: [
                                const SizedBox(
                                  height: 90,
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.green[900],
                                  ),
                                  child: TextButton(
                                    child: const Text(
                                      'Sign In',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25),
                                    ),
                                    onPressed: () {
                                      if (_emailcontroller.text ==
                                          'admin@gmail.com') {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const home_admin(),
                                          ),
                                        );
                                      } else {
                                        loginWithEmailAndPassword(
                                            _emailcontroller.text,
                                            _passwordcontroller.text,
                                            context);
                                      }
                                      /*AuthenticationHelper()
                                            .signIn(email: _emailcontroller.text, password: _passwordcontroller.text)
                                            .then((result) {
                                          if (result == null) {
                                         route();
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text(
                                                result,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ));
                                          }
                                        });*/
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Don't have an account?",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const MainDash()),
                                          );
                                        },
                                        child: const Text("Sign up"))
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const Forgotpwd(),
                                        ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Text(
                                      "forgot Password?",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.green[900],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /* void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('login')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "user") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  Homeuser(),
            ),
          );
        }else if(documentSnapshot.get('role') == "doctor")
        {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  home_doctor(),
            ),
          );
        }
        else if(documentSnapshot.get('role') == "admin"){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  home_admin(),
            ),
          );
        }
      }
      else {
        print('Document does not exist on the database');
      }
    });
  }*/
}
