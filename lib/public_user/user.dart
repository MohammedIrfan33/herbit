import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:herbit/public_user/disease.dart';

class user extends StatefulWidget {
  const user({Key? key}) : super(key: key);

  @override
  State<user> createState() => _userState();
}

class _userState extends State<user> {
  String? dropdownvalue ;
  TextEditingController symptomControler=TextEditingController();

  // List of items in our dropdown menu
  var items = [
    'Malayalam',
    'English',
  ];
  List<String> options = []; // List to store dropdown options
  String selectedOption = ''; // Currently selected option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: const Text(
          "Users",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(19),
              child:StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('symptom').snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      }

      List<String> data = snapshot.data!.docs.map((
          doc) => doc['symptom'] as String).toList();

      return DropdownButtonFormField(
        decoration: const InputDecoration(
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
        hint: const Text(
          'Select Symptoms',
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
            DropdownMenuItem(value: value, child: Text(value)))
            .toList(),
      );
    }
            ),),
            Padding(
              padding: const EdgeInsets.all(19),
              child: TextField(
                controller: symptomControler,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Retype your symptoms",
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 70,
              height: 40,
              color: Colors.green[900],
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => disease(symptomControler.text.trim()),));
                },
                child: const Text(
                  'Submit ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
