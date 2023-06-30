import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herbit/user/user_chat.dart';


class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  bool loading = false;
  List<DocumentSnapshot> usersChatList = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
   User? currentUser;

  @override
  void initState() {
    currentUser = _auth.currentUser;
    super.initState();
    getChatList() ;
    
  }

  getChatList() async {
    try {
      setState(() {
        loading = true;
      });

      var userIdList;

      final data = FirebaseFirestore.instance
          .collection('chats')
          .where('patientId', isEqualTo: currentUser?.uid);



      final usersDatalist = FirebaseFirestore.instance.collection('doctor');

      

      await data.get().then((QuerySnapshot querySnapshot) async {
        userIdList = querySnapshot.docs.map((e) => e['doctorId']);

        print(userIdList);

        await usersDatalist
            .where(FieldPath.documentId, whereIn: userIdList)
            .get()
            .then((QuerySnapshot querySnapshot) =>
                usersChatList = querySnapshot.docs);
      });

      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar( SnackBar(content: Text(e.toString())));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: const Text('Chat'),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : usersChatList.isEmpty ?const Center(child: Text('No Chats'),)  :Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: ListView.separated(
              
              
                itemCount: usersChatList.length,
                itemBuilder: (context, index) {
                  final userChat = usersChatList[index];



                  


                  return ListTile(
                    onTap: () {

                       Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChatScreen(doctorId: userChat.id,)));
                      
                    },
                  
                    leading: const CircleAvatar(
                  
                      backgroundImage: AssetImage('images/imaag.png'),
                    ),
                    title: Text(userChat['fullname'])
                    ,
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.grey,
                    height: 15,
                  );
                },
              ),
          ),
    );
  }
}