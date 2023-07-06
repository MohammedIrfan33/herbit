import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:herbit/admin/prodcut_edit.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/notifications.dart';

class Analysis extends StatefulWidget {
  const Analysis({Key? key}) : super(key: key);

  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  final CollectionReference _product = FirebaseFirestore.instance
      .collection('product'); //refer to the table we created
  

  bool loading =false;


 final CollectionReference _products = FirebaseFirestore.instance
      .collection('notify'); 

  String imageUrl = '';
  final TextEditingController _plantController = TextEditingController();
  
 



  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
   
     showDialog(
        
        context: context,
        
        builder: (BuildContext ctx) {
          return AlertDialog(
            contentPadding:const EdgeInsets.all(20),
            title: const Center(
              child:  Text(
                'Add plant Suggestion',
                style: TextStyle(fontSize: 15),
                ),
            ),
            
            
            content: Column(
              
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

              const SizedBox(height: 10,),
               
                
                 TextField(
                  controller: _plantController,
                  decoration:const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    border: InputBorder.none,
                    hintText: "enter suggestions",
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[900],
                            elevation: 0,
                            
                            
                          ),
                          onPressed: () async {
                             Navigator.pop(context);
                              setState(() {
                                loading = true;
                              });
                            final String plantName = _plantController.text;

                            
                              
                            await _products.add({
                              "notification": plantName,
                              "isHide" : false
                            });

                            //notification to admin

                            final deviceToken = await FirebaseNotificatios().getAdminToken();

                            await FirebaseNotificatios().sendNotification(
                              deviceToken: deviceToken,
                              title: 'New Suggestion',
                              body: 'New suggestion by user'
                            );

                            _plantController.text = '';

                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successfull!!')));
                          setState(() {
                            loading =false;
                             
                          });
                          
                        
                            
                          },
                          child:const Text('submit')),
                    ),

                   const SizedBox(width: 10,),

                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[900],
                            
                          ),
                          onPressed: () async {
                              
                            Navigator.pop(context);
                          },
                          child:const Text('cancel')),
                    ),

                        
                  ],
                ),
              ],
            ),
          );
        });
  }


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
        floatingActionButton:
      Padding(
        padding: const EdgeInsets.only(left: 300),
        child: Row(
            children: [
            FloatingActionButton(
            onPressed: () {
              _create();
      },
        backgroundColor: Colors.teal[900],
        child: const Icon(Icons.add),
      ),])),
        body: loading ? Center(
          child: CircularProgressIndicator(
                    color: Colors.green[900],
                  ),
        ) : StreamBuilder(
          stream: _product.snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return GridView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0),
                itemBuilder: (BuildContext context, int index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductEdit(
                                   id : documentSnapshot.id,
                                   isPublicUser: true,
                                  )));
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
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }




}
