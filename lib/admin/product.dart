import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class product extends StatefulWidget {
  const product({Key? key}) : super(key: key);

  @override
  State<product> createState() => _productState();
}

class _productState extends State<product> {
  final CollectionReference _product = FirebaseFirestore.instance
      .collection('product'); //refer to the table we created
  late final _filename;
  File? imageFile;
  File? file;
  late String storedImage;

  String imageUrl = '';
  final TextEditingController _plantController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
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
                  SizedBox(height: 10),
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

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _plantController.text = documentSnapshot['plant_name'];
      _descriptionController.text = documentSnapshot['description'];
    }
    await showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context as BuildContext,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            child: Container(
              height: 300,
              child: Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('update plants'),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          controller: _plantController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            border: InputBorder.none,
                            hintText: "enter plants name",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            border: InputBorder.none,
                            hintText: "enter the description",
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            final String plant_name = _plantController.text;
                            final String? description =
                                _descriptionController.text;

                            if (description != null) {
                              await _product.doc(documentSnapshot!.id).update({
                                "plant_name": plant_name,
                                "description": description
                              });
                              _plantController.text = '';
                              _descriptionController.text = '';
                            }
                            Navigator.pop(context);
                          },
                          child: Text('update')),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _plantController.text = documentSnapshot['plant_name'];
      _descriptionController.text = documentSnapshot['description'];
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            child: Container(
              height: 300,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text('Add Analysis'),
                    Container(
                      /* decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/bg.jpg')
                      )
                    ),*/
                      child: imageFile == null
                          ? Container(
                              child: Column(
                                children: <Widget>[
                                  ElevatedButton(
                                    onPressed: () {
                                      //    _getFromGallery();
                                      _showChoiceDialog(context);
                                    },
                                    child: Text("Upload Image"),
                                  ),
                                  Container(
                                    height: 40.0,
                                  ),
                                ],
                              ),
                            )
                          : Row(
                              children: [
                                Container(
                                  width: 45,
                                  height: 45,
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(imageFile!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    //    _getFromGallery();
                                    _showChoiceDialog(context);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Upload Image"),
                                ),
                              ],
                            ),
                    ),
                    //   Icon(Icons.add_a_photo,size: 45,),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        controller: _plantController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          border: InputBorder.none,
                          hintText: "enter details",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          border: InputBorder.none,
                          hintText: "enter the description",
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {

                          final String plant_name = _plantController.text;
                          final String? description =
                              _descriptionController.text;
                          final String? image = imageUrl;
                          if (description != null) {
                            await _product.add({
                              "plant_name": plant_name,
                              "description": description,
                              "image": image
                            });
                            _plantController.text = '';
                            _descriptionController.text = '';
                          }
                        },
                        child: Text('submit')),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> _delete(String productId) async {
    await _product.doc(productId).delete();

    ScaffoldMessenger.of(context as BuildContext).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }

  @override
  Widget build(BuildContext context) {
    var streamSnapshot;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[900],
          title: Text(
            'HERBAL',
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
          child: const Icon(Icons.add),
        ),
        body: Container(
          child: StreamBuilder(
            stream: _product.snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      print("snap ${documentSnapshot}");
                      return Container(
                        height: 50,
                        width: 150,
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(documentSnapshot['image']),
                          ),
                          title: Text(documentSnapshot['plant_name']),
                          subtitle: Text(documentSnapshot['description']),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => setState(() {
                                    _update(documentSnapshot);
                                  }),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () =>setState(() {
                                    _delete(documentSnapshot.id);
                                  })
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ));
  }

  /// Get from gallery
  Future<void> _getFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    print('${file?.path}');
    if (file != null) {
      setState(() {
        imageFile = File(file.path);
      });
    }
    String uniquename = DateTime.now().microsecondsSinceEpoch.toString();
    Reference refrenceroot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = refrenceroot.child('images');

    Reference referenceImageToUpload = referenceDirImages.child(uniquename);

    try {
      await referenceImageToUpload.putFile(File(file!.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (error) {}
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
    String uniquename = DateTime.now().microsecondsSinceEpoch.toString();
    Reference refrenceroot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = refrenceroot.child('images');

    Reference referenceImageToUpload = referenceDirImages.child(uniquename);

    try {
      await referenceImageToUpload.putFile(File(file!.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (error) {}

    /*   PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      */ /*  _filename = basename(imageFile!.path).toString();
        final _nameWithoutExtension = basenameWithoutExtension(imageFile!.path);
        final _extenion = extension(imageFile!.path);*/ /*
      });
    }*/
  }
}
