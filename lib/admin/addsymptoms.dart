import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class addsymptoms extends StatefulWidget {
  const addsymptoms({Key? key}) : super(key: key);

  @override
  State<addsymptoms> createState() => _addsymptomsState();
}

class _addsymptomsState extends State<addsymptoms> {
  final CollectionReference _symptoms = FirebaseFirestore.instance
      .collection('symptom'); //refer to the table we created

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _prescriptionController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();


  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['symptom'];
      _prescriptionController.text = documentSnapshot['medicine'];
      _ageController.text = documentSnapshot['age'];
      _dosageController.text = documentSnapshot['dosage'];
    }
    await  showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding:  EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('update Symptoms'),


                Padding(
                  padding: const EdgeInsets.all(16.0),
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
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _prescriptionController,

                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),

                      border: InputBorder.none,
                      hintText: "enter the medicine",
                    ),
                  ),
                ),
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
                    controller: _prescriptionController,

                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),

                      border: InputBorder.none,
                      hintText: "enter the medicine",
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
                ElevatedButton(onPressed: () async {
                  final String symptomsName= _nameController.text;
                  final String prescription = _prescriptionController.text;
                  final String age = _ageController.text;
                  final String dosage = _dosageController.text;


                  await _symptoms
                      .doc(documentSnapshot!.id)

                      .update({
                        "symptom": symptomsName, 
                        "medicine": prescription,
                        "age" : age,
                        "dosage" : dosage
                        });
                  _nameController.text = '';
                  _prescriptionController.text = '';
                  Navigator.pop(context);

                },
                    child: const Text('update')
                ),
              ],
            ),
          );
        }
    );
  }
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['symptom'];
      _prescriptionController.text = documentSnapshot['medicine'];
    }
    await  showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                    alignment: Alignment.center,
                    child:  Text('Add Symptoms')),


                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _nameController,

                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),

                      border: InputBorder.none,
                      hintText: "enter details",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _prescriptionController,

                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),

                      border: InputBorder.none,
                      hintText: "enter the medicine",
                    ),
                  ),
                ),
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
                      hintText: "dosage",
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(onPressed: () async {
                    final String symptomsName= _nameController.text;
                    final String prescription = _prescriptionController.text;
                    final String age = _ageController.text;
                    final String dosage = _dosageController.text;

                    await _symptoms.add({
                      "symptom": symptomsName,
                      "medicine": prescription,
                      "age" : age,
                      "dosage" : dosage
                    });
                    _nameController.text = '';
                    _prescriptionController.text = '';
                    _ageController.text ='';
                    _dosageController.text = '';
                    Navigator.pop(context);

                  },
                      child: const Text('submit')
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
  Future<void> _delete(String productId) async {
    await _symptoms.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a symptoms')));
  }

  @override
  Widget build(BuildContext context) {
    var streamSnapshot;
    return Scaffold(appBar: AppBar(backgroundColor: Colors.green[900],
      title: const Text('HERBAL', style: TextStyle(color: Colors.white),),
    ),
        floatingActionButton: FloatingActionButton(

          onPressed: () => _create(),
          child: const Icon(Icons.add),
        ),
        body:Container(


          child: StreamBuilder(

            stream: _symptoms.snapshots(),
            builder: (BuildContext context,

                AsyncSnapshot<QuerySnapshot>streamSnapshot){

              if(streamSnapshot.hasData){
                return ListView.builder(

                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {

                      final DocumentSnapshot documentSnapshot=streamSnapshot.data!.docs[index];
                      print("snap $documentSnapshot");
                      return Card(

                        margin: const EdgeInsets.all(10),

                        child: ListTile(

                          title:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                               Text("Symptom :${documentSnapshot['symptom']}"),
                               Text("Medicines :${documentSnapshot['medicine']}"),
                            ]
                          ),
                          subtitle:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text("Age :${documentSnapshot['age']}"),
                                Text("Dosage :${documentSnapshot['dosage']}"),
                            ],
                          ),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => _update(documentSnapshot),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => _delete(documentSnapshot.id),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ));
  }
}