
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:herbit/user/chat_list.dart';
import 'package:herbit/user/user_chat.dart';
import 'package:herbit/login.dart';
import 'package:herbit/user/chat.dart';
import 'package:herbit/user/chatbot.dart';
import 'package:herbit/user/profile_user.dart';

import '../firebase/authentication.dart';
import '../public_user/homepage.dart';
import 'doctor.dart';
class Homeuser extends StatefulWidget {
  const Homeuser({Key? key}) : super(key: key);

  @override
  State<Homeuser> createState() => _HomeuserState();
}

class _HomeuserState extends State<Homeuser> {

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("home"),
        backgroundColor: Colors.teal[900],
        actions: [
          IconButton(onPressed: () async{
            const number = '123456789'; //set the number here
          bool? res = await FlutterPhoneDirectCaller.callNumber(number);
            
          }, icon:const  Icon(Icons.phone))
        ],
        ),
      body:loading ?const  Center(child: CircularProgressIndicator(),) : Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 8,
            shrinkWrap: true,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const chat()));
                },
                child: Card(
                  elevation: 10,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Image.asset(
                          'images/png-transparent-computer-icons-online-chat-livechat-chat-miscellaneous-angle-text-thumbnail.png',
                          height: 80,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: Text(
                          'chat',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const ChatListScreen()));
                },
                child: Card(
                  elevation: 10,
                  child: Column(
                    children: [
                      Image.asset(
                        'images/png-transparent-medical-service-online-chat-smartphone-doctor-consultant.png',
                        height: 120,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(),
                        child: Text(
                          'chatbot',style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),),),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const profile_user()));
                },
                child: Container(
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        Image.asset(
                          'images/iuser.png',
                          height: 110,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(
                            'profile user',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  doctor()));
                },
                child: Container(
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        Image.asset(
                          'images/consulting.png',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10,top: 3),
                          child: Text(
                            'consulting',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async{
                  setState(() {
                    loading = true;
                  });
                 await AuthenticationHelper().signOut();
                 setState(() {
                    loading = false;
                  });
                 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => homepage(),), (route) => false);
                
                },
                child: Card(
                  elevation: 10,
                  child: Column(
                    children: [
                      Image.asset(
                        'images/logout.jpg',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10,top: 3),
                        child: Text(
                          'Logout',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            
            ]),
      ),
    );
  }
}