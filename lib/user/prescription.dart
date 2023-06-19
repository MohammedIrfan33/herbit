import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'doctor.dart';
import 'home_user.dart';
import '../public_user/homepage.dart';

class prescription extends StatefulWidget {
  final String sym;


  prescription(this.sym);

  @override
  State<prescription> createState() => _prescriptionState();
}

class _prescriptionState extends State<prescription> {
  String userId='';
  User? user;
  String age='';
  String name='';
  String description='';
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  void fetchUserData() {
    user = FirebaseAuth.instance.currentUser;
    userId = user!.uid;
    FirebaseFirestore.instance.collection('user_Tb').doc(userId).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        setState(() {
          name = data['fullname'] as String;
          age = data['age'] as String;
          print("name$name");
          print(age);
        });


      } else {
        print('User document does not exist');
      }
    }).catchError((error) {
      print('Failed to fetch user data: $error');
    });
  }
  List<Map<String, dynamic>> allData = [];
  List<Map<String, dynamic>> filteredData = [];

  String datas='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserData();
    datas=widget.sym;
    fetchData();
  }

  Future<void> fetchData() async {
    // Retrieve data from Firebase collection
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('symptom').get();

    // Store retrieved data in allData variable
    allData = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

    // Apply filter to the data (e.g., filter by a specific field)
    filteredData = allData.where((data) => data['symptom'] == widget.sym).toList();
    print("medicine$filteredData");

    // Refresh the UI
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        actions: [
          IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homeuser(),));
          }, icon: Icon(Icons.home))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'Date:${formattedDate}',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Row(
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ':',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      name.toUpperCase(),
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    'Age',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 22,
                  ),
                  Text(
                    ':',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    age,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Symptoms',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '* '+widget.sym.toUpperCase(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            /*  Text(
                '* headache',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              Text(
                '* vomiting',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),*/
              SizedBox(
                height: 30,
              ),
              Text(
                'Medicines',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
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
                              style: TextStyle(fontSize:20,color: Colors.black),
                            );
                          }).toList(),
                        ),
                      ) /*Text(filteredData[index]['medicine'].toUpperCase())*/
                  );
                  },
              ),
              SizedBox(height: 100,),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 70),
                height: 60,
                color: Colors.green[900],
                child: TextButton(
                  child: Text('Consulting',style: TextStyle(color: Colors.white,fontSize: 25),),
                  onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => doctor(),));
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
