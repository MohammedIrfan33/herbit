import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';





class viewdoctor extends StatefulWidget {
  const viewdoctor({Key? key}) : super(key: key);

  @override
  State<viewdoctor> createState() => _viewdoctorState();
}

class _viewdoctorState extends State<viewdoctor> {


/*  List name=["shibila","binsida","silu"];

  List email=["sh@gmail.com","rabbi@gmail.com","silu@gmail.com"];

  List qualification=["MBBS","MBBS,MD","MBBS"];*/
  final CollectionReference doctor = FirebaseFirestore.instance
      .collection('doctor');
  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(
  backgroundColor: Colors.green[900],
  title: const Text('Doctors'),
  ),
  body: Padding(
  padding: const EdgeInsets.all(8.0),
  child:StreamBuilder(
    stream: doctor.snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>streamSnapshot) {
      if(streamSnapshot.hasData) {
        return ListView.builder(
          itemCount: streamSnapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final DocumentSnapshot documentSnapshot=streamSnapshot.data!.docs[index];
            
            return  documentSnapshot['isAccepted'] ==  true ?Column(
              children: [
                Container(height: 120,
                  margin: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text("name:" +documentSnapshot['fullname'], style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold),),
                        Text("phone:" +documentSnapshot['phone'], style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold),),
                        Text("qualification:" + documentSnapshot['qualification'], style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold),),

                        const SizedBox(height: 10,),

                      ],),
                  ),
                ),
              ],) : const SizedBox.shrink();
          },);
      }return const Center(
        child: CircularProgressIndicator(),
      );
    },
  ),
  )
  );
  }
  }



