import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:herbit/admin/home_admin.dart';

import '../utils/notifications.dart';

class pending_doctor extends StatefulWidget {
  const pending_doctor({Key? key}) : super(key: key);

  @override
  State<pending_doctor> createState() => _pending_doctorState();
}

class _pending_doctorState extends State<pending_doctor> {
  final notification = FirebaseNotificatios();

  void acceptAppointment(String appointmentId) async {
    await FirebaseFirestore.instance
        .collection('doctor')
        .doc(appointmentId)
        .update({
      'isAccepted': true,
      'status': 'accepted',
    });
    await FirebaseFirestore.instance
        .collection('login')
        .doc(appointmentId)
        .update({
      'isAccepted': true,
      'status': 'accepted',
    });

    final token = await notification.getDoctorToken(appointmentId);

    await notification.sendNotification(
        deviceToken: token, body: 'Admin Accepted!!!', title: 'Accepted');
  }

// Function to reject an appointment
  void rejectAppointment(String appointmentId) async {
    await FirebaseFirestore.instance
        .collection('doctor')
        .doc(appointmentId)
        .delete();
    await FirebaseFirestore.instance
        .collection('login')
        .doc(appointmentId)
        .delete();
    final token = await notification.getDoctorToken(appointmentId);

    await notification.sendNotification(
        deviceToken: token, body: 'Admin Rejected!!!', title: 'Rejected');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal[900],
          title: const Text("Doctor Manage"),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          )),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const home_admin(),
                      ));
                },
                icon: const Icon(Icons.home))
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('doctor')
                  .where('isAccepted', isEqualTo: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final appointments = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: appointments.length,
                    itemBuilder: (context, index) {
                      final appointment =
                          appointments[index].data() as Map<String, dynamic>;
                      final appointmentId = appointments[index].id;
                      final patientName = appointment['fullname'];
                      final patientPhone = appointment['phone'];
                      final isAccepted = appointment['isAccepted'];
                      final isRejected = appointment['isRejected'];
                      final status = appointment['status'];
                      final viewCertificate = appointment['image'];

                      return isAccepted == false
                          ? Container(
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Name:" + patientName,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Phone:" + patientPhone,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),

                                          Wrap(
                                            spacing: 2,
                                            children: viewCertificate.map<Widget>((e)=>
                                            GestureDetector(
                                              onTap: () {
                                                 showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          Image.network(
                                                              e,
                                                              height: 100),
                                                    );
                                              },
                                              child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                8.0),
                                                        child: Image.network(
                                                          e,
                                                          width: 100,
                                                          height: 100,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                            )
                                            
                                            ).toList(),
                                          )
                                          
                                         ,
                                         
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 90,
                                                height: 40,
                                                color: Colors.green[900],
                                                child: TextButton(
                                                  onPressed: () {
                                                    acceptAppointment(
                                                        appointmentId);
                                                  },
                                                  child: Text(
                                                    status == 'accepted'
                                                        ? 'Accepted'
                                                        : 'Accept',
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                width: 90,
                                                height: 40,
                                                color: Colors.green[900],
                                                child: TextButton(
                                                  onPressed: () {
                                                    rejectAppointment(
                                                        appointmentId);
                                                  },
                                                  child: Text(
                                                    status == 'rejected'
                                                        ? 'Rejected'
                                                        : 'Reject ',
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              
                                              
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink();
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )));
  }
}



/*
import 'package:flutter/material.dart';
import 'package:herbit/admin/doctor_details.dart';

import 'details_user.dart';
class pending_doctor extends StatefulWidget {
  const pending_doctor({Key? key}) : super(key: key);

  @override
  State<pending_doctor> createState() => _pending_doctorState();
}

class _pending_doctorState extends State<pending_doctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Column(
            children: [  GestureDetector(onTap: (){ Navigator.push(
              context, MaterialPageRoute(builder:(context) => const doctor_details()),
            );},
              child: Container(
                color: Colors.green[900],
                height: 60,
                width:199,
                child: Center(child: Text('doctor 1')),

              ),),SizedBox(height: 10,),
              GestureDetector(onTap: (){ Navigator.push(
                context, MaterialPageRoute(builder:(context) => const doctor_details()),
              );},
                  child: Container(
                    color: Colors.green[900],
                    height: 60,
                    width:199,
                    child: Center(child: Text('doctor 2')),

                  )
              ),SizedBox(height: 10,),
              GestureDetector(onTap: (){ Navigator.push(
                context, MaterialPageRoute(builder:(context) => const doctor_details ()),
              );},
                  child: Container(
                    color: Colors.green[900],
                    height: 60,
                    width:199,
                    child: Center(child: Text('doctor 3')),

                  )
              ),  ],
          ),
        ),
      ),
    );



  }
}
*/
