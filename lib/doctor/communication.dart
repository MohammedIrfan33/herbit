import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herbit/utils/notifications.dart';
import 'package:intl/intl.dart';

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

  TextEditingController timecontroller = TextEditingController();

  String? docId;

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    docId = _auth.currentUser?.uid;
  }

  DateTime selectedDate = DateTime.now();
  String? startDate;
  String? deviceToken;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        startDate =
            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
      });
    }
  }

  void acceptAppointment(String appointmentId, String deviceToken) async {
    FirebaseFirestore.instance
        .collection('bookings')
        .doc(appointmentId)
        .update({
      'isAccepted': true,
      'status': 'accepted',
    });

    FirebaseNotificatios().sendNotification(
      deviceToken: deviceToken,
      body: 'Booking Accepted doctor!!!',
      title: 'Accepted',
    );
  }

// Function to reject an appointment
  void rejectAppointment(String appointmentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: const Text('Select Time'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: timecontroller,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0)),
                  hintText: 'consulting Time',
                  suffixIcon: const Icon(Icons.timer),
                ),
                readOnly: true,
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  if (pickedTime != null) {
                    DateTime parsedTime = DateFormat.jm()
                        .parse(pickedTime.format(context).toString());

                    String formattedTime =
                        DateFormat('HH:mm:ss').format(parsedTime);
                    timecontroller.text = formattedTime;
                  } else {
                    print("Time is not selected");
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26)),
                      child: Center(
                        child: Text(
                          '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black38),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[900]),
                        onPressed: () => _selectDate(context),
                        child: const Text('select'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[900],
                    minimumSize: const Size.fromHeight(50)),
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('bookings')
                      .doc(appointmentId)
                      .update({
                    'isAccepted': true,
                    'status': 'Accepted',
                    'time': timecontroller.text,
                    'date': startDate
                  });

                  

                await  FirebaseNotificatios().sendNotification(
                    deviceToken: deviceToken,
                    body: 'Booking time changed!!!',
                    title: 'Changed!!!',
                  );

                Navigator.pop(context);
                },
                child: const Text('Submit'),
              )
            ],
          )),
    );
  }

  final CollectionReference bookings =
      FirebaseFirestore.instance.collection('bookings');
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
                  .where('isAccepted', isEqualTo: false)
                  .where('doctor', isEqualTo: docId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final appointments = snapshot.data!.docs;

                  return appointments.isEmpty
                      ? const Center(
                          child: Text('No bookings'),
                        )
                      : ListView.builder(
                          itemCount: appointments.length,
                          itemBuilder: (context, index) {
                            final appointment = appointments[index].data()
                                as Map<String, dynamic>;
                            final appointmentId = appointments[index].id;
                            final patientName = appointment['name'];
                            final patientDate = appointment['date'];
                            final patientTime = appointment['time'];
                            deviceToken = appointment['fcm'];

                            final status = appointment['status'];

                            return Column(
                              children: [
                                Container(
                                  height: 120,
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
                                          "date:" + patientDate,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "time:" + patientTime,
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
                                            Container(
                                              width: 90,
                                              height: 40,
                                              color: Colors.green[900],
                                              child: TextButton(
                                                onPressed: () {
                                                  acceptAppointment(
                                                      appointmentId,
                                                      deviceToken!);
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
                            );
                          },
                        );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const CircularProgressIndicator();
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
            ));
  }
}
