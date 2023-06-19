
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:herbit/public_user/homepage.dart';
import 'package:herbit/admin/product.dart';


class edit extends StatefulWidget {
  @override
  _editState createState() => _editState();
}
class _editState extends State<edit> {
  /// Variables
  late final _filename;
  File? imageFile;
  late String storedImage;
  String imageUrl='';
  /// Widget
  @override
  Widget build(BuildContext context) {
    Future<void> _showChoiceDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(

              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: const Text("upload your image"),
                      onTap: () {
                        _getFromGallery();
                        Navigator.pop(context);
                        //  _openGallery(context);
                      },
                    ),
                    SizedBox(height: 10),
                    const Padding(padding: EdgeInsets.all(0.0)),
                    /* GestureDetector(
                      child: const Text("Camera"),
                      onTap: () {
                       // _getFromCamera();

                        Navigator.pop(context);
                        //   _openCamera(context);
                      },
                    ),*/
                  ],
                ),
              ),
            );
          });
    }

    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.green[900],
            title: Text("add IMAGE")

        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: imageFile == null
                    ? Container(
                  child: Column(
                    children: <Widget>[
                      ElevatedButton(
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
                      ),
                      Container(
                        height: 100.0,
                        width: 100,
                      ),

                    ],
                  ),
                ) : Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Image.file(
                        imageFile!,
                        width: 200,
                        height: 200,
                        //  fit: BoxFit.cover,
                      ),
                    ), ElevatedButton(
                      onPressed: () {
                        //    _getFromGallery();
                        _showChoiceDialog(context);
                      },
                      child: Text("Upload Image"),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(

                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),

                      border: InputBorder.none,
                      hintText: "enter the name",
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                height: 140,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(

                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      border: InputBorder.none,
                      hintText: "enter your discription",
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              GestureDetector(onTap: () {
             /*   Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const product()),
                );*/

              },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green[900],
                    borderRadius: BorderRadius.circular(5),
                  ), /* ]*/
                  height: 50,
                  width: 120,
                  child: Center(child: Text('submit')),

                ),),
            ],
          ),

        ));
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }


/// Get from Camera
/* _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }*/
}