import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:herbit/doctor/home_doctor.dart';
import 'package:image_picker/image_picker.dart';

class profile_doctor extends StatefulWidget {
  const profile_doctor({Key? key}) : super(key: key);

  @override
  State<profile_doctor> createState() => _profile_doctorState();
}

class _profile_doctorState extends State<profile_doctor> {
  String userId = '';
  User? user;
  TextEditingController fullnameController = TextEditingController();
  TextEditingController phnController = TextEditingController();
  TextEditingController qlController = TextEditingController();
  TextEditingController spController = TextEditingController();

  File? imageFile;

  String ? imageUrl;
  String? pimage;

  bool loading = false;

  void fetchUserData() async {
    user = FirebaseAuth.instance.currentUser;
    userId = user!.uid;
    await FirebaseFirestore.instance
        .collection('doctor')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        setState(() {
          String fullname = data['fullname'] as String;
          String phone = data['phone'] as String;
          String ql = data['qualification'] as String;
          String sp = data['specialisation'] as String;

          fullnameController.text = fullname;
          phnController.text = phone;
          qlController.text = ql;
          spController.text = sp;
          pimage = data['pimage'];
        });
      } else {}
    }).catchError((error) {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserData();
  }

  void updateUserData(
      String fullname, String phn, String quali, String? image) async {
    if (image != null) {
      await FirebaseFirestore.instance
          .collection('doctor')
          .doc(userId)
          .update({'pimage': image});
    }
    await FirebaseFirestore.instance.collection('doctor').doc(userId).update({
      'fullname': fullname,
      'phone': phn,
      'qualification': quali,
      'pimage': image
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data updated successfully'),
        ),
      );
    }).catchError((error) {});
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
        backgroundColor: Colors.green[900],
        title: const Text('Profile'),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Center(
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
                      child: TextField(
                        controller: phnController,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.email),
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: TextField(
                        controller: qlController,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.medical_information,
                          ),
                          border: InputBorder.none,
                          hintText: 'qualifications',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: TextField(
                        controller: spController,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.medical_services,
                          ),
                          border: InputBorder.none,
                          hintText: 'Speclizations',
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
                          if (imageFile != null) {
                            String uniquename = DateTime.now()
                                .microsecondsSinceEpoch
                                .toString();
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
                              phnController.text.trim(),
                              qlController.text.trim(),
                              imageUrl);

                          fetchUserData();
                          setState(() {
                            loading = false;
                          });
                        },
                        child: const Text("Update"))
                  ],
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
