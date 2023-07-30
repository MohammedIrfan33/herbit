import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:herbit/user/home_user.dart';
import 'package:image_picker/image_picker.dart';

class profile_user extends StatefulWidget {
  const profile_user({Key? key}) : super(key: key);

  @override
  State<profile_user> createState() => _profile_userState();
}

class _profile_userState extends State<profile_user> {
  ImagePicker picker = ImagePicker();
  XFile? image;

  final _formKey = GlobalKey<FormState>();

  String userId = '';
  User? user;
  File? imageFile;

  String  ? imageUrl;
  String? pimage;
  bool loading = false;
  TextEditingController fullnameController = TextEditingController();
  TextEditingController phnController = TextEditingController();
  TextEditingController ageController = TextEditingController();

   fetchUserData() async {
    user =  FirebaseAuth.instance.currentUser;
    userId = user!.uid;
    await FirebaseFirestore.instance
        .collection('user_Tb')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        String fullname = data['fullname'] as String;
        String age = data['age'] as String;
        String phone = data['phone'] as String;

        fullnameController.text = fullname;
        phnController.text = phone;
        ageController.text = age;
        pimage = data['pimage'];

        
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Somthing went wrong!!!')));
      }

      setState(() {
        
      });
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Somthing went wrong!!!')));
    });
  }

  @override
  void initState() {

    print('init called');

    fetchUserData();
    // TODO: implement initState
    super.initState();
    
  }

   updateUserData(
      String fullname, String age, String phn, String? image) async {
        if (image != null) {
      await FirebaseFirestore.instance
          .collection('user_Tb')
          .doc(userId)
          .update({'pimage': image});
    }
    await FirebaseFirestore.instance.collection('user_Tb').doc(userId).update({
      'fullname': fullname,
      'age': age,
      'phone': phn,
      
    }).then((value) {
     
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data updated successfully'),
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Somthing went wrong!!!')));
    });
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Choose from"),
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
                  const SizedBox(height: 10),
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
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.green[900],
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Center(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: imageFile != null
                            ? Container(
                                height: 100,
                                width: 100,
                                clipBehavior: Clip.hardEdge,
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: Image(
                                    fit: BoxFit.cover,
                                    image: FileImage(imageFile!)),
                              )
                            : pimage != null
                                ? Container(
                                    height: 100,
                                    width: 100,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle),
                                    child: Image(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(pimage!)),
                                  )
                                : const CircleAvatar(
                                    radius: 60,
                                    backgroundImage:
                                        AssetImage('images/Herbal.jpg'),
                                  ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[900]),
                          onPressed: () {
                            _showChoiceDialog(context);
                          },
                          child: const Text('Edit photo')),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: TextField(
                          controller: fullnameController,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(Icons.person),
                            border: InputBorder.none,
                            hintText: 'username',
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Mobile Number';
                            }
                            RegExp number =
                                RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
                            if (number.hasMatch(value)) {
                              return null;
                            } else {
                              return 'Invalid Mobile Number';
                            }
                          },
                          keyboardType: TextInputType.number,
                          controller: phnController,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(Icons.phone),
                            border: InputBorder.none,
                            hintText: 'phone',
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: TextField(
                          controller: ageController,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(
                              Icons.date_range_sharp,
                            ),
                            border: InputBorder.none,
                            hintText: 'age',
                          ),
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[900]),
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });

                            if(imageFile != null){

                              String uniquename =
                              DateTime.now().microsecondsSinceEpoch.toString();
                          Reference refrenceroot =
                              FirebaseStorage.instance.ref();
                          Reference referenceDirImages =
                              refrenceroot.child('images');

                          Reference referenceImageToUpload =
                              referenceDirImages.child(uniquename);

                          try {
                            await referenceImageToUpload.putFile(imageFile!);

                            imageUrl =
                                await referenceImageToUpload.getDownloadURL();
                          } catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Image not uploaded')));
                          }


                            }
                            updateUserData(
                                fullnameController.text.trim(),
                                ageController.text.trim(),
                                phnController.text.trim(),
                                imageUrl);

                            await fetchUserData();

                            setState(() {
                              loading = false;
                            });
                          },
                          child: const Text("Update"))
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  /// Get from gallery
  Future<void> _getFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    if (file != null) {
      setState(() {
        imageFile = File(file.path);
      });
    }
  }

  /// Get from Camera
  Future<void> _getFromCamera() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 30);

    if (file != null) {
      setState(() {
        imageFile = File(file.path);
      });
    }
  }
}
