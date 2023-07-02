import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:herbit/public_user/disease.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class user extends StatefulWidget {
  const user({Key? key}) : super(key: key);

  @override
  State<user> createState() => _userState();
}

class _userState extends State<user> {
  String? dropdownvalue;
  TextEditingController symptomControler = TextEditingController();

  // List of items in our dropdown menu
  var items = [
    'Malayalam',
    'English',
  ];
  List<String> options = []; // List to store dropdown options
  String selectedOption = ''; // Currently selected option

  List<String> symptomsList = [];
  List<String> selectedItems = [];
  getSymptomsData() async {
    final data = FirebaseFirestore.instance.collection('symptom');

    await data.get().then((QuerySnapshot querySnapshot) {
      for (var symptom in querySnapshot.docs) {
        symptomsList.add(symptom.get('symptoms'));
      }
    });
    setState(() {});
  }


   @override
  void initState() {
    // TODO: implement initState
     getSymptomsData();

     

     
    super.initState();
  }

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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MultiSelectDialogField(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()
                ),
                items: symptomsList.map((e) => MultiSelectItem(e, e)).toList(),
                listType: MultiSelectListType.LIST,
                onConfirm: (values) {
                  selectedItems =  values;
            
                },
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            disease(selectedItems: selectedItems,),
                      ));
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
