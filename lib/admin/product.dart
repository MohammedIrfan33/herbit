import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:herbit/admin/prodcut_edit.dart';
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

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _plantController.text = documentSnapshot['plant_name'];
      _descriptionController.text = documentSnapshot['description'];
    }
    await showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            child: SizedBox(
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
                          decoration: const InputDecoration(
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
                          decoration: const InputDecoration(
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
                            final String plantName = _plantController.text;
                            final String description =
                                _descriptionController.text;

                            await _product.doc(documentSnapshot!.id).update({
                              "plant_name": plantName,
                              "description": description
                            });
                            _plantController.text = '';
                            _descriptionController.text = '';
                            Navigator.pop(context);
                          },
                          child: const Text('update')),
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
            child: SizedBox(
              height: 300,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    const Text('Add Analysis'),
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
                                    child: const Text("Upload Image"),
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
                                  child: const Text("Upload Image"),
                                ),
                              ],
                            ),
                    ),
                    //   Icon(Icons.add_a_photo,size: 45,),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        controller: _plantController,
                        decoration: const InputDecoration(
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
                        decoration: const InputDecoration(
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
                                print('image start');
                                await referenceImageToUpload
                                    .putFile(File(imageFile!.path));
                                    print('image upload');
                                imageUrl = await referenceImageToUpload
                                    .getDownloadURL();
                              } catch (error) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image not uploaded')));
                              }

                          if(imageUrl != ''){
                            final String plantName = _plantController.text;
                          final String description =
                              _descriptionController.text;
                          final String image = imageUrl;
                          await _product.add({
                            "plant_name": plantName,
                            "description": description,
                            "image": image
                          });
                          _plantController.text = '';
                          _descriptionController.text = '';

                          Navigator.pop(context);
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Somthing went wrong')));
                          }
                        },
                        child: const Text('submit')),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> _delete(String productId) async {
    await _product.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));

  }

  String _searchTerm = '';


  Stream<QuerySnapshot> getFilteredProductsStream() {
  
  CollectionReference productsRef = FirebaseFirestore.instance.collection('product');

 
  Query query = productsRef.where('plant_name', isEqualTo: _searchTerm.isEmpty ? null : _searchTerm);

  


  return query.snapshots();
}

 final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[900],
          title: const Text(
            'HERBAL',
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green[900],
          onPressed: () => _create(),
          child: const Icon(Icons.add),
        ),
        body:Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchTerm = value;
                });
              },
              decoration:const  InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 6, 53, 7)),
                  
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
            Expanded(
              child: StreamBuilder(
                stream: getFilteredProductsStream() ,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return GridView.builder(
                      itemCount: streamSnapshot.data!.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0
                      ),
                      itemBuilder: (BuildContext context, int index) {
            
                        final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
            
                        
                        
                        return InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => ProductEdit(
                                 id : documentSnapshot.id,)));
                          },
                          child: Card(
                            elevation: 10,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Image.network(
                                    documentSnapshot['image'],
                                    height: 99,
                                    width: 100,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 30),
                                  child: Text(
                                    documentSnapshot['plant_name'],
                                    style: const TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
            
                      },);
                  
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ));
  }

  /// Get from gallery
  Future<void> _getFromGallery() async {

    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() {
        imageFile = File(file.path);
      });
    }


   
  }

  /// Get from Camera
  Future<void> _getFromCamera() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);

    if (file != null) {
      setState(() {
        imageFile = File(file.path);
      });
    }
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
