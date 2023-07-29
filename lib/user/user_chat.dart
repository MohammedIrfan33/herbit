import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../firebase/file_upload.dart';
import '../utils/getTime.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key, this.doctorId});

  String? doctorId;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<QuerySnapshot>? _messageStream;
  QueryDocumentSnapshot<Object>? selcteddoctor;

  String? file;

  String? specialication;

  List<String> spList = ['General', 'Ortho'];
  var docList = [];
  User? currentUser;

  @override
  void initState() {
    currentUser = _auth.currentUser;

    _messageStream = _firestore
        .collection('chats')
        .where('doctorId', isEqualTo: widget.doctorId)
        .where('patientId', isEqualTo: currentUser?.uid)
        .orderBy('time', descending: true)
        .snapshots();

    super.initState();
  }

  Future<void> _sendMessage(
      {String? messageText, bool isImage = false, String? file}) async {
    if (currentUser == null) return;

    await _firestore.collection('chats').add({
      'doctorId': widget.doctorId,
      'patientId': currentUser?.uid,
      'senderId': currentUser?.uid,
      'messageText': messageText,
      'file': file,
      'isImage': isImage,
      'time': DateTime.now().millisecondsSinceEpoch,
    });

    _messageController.clear();
  }

  // getDoctorList(String specialication) async {
  //   final data = FirebaseFirestore.instance
  //       .collection('doctor')
  //       .where('specialisation', isEqualTo: specialication);

  //   await data.get().then((QuerySnapshot querySnapshot) {
  //     docList = querySnapshot.docs;

  //   });

  //   setState(() {});
  // }

  bool isloading = false;
  File ? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        backgroundColor: Colors.green[900],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          widget.doctorId == null
              ? const Expanded(
                  child: Center(
                  child: Text('Select the doctor'),
                ))
              : Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _messageStream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final messages = snapshot.data!.docs;

                      return
                       ListView.builder(
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final String senderId =
                              messages[index].get('senderId');

                          return Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: senderId == currentUser?.uid
                                ? Alignment.bottomRight
                                : Alignment.centerLeft,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Column(
                                children: [
                                  messages[index].get('file') == null
                                      ? SizedBox.shrink()
                                      : messages[index].get('isImage') == true
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            AlertDialog(
                                                          content: Stack(
                                                            children: [
                                                              Image.network(
                                                                  messages[
                                                                          index]
                                                                      .get(
                                                                          'file')),
                                                              Positioned(
                                                                  top: 0,
                                                                  right: 0,
                                                                  child:
                                                                      GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              const Icon(
                                                                            Icons.close_rounded,
                                                                            color:
                                                                                Colors.red,
                                                                          )))
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Image.network(
                                                      messages[index]
                                                          .get('file'),
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.fill,
                                                    )),
                                                Text(getTime(messages[index]
                                                    .get('time')))
                                              ],
                                            )
                                          : Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    final Uri _url =
                                                        Uri.parse(messages[index]
                                                          .get('file'));

                                                          

                                                    if (!await launchUrl(
                                                        _url,
                                                         mode: LaunchMode.externalNonBrowserApplication,
                                                         
                                                         
                                                        )) {
                                                      throw Exception(
                                                          'Could not launch $_url');
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[100],
                                                        border: Border.all()),
                                                    child: const Row(
                                                      children: [
                                                        Icon(Icons
                                                            .text_snippet_outlined),
                                                        Text('file')
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Text(getTime(messages[index]
                                                    .get('time')))
                                              ],
                                            ),
                                  messages[index].get('messageText') == null
                                      ? const SizedBox.shrink()
                                      : ListTile(
                                          title: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 14),
                                            decoration: BoxDecoration(
                                              color:
                                                  senderId == currentUser?.uid
                                                      ? Colors.green[900]
                                                      : Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              messages[index]
                                                  .get('messageText'),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          subtitle: Text(getTime(
                                              messages[index].get('time'))),
                                        ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    
                    },
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Enter a message...',
                    ),
                  ),
                ),
               IconButton(
                        icon: const Icon(Icons.attachment_outlined),
                        onPressed: () async {
                          setState(() {
                            isloading = true;
                          });

                          file = await uploadFile();

                          final isImage = checkImageUrl(file!);

                          await _sendMessage(file: file, isImage: isImage);

                          setState(() {
                            isloading = false;
                          });
                        },
                      ),
                IconButton(
                        icon: const Icon(Icons.camera_alt),
                        onPressed: () async {
                          setState(() {
                            isloading = true;
                          });

                          file = await _getFromCamera();

                          

                          final isImage = true;

                          await _sendMessage(file: file, isImage: isImage);

                          setState(() {
                            isloading = false;
                          });
                        },
                      ),
                
                
                
                 isloading
                    ? const CircularProgressIndicator()
                    : IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    _messageController.text.isEmpty
                        ? ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Add message')))
                        : _sendMessage(
                            messageText: _messageController.text.trim(),
                          );
                  },
                ),
              ],
            ),
          ),
        
        
        ],
      ),
    );
  }

  Future<String> _getFromCamera() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera,imageQuality: 30);

    if (file != null) {
      
        imageFile = File(file.path);
          Reference storageReference = FirebaseStorage.instance.ref().child('images');

      UploadTask uploadTask = storageReference.putFile(imageFile!);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    }else{
      return '';
    }




    
  }
}
