import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class EditSymptomsScreen extends StatefulWidget {
  const EditSymptomsScreen({super.key, required this.name, required this.id});

  final String name;
  final String id;

  @override
  State<EditSymptomsScreen> createState() => _EditSymptomsScreenState();
}

class _EditSymptomsScreenState extends State<EditSymptomsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _desieseController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  final TextEditingController _medicineController = TextEditingController();

  List<String> medicine = [];
  List<String> desieseList = [];
  List<Map<String, dynamic>> treatmantsList = [];

  bool isAddSymptoms = false;
  bool isloading = false;


  @override
  void initState() {
    // TODO: implement initState

    _nameController.text = widget.name;
    super.initState();

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[900],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Treatmants',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        border: InputBorder.none,
                        hintText: "enter symptoms",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _desieseController,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              border: InputBorder.none,
                              hintText: "enter the desiese",
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              backgroundColor: Colors.green[900],
                            ),
                            onPressed: () async {
                              if (_nameController.text.isNotEmpty) {
                                desieseList.add(_desieseController.text);
                                _desieseController.clear();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Please Enter Symptoms')));
                              }
                            },
                            child: const Text('Add')),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Add Treatments:'),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                            controller: _ageController,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              border: InputBorder.none,
                              hintText: "enter the age",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                            controller: _dosageController,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              border: InputBorder.none,
                              hintText: "enter the dosage",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _medicineController,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    border: InputBorder.none,
                                    hintText: "enter the medicine",
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    backgroundColor: Colors.green[900],
                                  ),
                                  onPressed: (){
                                    
                                      medicine.add(_medicineController.text);
                                      _medicineController.clear();
                                   
                                  },
                                  child: const Text('Add')),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green[900],
                                  minimumSize: const Size.fromHeight(40)),
                              onPressed: () async {
                                if (medicine.isNotEmpty) {
                                  int age = int.parse(_ageController.text);

                                  treatmantsList.add({
                                    'age': age,
                                    'dosage': _dosageController.text,
                                    'medicine': List.from(medicine)
                                  });

                                  medicine.clear();
                                 

                                  _ageController.clear();
                                  _dosageController.clear();

                                

                                  
                                } else if(medicine.isEmpty){

                                  int age = int.parse(_ageController.text);

                                  treatmantsList.add({
                                    'age': age,
                                    'dosage': _dosageController.text,
                                  
                                  });

                                  medicine.clear();
                                 

                                  _ageController.clear();
                                  _dosageController.clear();


                                } else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Add medicine')));
                                }
                              },
                              child: const Text('Add Treatmant')),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                 ElevatedButton(
                          onPressed: () async {

                            setState(() {
                                isloading = true;
                              });
                            if (treatmantsList.isNotEmpty && desieseList.isNotEmpty) {
                              
                              await FirebaseFirestore.instance
                                  .collection('symptom').doc(widget.id)
                                  .update({
                                'symptoms': _nameController.text,
                                'disease':  List.from(desieseList),
                                'treatment': treatmantsList

                              });

                              desieseList.clear();

                             

                              

                              
                            }else if (treatmantsList.isNotEmpty){

                              await FirebaseFirestore.instance
                                  .collection('symptom').doc(widget.id)
                                  .update({
                                'symptoms': _nameController.text,
                                'treatment': treatmantsList

                              });




                            }else if (desieseList.isNotEmpty){

                              await FirebaseFirestore.instance
                                  .collection('symptom').doc(widget.id)
                                  .update({
                                'symptoms': _nameController.text,
                                 'disease':  List.from(desieseList),
                                

                              });




                            }else if(treatmantsList.isEmpty&&desieseList.isEmpty){

                              
                              await FirebaseFirestore.instance
                                  .collection('symptom').doc(widget.id)
                                  .update({
                                'symptoms': _nameController.text,
                                
                                

                              });

                              desieseList.clear();

                             

                              

                            


                            } else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Somthing wrong')));
                            }

                        ScaffoldMessenger.of(context).showSnackBar(
                                 const SnackBar(
                                      content: Text('updated Successfully')));

                              Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[900],
                              minimumSize: const Size.fromHeight(40)),
                          child: isloading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text('Submit'))
                    
                ],
              ),
            ),
          ),
        ));
  }
}
