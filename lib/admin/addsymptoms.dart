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


  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['symptom'];
      _prescriptionController.text = documentSnapshot['medicine'];
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

            child: Container(
              height: 300,

              child:Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text('update Symptoms'),


                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: _nameController,

                        decoration: InputDecoration(
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

                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),

                          border: InputBorder.none,
                          hintText: "enter the medicine",
                        ),
                      ),
                    ),
                    ElevatedButton(onPressed: () async {
                      final String symptoms_name= _nameController.text;
                      final String? prescription = _prescriptionController.text;
                      if ( prescription != null) {
                        await _symptoms
                            .doc(documentSnapshot!.id)

                            .update({"symptom": symptoms_name, "medicine": prescription});
                        _nameController.text = '';
                        _prescriptionController.text = '';
                        Navigator.pop(context);
                      }

                    },
                        child: Text('update')
                    ),
                  ],
                ),
              ),
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
                Align(
                    alignment: Alignment.center,
                    child:  Text('Add Symptoms')),


                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _nameController,

                    decoration: InputDecoration(
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

                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),

                      border: InputBorder.none,
                      hintText: "enter the medicine",
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(onPressed: () async {
                    final String symptoms_name= _nameController.text;
                    final String? prescription = _prescriptionController.text;
                    if (prescription != null) {
                      await _symptoms.add({
                        "symptom": symptoms_name,
                        "medicine": prescription,
                      });
                      _nameController.text = '';
                      _prescriptionController.text = '';
                    }

                  },
                      child: Text('submit')
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
      title: Text('HERBAL', style: TextStyle(color: Colors.white),),
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
                      print("snap ${documentSnapshot}");
                      return Card(

                        margin: const EdgeInsets.all(10),

                        child: ListTile(

                          title: Text(documentSnapshot['symptom']),
                          subtitle: Text(documentSnapshot['medicine']),
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