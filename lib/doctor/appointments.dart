import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../public_user/homepage.dart';

class Appointments extends StatefulWidget {
  const Appointments({Key? key}) : super(key: key);

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  final CollectionReference bookings = FirebaseFirestore.instance
      .collection('bookings');


 /* List name=["shibila","binsida","silu","anu","rashida"];

  List date=["17/05/2023","25/05/2023","28/05/2023","22/4/2023","29/4/2023"];

  List time=["2.0","3.0","6.0","7.0","3.0"];*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[900],
          actions: [
            IconButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homepage(),));
            }, icon: Icon(Icons.home))
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child:StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('bookings').where('status', isEqualTo: 'accepted').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final appointments = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: appointments.length,
                    itemBuilder: (context, index) {
                      final appointment = appointments[index].data() as Map<String, dynamic>;
                      final patientName = appointment['name'];
                      final doctorName = appointment['doctor'];
                      final ddate = appointment['date'];
                      final dtime = appointment['time'];
                      return Container(
                        child: Column(
                          children: [
                            Container(height: 120,
                              margin: EdgeInsets.all(10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text("name:" +patientName, style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),),
                                    Text("date:" +ddate, style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),),
                                    Text("time:" + dtime, style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),),

                                    SizedBox(height: 10,),

                                  ],),
                              ),
                            ),
                          ],),
                      );
                    },);

                  /*ListView.builder(
        itemCount: streamSnapshot.data!.docs.length,
        itemBuilder: (context, index) {
          final DocumentSnapshot documentSnapshot=streamSnapshot.data!.docs[index];
          print("snap ${documentSnapshot}");
        return Container(
          child: Column(
            children: [
              Container(height: 120,
                margin: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text("name:" +documentSnapshot['name'], style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),),
                      Text("date:" +documentSnapshot['date'], style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),),
                      Text("time:" + documentSnapshot['time'], style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),),

                      SizedBox(height: 10,),

                    ],),
                ),
              ),
            ],),
        );
      },);*/
    }return const Center(
      child: CircularProgressIndicator(),
    );
              },
            ),
        )
    );
  }
}
