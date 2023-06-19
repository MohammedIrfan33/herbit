import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:herbit/admin/home_admin.dart';
import 'package:herbit/doctor/home_doctor.dart';
import 'package:herbit/firebase/authentication.dart';
import 'package:image_picker/image_picker.dart';

import 'Login.dart';

class register_doctor extends StatefulWidget {
  const register_doctor({Key? key}) : super(key: key);

  @override
  State<register_doctor> createState() => _register_doctorState();
}

class _register_doctorState extends State<register_doctor> {
  bool passwordVisible = false;
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _phonecontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _firstnamecontroller = TextEditingController();
  TextEditingController _qualificationcontroller = TextEditingController();
  ImagePicker picker = ImagePicker();
  XFile? image;
  File? imageFile;
  late String storedImage;
  String imageUrl='';

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:const Text("Choose from"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: const Text("Gallery"),
                    onTap: () {

                      _getFromGallery();
                      Navigator.pop(context);
                      //  _openGallery(context);
                    },
                  ),
                  SizedBox(height:10),
                  const Padding(padding: EdgeInsets.all(0.0)),
                  GestureDetector(
                    child: const Text("Camera"),
                    onTap: () {
                      _getFromCamera();

                      Navigator.pop(context);
                      //   _openCamera(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child:  Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
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
                        child: Image(image: AssetImage('images/leaf.jpg')),
                      )
                    ],
                  ),
                ),

                Container(
                  child:  TextFormField(
                    validator: (valueMail) {
                      if (valueMail!.isEmpty) {
                        return 'Please enter Email Id';
                      }
                      RegExp email = new RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if (email.hasMatch(valueMail)) {
                        return null;
                      } else {
                        return 'Invalid Email Id';
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailcontroller,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      prefixIcon: Icon(Icons.email_sharp),
                      border: InputBorder.none,
                      hintText: "email",
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: TextFormField(
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please choose a name to use";
                      }
                    },
                    controller: _firstnamecontroller,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      prefixIcon: Icon(Icons.person),
                      border: InputBorder.none,
                      hintText: 'full name',
                    ),
                  ),
                ),
                Container(
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Mobile Number';
                      }
                      RegExp number = new RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
                      if (number.hasMatch(value)) {
                        return null;
                      } else {
                        return 'Invalid Mobile Number';
                      }
                    },
                    keyboardType: TextInputType.number,
                    controller: _phonecontroller,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      prefixIcon: Icon(Icons.phone),
                      border: InputBorder.none,
                      hintText: "phone number",
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  child: TextFormField(
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please choose a name to use";
                      }
                    },
                    controller: _qualificationcontroller,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      prefixIcon: Icon(Icons.person),
                      border: InputBorder.none,
                      hintText: "qualificaton",
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child:TextFormField(

                    validator: (valuePass) {
                      if (valuePass!.isEmpty) {
                        return 'Please enter your Password';
                      }else if(valuePass.length<6){
                        return 'Password too short';
                      } else {
                        return null;
                      }
                    },
                    controller: _passwordcontroller,
                    obscureText: passwordVisible,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
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
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Upload Certificate",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),

                SizedBox( height: 30,),
                Container(

                  child: imageFile == null
                      ? Container(
                    child: Column(
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            //    _getFromGallery();
                            _showChoiceDialog(context);
                          },
                          child: Text("Upload Certificate"),
                        ),
                        Container(
                          height: 40.0,
                        ),

                      ],
                    ),
                  ): Row(
                    children: [
                      Container(
                        width: 70,
                        height:70,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(imageFile!),
                            fit: BoxFit.cover,
                          ),
                        ),

                      ),
                      SizedBox( width: 30,),
                      ElevatedButton(
                        onPressed: () {
                          //    _getFromGallery();
                          _showChoiceDialog(context);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>register_doctor()));
                        },
                        child: Text("Upload Certificate"),
                      ),
                    ],
                  ),
                ),
              /*  ElevatedButton(
                  onPressed: () async {
                    //    _getFromGallery();
                    ImagePicker imagePicker=ImagePicker();
                    XFile? file= await imagePicker.pickImage(source: ImageSource.gallery);
                    print('${file?.path}');

                    String uniquename=DateTime.now().microsecondsSinceEpoch.toString();
                    Reference refrenceroot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages=refrenceroot.child('images');

                    Reference referenceImageToUpload=referenceDirImages.child(uniquename);

                    try {
                      await referenceImageToUpload.putFile(File(file!.path));
                      imageUrl= await  referenceImageToUpload.getDownloadURL();

                    }catch(error){

                    }
                  },
                  child: Text("pick from gallery"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    //    _getFromGallery();
                    ImagePicker imagePicker=ImagePicker();
                    XFile? file= await imagePicker.pickImage(source: ImageSource.camera);
                    print('${file?.path}');

                    String uniquename=DateTime.now().microsecondsSinceEpoch.toString();
                    Reference refrenceroot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages=refrenceroot.child('images');

                    Reference referenceImageToUpload=referenceDirImages.child(uniquename);

                    try {
                      await referenceImageToUpload.putFile(File(file!.path));
                      imageUrl= await  referenceImageToUpload.getDownloadURL();

                    }catch(error){
                    }
                  },
                  child: Text("pick from camera"),
                ),*/

                SizedBox( height: 30,),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 60),
                  height: 60,
                  color: Colors.green[900],
                  child: TextButton(
                    child: Text(
                      'Sign up',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    onPressed: () {
                      AuthenticationHelper()
                          .Signupdoc(email:_emailcontroller.text, password: _passwordcontroller.text,
                          name: _firstnamecontroller.text, qualification: _qualificationcontroller.text, phone: _phonecontroller.text, image: imageUrl)
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
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                        },
                        child: const Text("SignIn"))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  /// Get from gallery
  Future<void>  _getFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    print('${file?.path}');
    if (file != null) {
      setState(() {

        imageFile = File(file.path);
      });
    }
    String uniquename = DateTime
        .now()
        .microsecondsSinceEpoch
        .toString();
    Reference refrenceroot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = refrenceroot.child('images');

    Reference referenceImageToUpload = referenceDirImages.child(uniquename);

    try {
      await referenceImageToUpload.putFile(File(file!.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (error) {

    }


  }

  /// Get from Camera
  Future<void> _getFromCamera() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
    print('${file?.path}');
    if (file != null) {
      setState(() {

        imageFile = File(file.path);
      });
    }
    String uniquename = DateTime
        .now()
        .microsecondsSinceEpoch
        .toString();
    Reference refrenceroot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = refrenceroot.child('images');

    Reference referenceImageToUpload = referenceDirImages.child(uniquename);

    try {
      await referenceImageToUpload.putFile(File(file!.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (error) {

    }


    /*   PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      *//*  _filename = basename(imageFile!.path).toString();
        final _nameWithoutExtension = basenameWithoutExtension(imageFile!.path);
        final _extenion = extension(imageFile!.path);*//*
      });
    }*/
  }
}
