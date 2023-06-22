import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'doctor.dart';
import 'home_user.dart';

class prescription extends StatefulWidget {
  final String sym;
  final List<String> selectedSymptomList;

  const prescription({
    required this.sym,
    required this.selectedSymptomList,
  });

  @override
  State<prescription> createState() => _prescriptionState();
}

class _prescriptionState extends State<prescription> {
  String userId = '';
  User? user;
  String age = '';
  String name = '';
  String description = '';
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  void fetchUserData() {
    user = FirebaseAuth.instance.currentUser;
    userId = user!.uid;
    FirebaseFirestore.instance
        .collection('user_Tb')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        name = data['fullname'] as String;
        age = data['age'] as String;
      } else {
        print('User document does not exist');
      }
    }).catchError((error) {
      print('Failed to fetch user data: $error');
    });
  }

  List<Map<String, dynamic>> allData = [];
  List<Map<String, dynamic>> filteredData = [];

  String datas = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserData();
    datas = widget.sym;

    getAgeWithMedicine(widget.selectedSymptomList);
    fetchData();
  }

  Future<void> fetchData() async {
    // Retrieve data from Firebase collection
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('symptom').get();

    // Store retrieved data in allData variable
    allData =
        snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

    // Apply filter to the data (e.g., filter by a specific field)
    filteredData =
        allData.where((data) => data['symptom'] == widget.sym).toList();
    print("medicine$filteredData");

    // Refresh the UI
    setState(() {});
  }

  List? treatmentList;

  getAgeWithMedicine(List<String> selectedSymptomList) async {
    final data = FirebaseFirestore.instance.collection('symptom');

    await data.get().then((QuerySnapshot querySnapshot) {
      var allData = querySnapshot.docs
          .where((element) {
            var symptom = element.get('symptom');
            return selectedSymptomList
                .any((selectedSymptom) => symptom == selectedSymptom);
          })
          .map((docSnapshot) => docSnapshot.data())
          .toList();
     
    });



    List<Map<String, dynamc>> filteredData = allData.where((item) {
  if (item.containsKey('treatment')) {
    List<Map<String, dynamic>> treatments =
        List<Map<String, dynamic>>.from(item['treatment']);
    treatments = treatments.where((treatment) => treatment['age'] == age).toList();
    if (treatments.isNotEmpty) {
      item['treatment'] = treatments;
      return true;
    }
  }
  return false;
}).toList();


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
                      builder: (context) => const Homeuser(),
                    ));
              },
              icon: const Icon(Icons.home))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'Date:$formattedDate',
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Row(
                  children: [
                    const Text(
                      'Name',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      ':',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      name.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Text(
                    'Age',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 22,
                  ),
                  const Text(
                    ':',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    age,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Symptoms',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '* ${widget.sym.toUpperCase()}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              /*  Text(
                '* headache',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              Text(
                '* vomiting',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),*/
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Medicines',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  // Display the filtered data
                  String textWithComma = filteredData[index]['medicine'];
                  List<String> textParts = textWithComma.split(',');

                  return ListTile(
                      title: RichText(
                    text: TextSpan(
                      children: textParts.map((text) {
                        return TextSpan(
                          text: text.trim(),
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                        );
                      }).toList(),
                    ),
                  ) /*Text(filteredData[index]['medicine'].toUpperCase())*/
                      );
                },
              ),
              const SizedBox(
                height: 100,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 70),
                height: 60,
                color: Colors.green[900],
                child: TextButton(
                  child: const Text(
                    'Consulting',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const doctor(),
                        ));
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
