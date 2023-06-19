import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:herbit/firebase/authentication.dart';
import 'package:herbit/user/home_user.dart';
import 'package:intl/intl.dart';

import '../doctor/communication.dart';

class doctor extends StatefulWidget {
  const doctor({Key? key}) : super(key: key);

  @override
  State<doctor> createState() => _doctorState();
}

class _doctorState extends State<doctor> {


  List<String> options = []; // List to store dropdown options
  String selectedOption = ''; // Currently selected option

  DateTime selectedDate = DateTime.now();

  late String startDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        startDate='${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
        print(startDate);
      });
    }
  }
  String? dropdownvalue;

  var items = [
    'doctor 1',
    'doctor 2',
    'doctor 3',
    'doctor 4',
    'doctor 5',
  ];
  TextEditingController datecontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  @override
  void initState() {
    datecontroller.text = "";
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
    TextEditingController timecontroller =TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('booking'),
        backgroundColor: Colors.green[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(

          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(19),
                    child:StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('doctor').snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          List<Map<String, dynamic>> data = snapshot.data!.docs.map((doc) {
                            return {
                              'id': doc.id,
                              'qualification': doc['qualification'] as String,
                            };
                          }).toList();
                        /*  List<String> data = snapshot.data!.docs.map((
                              doc) =>  doc['qualification'] as String).toList();
*/
                          return DropdownButtonFormField(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.zero),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ))),
                            hint: Text(
                              'Specialisation',
                              style: TextStyle(color: Colors.black),
                            ),
                            value: dropdownvalue,
                            onChanged: (vale) {
                              setState(() {
                                dropdownvalue = vale.toString();
                              });
                            },
                            items: data
                                .map((value) =>
                                DropdownMenuItem(value: value, child: Text(value as String)))
                                .toList(),
                          );
                        }
                    ),),
                ],
              ),
              SizedBox(
                height: 60,
              ),
      TextField(
          controller: namecontroller,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(),
            focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
            hintText: 'name',
            suffixIcon: Icon(Icons.person),
          ),),
              SizedBox(
                height: 60,
              ),
              Row(

                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      height: 45,
                      width:150 ,
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text('${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black38
                          ),),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Consulting date'),
                  ),
                ],
              ),
              SizedBox(
                height: 60,
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
              TextField(
                controller: timecontroller,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
                  hintText: 'consulting Time',
                  suffixIcon: Icon(Icons.timer),
                ),
                readOnly: true,
                onTap:  () async {
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
              SizedBox(
                height: 80,
              ),
              Container(

                height: 50,
                width: 150,
                color: Colors.green[900],
                child: TextButton(
                  child: Text(
                    'Book now',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  onPressed: () {
                    FirebaseFirestore.instance.collection("bookings").add({
                      "date": startDate,
                      "time": timecontroller.text,
                      "doctor":dropdownvalue.toString(),
                      "name":namecontroller.text,
                    }).then((value) {
                      print(value.id);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Homeuser()));
                    }).catchError(
                            (error)=> print("failed to add new booking $error")
                    );
                  },
                ),),  ],
                ),
        ),
            ),

      );
  }
}
