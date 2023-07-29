

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:herbit/utils/notifications.dart';

import 'package:intl/intl.dart';

import 'home_user.dart';

class doctor extends StatefulWidget {
   doctor({Key? key,  this.userName}) : super(key: key);

   String  ? userName;

  @override
  State<doctor> createState() => _doctorState();
}

class _doctorState extends State<doctor> {
  TextEditingController datecontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();

  List<String> options = []; // List to store dropdown options
  String selectedOption = ''; // Currently selected option
  DateTime selectedDate = DateTime.now();
   String ? startDate;
  String? dropdownvalue;

  String? specialication;
  QueryDocumentSnapshot<Object>? selcteddoctor;

  List<String> spList = [
  'Vata',
  'Pitta',
  'Kapha',
  'Digestive System',
  'Respiratory System',
  'Joint and Musculoskeletal System',
  'Skin and Hair Care',
  "Women's Health",
  'Stress and Anxiety',
  'Detoxification',
];

  var docList = [];

  bool isLoading = false;

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

  getDoctorList(String specialication) async {
    final data = FirebaseFirestore.instance
        .collection('doctor')
        .where('specialisation', isEqualTo: specialication);

    await data.get().then((QuerySnapshot querySnapshot) {
      docList = querySnapshot.docs;
      
    });

    if(docList.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Doctor Not found')));
    }

    setState(() {});
  }

  @override
  void initState() {
    datecontroller.text = "";

    namecontroller.text = widget.userName ?? '';
    super.initState();
  }

  String? selectedTime;

  /* Future<void> displayTimeDialog() async {
    final TimeOfDay? time =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null) {
      setState(() {
        selectedTime = time.format(context);
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    TextEditingController timecontroller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking'),
        backgroundColor: Colors.green[900],
        actions: [
           IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Homeuser(),
                    ));
              },
              icon: const Icon(Icons.home))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: specialication,
                  hint: const Text('Specialisation'),
                  elevation: 0,
                  underline: const SizedBox(),
                  dropdownColor: Colors.grey[200],

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: spList.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) async {
                    specialication = newValue!;
                    getDoctorList(specialication!);
                  },
                ),
              ),
              const SizedBox(height: 25),
              if (docList.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: DropdownButton(
                    isExpanded: true,
                    value: selcteddoctor,
                    hint: const Text('Select Doctor'),
                    elevation: 0,
                    underline: const SizedBox(),
                    dropdownColor: Colors.grey[200],

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: docList.map((items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items['fullname']),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (newValue) {
                      setState(() {
                        selcteddoctor =
                            newValue! as QueryDocumentSnapshot<Object>?;
                      });
                    },
                  ),
                ),
              const SizedBox(height: 25),
              TextField(
                enabled: widget.userName == null ?  true : false,
                controller: namecontroller,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(),
                  disabledBorder: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0)),
                  hintText: 'name',
                  suffixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 25),
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
                        child: const Text('Consulting date'),
                      ),
                    ),
                  ),
                ],
              ),

              /*  TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "consulting time",
                ),
              ),*/

              /* Text(
                selectedTime != null
                    ? '$selectedTime'
                    : 'Click Below Button To Select Time...',
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              Container(
                margin: const EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: const EdgeInsets.all(7),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  child: const Text('Show Time ',style: TextStyle(color: Colors.black),),
                  onPressed: displayTimeDialog,
                ),
              ),*/
              const SizedBox(height: 25),
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
              
              
              const SizedBox(height: 60),
              Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.green[900],
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                  child: isLoading ?const CircularProgressIndicator() :const Text(
                    'Book now',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  onPressed: () async {
                    if (timecontroller.text.isEmpty ||
                        selcteddoctor?.id == '' ||
                        namecontroller.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Some fields are empty')));
                    } else {
                      setState(() {
                        isLoading = true;
                      });

                      
                      final userId = FirebaseAuth.instance.currentUser!;
                      final deviceToken =await FirebaseMessaging.instance.getToken();
                      await FirebaseFirestore.instance
                          .collection("bookings")
                          .add({
                        "date": startDate?? '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                        "time": timecontroller.text,
                        "doctor": selcteddoctor?.id,
                        "patientId": userId.uid,
                        "name": namecontroller.text,
                        "isAccepted" : false,
                        "fcm" : deviceToken,
                        "ishide" : false,
                      }).then((value) async{

                        final docToken = await FirebaseNotificatios().getDoctorToken(selcteddoctor!.id);

                        await FirebaseNotificatios().sendNotification(
                          deviceToken: docToken,
                          body: 'New Booking',
                          title: 'Booking'
                        );

                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Homeuser(),));

                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Booking completed')));
                      }).catchError((error) =>
                              print("failed to add new booking $error")
                              );

                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
