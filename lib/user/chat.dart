import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:herbit/user/prescription.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class chat extends StatefulWidget {
  const chat({Key? key}) : super(key: key);

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  String? dropdownvalue;
  TextEditingController symptomControler = TextEditingController();

  // List of items in our dropdown menu
  List<String> selectedItems = [];
  List<String> options = []; // List to store dropdown options
  String selectedOption = ''; // Currently selected option

  List<String>  symptomsList = [];

  bool isLoading = false;
 
  @override
  void initState() {
    // TODO: implement initState
     getSymptomsData();
    super.initState();
  }

  getSymptomsData() async{

      

   final data =  FirebaseFirestore.instance.collection('symptom');

   await data.get().then((QuerySnapshot querySnapshot) {
      
      for (var symptom in querySnapshot.docs) {
        

        symptomsList.add(symptom.get('symptom'));

       
      }
    });
    setState(() {
      
    });

  
  
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: const Text("Chat"),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        )),
      ),
      body: symptomsList.isEmpty ? const Center(child: CircularProgressIndicator(),)  :Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MultiSelectDialogField(
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
            // Padding(
            //   padding: const EdgeInsets.all(19),
            //   child: StreamBuilder<QuerySnapshot>(
            //       stream: FirebaseFirestore.instance
            //           .collection('symptom')
            //           .snapshots(),
            //       builder: (BuildContext context,
            //           AsyncSnapshot<QuerySnapshot> snapshot) {
            //         if (snapshot.hasError) {
            //           return Text('Error: ${snapshot.error}');
            //         }
      
            //         if (snapshot.connectionState == ConnectionState.waiting) {
            //           return const CircularProgressIndicator();
            //         }
      
            //         List<String> data = snapshot.data!.docs
            //             .map((doc) => doc['symptom'] as String)
            //             .toList();
      
            //         return DropdownButtonFormField(
            //           decoration: const InputDecoration(
            //               enabledBorder: OutlineInputBorder(
            //                   borderSide: BorderSide(
            //                     color: Colors.black,
            //                   ),
            //                   borderRadius: BorderRadius.zero),
            //               focusedBorder: OutlineInputBorder(
            //                   borderRadius: BorderRadius.zero,
            //                   borderSide: BorderSide(
            //                     color: Colors.black,
            //                   ))),
            //           hint: const Text(
            //             'Select Symptoms',
            //             style: TextStyle(color: Colors.black),
            //           ),
            //           value: dropdownvalue,
            //           onChanged: (vale) {
            //             setState(() {
            //               dropdownvalue = vale.toString();
            //             });
            //           },
            //           items: data
            //               .map((value) => DropdownMenuItem(
            //                   value: value, child: Text(value)))
            //               .toList(),
            //         );
            //       }),
            // ),
            
            const SizedBox(height: 20,),
            SizedBox(
              height: 50,
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
              width: double.maxFinite,
              height: 50,
             
              decoration: BoxDecoration(
                 color: Colors.green[900],
                 borderRadius: BorderRadius.circular(10)



              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            prescription(sym: symptomControler.text.trim(),selectedSymptomList: selectedItems,),
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
