
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../public_user/homepage.dart';

class communication extends StatefulWidget {
  const communication({Key? key}) : super(key: key);

  @override
  State<communication> createState() => _communicationState();
}

class _communicationState extends State<communication> {
/*  List name=["shibila","binsida","silu"];

  List date=["17/05/2023","25/05/2023","28/05/2023"];

  List time=["2.0","3.0","6.0"];*/

  void acceptAppointment(String appointmentId) {
    FirebaseFirestore.instance
        .collection('bookings')
        .doc(appointmentId)
        .update({
      'isAccepted': true,
      'status': 'accepted',
    });
  }

// Function to reject an appointment
  void rejectAppointment(String appointmentId) {
    FirebaseFirestore.instance
        .collection('bookings')
        .doc(appointmentId)
        .update({
      'isRejected': true,
      'status': 'rejected',
    });
  }
  final CollectionReference bookings = FirebaseFirestore.instance
      .collection('bookings');
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
              stream: FirebaseFirestore.instance.collection('bookings').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final appointments = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: appointments.length,
                    itemBuilder: (context, index) {
                      final appointment = appointments[index].data() as Map<String, dynamic>;
                      final appointmentId = appointments[index].id;
                      final patientName = appointment['name'];
                      final patientDate = appointment['date'];
                      final patientTime = appointment['time'];
                      final doctorName = appointment['doctor'];
                      final isAccepted = appointment['isAccepted'];
                      final isRejected = appointment['isRejected'];
                      final status = appointment['status'];

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
                                  Text("date:" +patientDate, style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),),
                                  Text("time:" + patientTime, style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),),

                                  SizedBox(height: 10,),
                                  Row(mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:90,
                                        height: 40,
                                        color: Colors.green[900],
                                        child: TextButton(onPressed: (){acceptAppointment(appointmentId);},
                                          child: Text(status == 'accepted'?'Accepted':'Accept',style: TextStyle(color: Colors.white),),),
                                      ),
                                      SizedBox(width: 10,),
                                      Container(
                                        width: 90,
                                        height: 40,
                                        color: Colors.green[900],
                                        child: TextButton(onPressed: (){
                                          rejectAppointment(appointmentId);
                                        },
                                          child: Text(status == 'rejected'?'Rejected':'Reject ',style: TextStyle(color: Colors.white),),),
                                      ),
                                    ],
                                  ),

                                ],),
                            ),
                          ),
                        ],),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            )

          /*StreamBuilder(
              stream: bookings.snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>streamSnapshot) {
                if(streamSnapshot.hasData) {
                  return ListView.builder(
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
                                    Row(mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 70,
                                          height: 40,
                                          color: Colors.green[900],
                                          child: TextButton(onPressed: (){},
                                            child: Text('Accept',style: TextStyle(color: Colors.white),),),
                                        ),
                                        SizedBox(width: 10,),
                                        Container(
                                          width: 60,
                                          height: 40,
                                          color: Colors.green[900],
                                          child: TextButton(onPressed: (){},
                                            child: Text('Reject ',style: TextStyle(color: Colors.white),),),
                                        ),
                                      ],
                                    ),

                                  ],),
                              ),
                            ),
                          ],),
                      );
                    },);
                }return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),*/
        )
    );
  }
}
