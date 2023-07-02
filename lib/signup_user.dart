import 'package:flutter/material.dart';
import 'package:herbit/firebase/authentication.dart';

import 'login.dart';
class User_signup extends StatefulWidget {
  const User_signup({Key? key}) : super(key: key);

  @override
  State<User_signup> createState() => _User_signupState();
}

class _User_signupState extends State<User_signup> {
  bool passwordVisible = false;
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _fullnamecontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _agecontroller = TextEditingController();

  bool loading = false;

  String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return 'Please enter a phone number.';
    }

    // Remove any non-digit characters from the phone number
    String cleanedPhoneNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Check if the cleaned phone number has exactly 10 digits
    if (cleanedPhoneNumber.length != 10) {
      return 'Phone number must have 10 digits.';
    }

    return null; // Return null if the phone number is valid
  }
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
  

    return  Scaffold(

        body: SingleChildScrollView(
          child: Center(
          child:  Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 60,
                        width: 60,
                        color: Colors.white,
                        child: const Image(image: AssetImage('images/leaf.jpg')),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (valueMail) {
                    if (valueMail!.isEmpty) {
                      return 'Please enter Email Id';
                    }
                    RegExp email = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                    if (email.hasMatch(valueMail)) {
                      return null;
                    } else {
                      return 'Invalid Email Id';
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailcontroller,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    prefixIcon: Icon(Icons.email_sharp),
                    border: InputBorder.none,
                    hintText: "email ",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child:TextFormField(
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please choose a name to use";
                      }
                      return null;
                    },
                    controller: _fullnamecontroller,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      prefixIcon: Icon(Icons.person),
                      // enabledBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(50)),
                      // focusedBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(50)),
                      border: InputBorder.none,
                      hintText: 'full name',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: TextFormField(
                    validator:validatePhoneNumber,/* (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Mobile Number';
                      }
                      RegExp number = new RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
                      if (number.hasMatch(value)) {
                        return null;
                      } else {
                        return 'Invalid Mobile Number';
                      }
                    },*/
                    keyboardType: TextInputType.number,
                    controller: _phonecontroller,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      prefixIcon: Icon(Icons.phone),
                      border: InputBorder.none,
                      hintText: "phone",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child:  TextFormField(
                    validator: (valuePass) {
                      if (valuePass!.isEmpty) {
                        return 'Please enter your Password';
                      } else if(valuePass.length<6){
                        return 'Password too short';
                      } else {
                        return null;
                      }
                    },
                    controller: _passwordcontroller,
                    obscureText: passwordVisible,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      // enabledBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(50)),
                      // focusedBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(50)),
                      border: InputBorder.none,
                      hintText: 'password',
                      prefixIcon: IconButton(
                        icon: Icon(passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(
                                () {
                              passwordVisible = !passwordVisible;
                            },
                          );
                        },
                      ),
                      alignLabelWithHint: false,
                      // filled: true,
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: TextField(
                    controller: _agecontroller,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      prefixIcon: Icon(Icons.email_sharp),
                      border: InputBorder.none,
                      hintText: "AGE",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 60),
                  height: 60,
                  color: Colors.green[900],
                  child: loading ?const Center(child: CircularProgressIndicator(color: Colors.white,),) :TextButton(
                    child: const Text(
                      'Sign up',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    onPressed: () async{

                      setState(() {
                        loading = true;
                      });

                     await AuthenticationHelper()
                          .signUp(email: _emailcontroller.text, password:_passwordcontroller.text,name:_fullnamecontroller.text,age:_agecontroller.text,phone: _phonecontroller.text)
                          .then((result) {
                        if (result == null) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => const Login()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              result,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ));
                        }
                      }
                      );
                      setState(() {
                        loading = false;
                      });
                    /*  AuthenticationHelper()
                          .signUp(email: _emailcontroller.text, password:_passwordcontroller.text , name: _fullnamecontroller.text, age: _agecontroller.text, phone: _phonecontroller.text)
                          .then((result) {
                        if (result == null) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Login()));
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "you have an account?",
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
                              builder: (context) => const Login()),
                        );
                      },
                      child: const Text("Sign in"))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
      ),
          ),
    ),
        )

    );
  }
}
