
import 'package:flutter/material.dart';
import 'package:herbit/doctor/appointments.dart';
import 'package:herbit/doctor/communication.dart';
import 'package:herbit/doctor/profile_doctor.dart';

import 'chatbot_doctor.dart';
class home_doctor extends StatefulWidget {
  const home_doctor({Key? key}) : super(key: key);

  @override
  State<home_doctor> createState() => _home_doctorState();
}

class _home_doctorState extends State<home_doctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("home doctor"),
        backgroundColor: Colors.teal[900],),
      body: Padding(
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
                      MaterialPageRoute(builder: (context) => const chatbot_doctor()));
                },
                child: Container(
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
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const profile_doctor()));
                },
                child: Container(
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        Image.asset(
                          'images/profiledoctor.jpeg',
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
                            'profile doctor',
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
                      MaterialPageRoute(builder: (context) => const communication()));
                },
                child: Container(
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        Image.asset(
                          'images/patient.jpeg',
                          height: 115,
                          width: 140,
                          fit: BoxFit.cover,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10,top: 3),
                          child: Text(
                            'patients',
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
                      MaterialPageRoute(builder: (context) =>  const Appointments()));
                },
                child: Container(
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        Image.asset(
                          'images/appoinments.jpeg',
                          height: 110,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(
                            'Appoinments',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}