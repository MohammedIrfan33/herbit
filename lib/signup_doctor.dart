import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'login.dart';

class Signup_Doctor extends StatefulWidget {
  const Signup_Doctor({Key? key}) : super(key: key);

  @override
  State<Signup_Doctor> createState() => _Signup_DoctorState();
}

class _Signup_DoctorState extends State<Signup_Doctor> {
  bool passwordVisible = false;
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _firstnamecontroller = TextEditingController();
  final TextEditingController _qualificatoncontroller = TextEditingController();
  ImagePicker picker = ImagePicker();
  XFile? image;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  /* String? dropdownvalue;

  // List of items in our dropdown menu
  var items = ['user', 'doctor'];
  bool _isVisible = true;
  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }
*/
  @override
  Widget build(BuildContext context) {
    var child;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30,),
                  // Container(
                  //   width: 300,
                  //   height: 150,
                  //   decoration: BoxDecoration(
                  //       image: DecorationImage(
                  //
                  //           image: AssetImage('images/loginimage.jpg'),
                  //           fit: BoxFit.fill)),
                  // ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          color: Colors.white,
                          child: const Image(image: AssetImage('images/leaf.jpg')),
                        )
                      ],
                    ),
                  ),
                  /*   Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 27),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.zero),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(color: Colors.black),
                            )),
                        hint: Text(
                          'choose your option',
                          style: TextStyle(color: Colors.black),
                        ),
                        value: dropdownvalue,
                        onChanged: (vale) {
                          setState(() {
                            dropdownvalue = vale.toString();
                          });
                        },
                        items: items
                            .map((vale) => DropdownMenuItem(
                            value: vale, child: Text(vale)))
                            .toList(),
                      ),
                    ),
                  ),*/
                  Container(
                    child: TextField(
                      controller: _emailcontroller,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        prefixIcon: Icon(Icons.email_sharp),
                        border: InputBorder.none,
                        hintText: "email or phone number",
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: TextField(
                      controller: _firstnamecontroller,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
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
                  Container(
                    child: TextField(
                      controller: _qualificatoncontroller,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        prefixIcon: Icon(Icons.person),
                        border: InputBorder.none,
                        hintText: "qualificaton",
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      controller: _passwordcontroller,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
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
                  /* Container(
                    child:  Visibility(
                      visible: _isVisible,
                      child: Text("age"
                      ),
                    ),
                  ),*/
                  /*ElevatedButton(
                        onPressed: () {},
                        child: Text('LOGIN',
                            style: TextStyle(fontSize: 15, color: Colors.black))),*/
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      "select image to upload",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green[900],
                      ),
                      onPressed: () async {
                        image = await picker.pickImage(
                            source: ImageSource.gallery);
                        setState(() {
                          //update UI
                        });
                      },
                      child: const Text("Pick from gallery")),
                  image == null ? Container() : Image.file(File(image!.path)),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green[900],
                      ),
                      onPressed: () async {
                        image = await picker.pickImage(
                            source: ImageSource.camera);
                        setState(() {
                          //update UI
                        });
                      },
                      child: const Text("Pick from camera")),
                  image == null ? Container() : Image.file(File(image!.path)),


                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 60),
                    height: 60,
                    color: Colors.green[900],
                    child: TextButton(
                      child: const Text(
                        'Sign up',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      onPressed: () {
                       /* Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));*/

                      },
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
        ),
      ),
    );
  }
}
