import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:herbit/firebase/authentication.dart';
import 'package:image_picker/image_picker.dart';

import 'login.dart';

class register_doctor extends StatefulWidget {
  const register_doctor({Key? key}) : super(key: key);

  @override
  State<register_doctor> createState() => _register_doctorState();
}

class _register_doctorState extends State<register_doctor> {
  bool passwordVisible = false;
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _firstnamecontroller = TextEditingController();
  final TextEditingController _qualificationcontroller = TextEditingController();

  bool loading = false;

  ImagePicker picker = ImagePicker();
  XFile? image;
  File? imageFile;
  late String storedImage;
  String imageUrl = '';
  String ? selectedValue;

  List<String> items= [
  'Vata',
  'Pitta',
  'Kapha',
  'Digestive System',
  'Respiratory System',
  'Joint and Musculoskeletal System',
  'Skin and Hair Care',
  "Women's Health",
  'Stress and Anxiety',
  'Detoxification',
];

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
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
                        child:
                            const Image(image: AssetImage('images/leaf.jpg')),
                      )
                    ],
                  ),
                ),

                Container(
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
                      hintText: "email",
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please choose a name to use";
                      }
                      return null;
                    },
                    controller: _firstnamecontroller,
                    decoration: const InputDecoration(
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
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Mobile Number';
                    }
                    RegExp number = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
                    if (number.hasMatch(value)) {
                      return null;
                    } else {
                      return 'Invalid Mobile Number';
                    }
                  },
                  keyboardType: TextInputType.number,
                  controller: _phonecontroller,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    prefixIcon: Icon(Icons.phone),
                    border: InputBorder.none,
                    hintText: "phone number",
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please choose a name to use";
                    }
                    return null;
                  },
                  controller: _qualificationcontroller,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    prefixIcon: Icon(Icons.person),
                    border: InputBorder.none,
                    hintText: "qualificaton",
                  ),
                ),

                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    validator: (valuePass) {
                      if (valuePass!.isEmpty) {
                        return 'Please enter your Password';
                      } else if (valuePass.length < 6) {
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
                const SizedBox(
                  height: 15,
                ),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: DropdownButton(
                    isExpanded: true,
                    value: selectedValue,
                    hint: const Text('Select specializations'),
                    elevation: 0,
                    underline: const SizedBox(),
                    dropdownColor: Colors.grey[200],

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Upload Certificate",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green[900]),
                      onPressed: () {
                        _showChoiceDialog(context);

                      },
                      child: const Text("Upload Certificate"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  child: imageFile == null
                      ? const SizedBox.shrink()
                      : Row(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(imageFile!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
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

                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 60),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green[900],
                  ),
                  height: 60,
                  child:loading ?const Center(child:   CircularProgressIndicator(color: Colors.white,)) :TextButton(
                    child: const Text(
                      'Sign up',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    onPressed: () async{
                    

                    if(_formKey.currentState!.validate())
                    {
                    setState(() {
                      loading = true;
                    });
                     await AuthenticationHelper()
                          .Signupdoc(
                              email: _emailcontroller.text,
                              password: _passwordcontroller.text,
                              name: _firstnamecontroller.text,
                              qualification: _qualificationcontroller.text,
                              phone: _phonecontroller.text,
                              image: imageUrl,
                              specialisation: selectedValue ?? '')
                          .then((result) {

                            setState(() {
                              loading = false;
                            });

                        if (result == null) {

                          

                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const Login(),
                              ),
                              (Route route) => false);
                        } else {
                          setState(() {
                            loading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              result,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ));
                        }
                      });
                    }else{

                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                              'Some fields are empty',
                              style:  TextStyle(fontSize: 16),
                            ),
                          ));

                    }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
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
  Future<void> _getFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

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
