import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:herbit/admin/add_symptoms_screen.dart';
class addsymptoms extends StatefulWidget {
  const addsymptoms({Key? key}) : super(key: key);

  @override
  State<addsymptoms> createState() => _addsymptomsState();
}

class _addsymptomsState extends State<addsymptoms> {
  final CollectionReference _symptoms = FirebaseFirestore.instance
      .collection('symptom'); //refer to the table we created

  


 

 
  Future<void> _delete(String productId) async {
    await _symptoms.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted')));
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(appBar: AppBar(backgroundColor: Colors.green[900],
      title: const Text('HERBAL', style: TextStyle(color: Colors.white),),
    ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green[900],

          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder:(context) {

             return const AddSymptomsScreen();
              
            },));
          },
          child: const Icon(Icons.add),
        ),
        body:StreamBuilder(

          stream: _symptoms.snapshots(),
          builder: (BuildContext context,

              AsyncSnapshot<QuerySnapshot>streamSnapshot){

            if(streamSnapshot.hasData){
              return ListView.builder(

                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {

                    final DocumentSnapshot documentSnapshot=streamSnapshot.data!.docs[index];
                   
                    return Card(

                      margin: const EdgeInsets.all(10),

                      child: ListTile(

                        title:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                             Text("Symptoms : ${documentSnapshot['symptoms']}"),
                             Text("Disease : ${documentSnapshot['disease']}")
                            
                             
                          ]
                        ),
                        subtitle:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _delete(documentSnapshot.id),
                        ),
                      ),
                    );
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}