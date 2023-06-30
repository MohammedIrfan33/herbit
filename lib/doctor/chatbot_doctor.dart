import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/getTime.dart';

class DocChatScreen extends StatefulWidget {
   DocChatScreen({super.key,this.patientId});

  String ? patientId;

  @override
  _DocChatScreenState createState() => _DocChatScreenState();
}

class _DocChatScreenState extends State<DocChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<QuerySnapshot>? _messageStream;

  //QueryDocumentSnapshot<Object>? selctedUser;

  String? specialication;
  bool loading = false;

  // var usersChatList = [];

  User? currentUser;

  @override
  void initState() {
    currentUser = _auth.currentUser;

    _messageStream = _firestore
                            .collection('chats')
                            .where('doctorId', isEqualTo: currentUser?.uid)
                            .where('patientId', isEqualTo: widget.patientId)
                            .snapshots();

    

   // getChatList();


    super.initState();
  }

  Future<void> _sendMessage() async {
    final String messageText = _messageController.text.trim();
    if (messageText.isEmpty) return;

    if (currentUser == null) return;

    // if (selctedUser != null) {
      await _firestore.collection('chats').add({
        'doctorId': currentUser?.uid,
        'patientId': widget.patientId,
        'senderId': currentUser?.uid,
        'messageText': messageText,
        'time': DateTime.now().millisecondsSinceEpoch,
      });
    // } else {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(const SnackBar(content: Text('Select doctor')));
    // }

    _messageController.clear();
  }

  // getChatList() async {
  //   try {
  //     setState(() {
  //       loading = true;
  //     });

  //     var userIdList;

  //     final data = FirebaseFirestore.instance
  //         .collection('chats')
  //         .where('doctorId', isEqualTo: currentUser?.uid);

  //     final usersDatalist = FirebaseFirestore.instance.collection('user_Tb');

  //     await data.get().then((QuerySnapshot querySnapshot) async {
  //       userIdList = querySnapshot.docs.map((e) => e['patientId']);

  //       await usersDatalist
  //           .where(FieldPath.documentId, whereIn: userIdList)
  //           .get()
  //           .then((QuerySnapshot querySnapshot) =>
  //               usersChatList = querySnapshot.docs);
  //     });

  //     setState(() {
  //       loading = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       loading = false;
  //     });

  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('Somthing went wrong')));
  //   }
  // }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        backgroundColor: Colors.green[900],
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 10),
                //   margin: const EdgeInsets.symmetric(horizontal: 10),
                //   height: 50,
                //   decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                //   child: DropdownButton<String>(
                //     isExpanded: true,
                //     value: specialication,
                //     hint: const Text('Specialisation'),
                //     elevation: 0,
                //     underline: const SizedBox(),
                //     dropdownColor: Colors.grey[200],

                //     // Down Arrow Icon
                //     icon: const Icon(Icons.keyboard_arrow_down),

                //     // Array list of items
                //     items: spList.map((String items) {
                //       return DropdownMenuItem(
                //         value: items,
                //         child: Text(items),
                //       );
                //     }).toList(),
                //     // After selecting the desired option,it will
                //     // change button value to selected value
                //     onChanged: (String? newValue) async {
                //       specialication = newValue!;
                //       getDoctorList(specialication!);
                //     },
                //   ),
                // ),
                // const SizedBox(height: 25),
                // if (docList.isNotEmpty)
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 10),
                //   margin: const EdgeInsets.symmetric(horizontal: 10),
                //   height: 50,
                //   decoration:
                //       BoxDecoration(border: Border.all(color: Colors.black)),
                //   child: DropdownButton(
                //     isExpanded: true,
                //     value: selctedUser,
                //     hint: const Text('Select patient'),
                //     elevation: 0,
                //     underline: const SizedBox(),
                //     dropdownColor: Colors.grey[200],

                //     // Down Arrow Icon
                //     icon: const Icon(Icons.keyboard_arrow_down),

                //     // Array list of items
                //     items: usersChatList.map((items) {
                //       return DropdownMenuItem(
                //         value: items,
                //         child: Text(items['fullname']),
                //       );
                //     }).toList(),
                //     // After selecting the desired option,it will
                //     // change button value to selected value
                //     onChanged: (newValue) {
                      
                //       setState(() {
                //         selctedUser = newValue! as QueryDocumentSnapshot<Object>?;

                       

                //         _messageStream = _firestore
                //             .collection('chats')
                //             .where('doctorId', isEqualTo: currentUser?.uid)
                //             .where('patientId', isEqualTo: selctedUser?.id)
                //             .snapshots();
                //       });
                //     },
                //   ),
                // ),
                
              //  selctedUser == null
                    // ? const Expanded(
                    //     child: Center(
                    //     child: Text('Select the patients'),
                    //   ))
                    // : 
                    Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: _messageStream,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            final messages = snapshot.data!.docs;

                            return ListView.builder(
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
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    child: ListTile(
                                      title: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 14),
                                        decoration: BoxDecoration(
                                          color: senderId == currentUser?.uid
                                              ? Colors.green[900]
                                              : Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          messages[index].get('messageText'),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      subtitle: Text(
                                          getTime(messages[index].get('time'))),
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
                        icon: Icon(Icons.send),
                        onPressed: _sendMessage,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
