import 'package:flutter/material.dart';
class chatbot_doctor extends StatefulWidget {
  const chatbot_doctor({Key? key}) : super(key: key);

  @override
  State<chatbot_doctor> createState() => _chatbot_doctorState();
}

class _chatbot_doctorState extends State<chatbot_doctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Chat bot"),
        backgroundColor: Colors.teal[900],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            )),

      ),
      body: SingleChildScrollView(
        child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [ Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,

                child:Container(

                  width: 100,
                  height:60,
                  child: TextField(
                    decoration: InputDecoration(enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                      hintText: "hi",
                    ),
                  ),
                ),
              ),
            ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.topLeft,

                  child:Container(

                    width: 100,
                    height:60,
                    child: TextField(
                      decoration: InputDecoration(enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                        hintText: "hello ! how can i help you",
                      ),
                    ),
                  ),
                ),
              ),


              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 450),
                  child: new Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        suffixIcon: Icon(Icons.send,color: Colors.teal[900],),
                        hintText: "Type here",
                      ),
                    ),
                  ),
                ),


              ),
            ]),
      ),
    );
  }
}
