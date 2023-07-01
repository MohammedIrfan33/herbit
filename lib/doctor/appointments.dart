import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../public_user/homepage.dart';
import 'chatbot_doctor.dart';

class Appointments extends StatefulWidget {
  const Appointments({Key? key}) : super(key: key);

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  final CollectionReference bookings =
      FirebaseFirestore.instance.collection('bookings');

  String? docId;

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    docId = _auth.currentUser?.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[900],
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const homepage(),
                      ));
                },
                icon: const Icon(Icons.home))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('bookings')
                .where('status', isEqualTo: 'accepted')
                .where('doctor', isEqualTo: docId)
                .where('ishide', isEqualTo: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final appointments = snapshot.data!.docs;
                return appointments.isEmpty
                    ? const Center(child: Text('No appointments'))
                    : ListView.builder(
                        itemCount: appointments.length,
                        itemBuilder: (context, index) {
                          final appointment = appointments[index].data()
                              as Map<String, dynamic>;
                          final patientName = appointment['name'];
                          final doctorName = appointment['doctor'];
                          final patientId = appointment['patientId'];
                          final ddate = appointment['date'];
                          final dtime = appointment['time'];
                          return Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "name:" + patientName,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "date:" + ddate,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "time:" + dtime,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                              onPressed: () async {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DocChatScreen(
                                                        patientId: patientId,
                                                      ),
                                                    ));

                                                await bookings
                                                    .doc(appointments[index].id)
                                                    .update({'ishide': true});
                                              },
                                              child: const Text('chat now')),
                                          const Icon(Icons.arrow_right_alt)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );

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
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ));
  }
}
