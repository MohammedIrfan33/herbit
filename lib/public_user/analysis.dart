import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';
class analysis extends StatefulWidget {
  const analysis({Key? key}) : super(key: key);

  @override
  State<analysis> createState() => _analysisState();
}

class _analysisState extends State<analysis> {

  final TextEditingController _plantController = TextEditingController();
  List image=["images/download.jpg","images/curryleaf.jpg","images/turmeric.jpg","images/images.jpg"];
  List name=["Thulasi","curry leave","turmeric","sunflower",];
  List discription=["* natural immunity booster \n* reduce cold& cough \n* anti cancer properties\n* good for diabetes"
    ,"* powerful antioxidant\n* may reduce risk of cancer\n* help in management of diabetes\n* analgesic\n* neuroprotective effect",
    "* reduce inflammation\n* helps ease joint pain\n* enhances mood\n* guards your hearts\n* treats your gut\n* improve immunity system\n* fight free radical damages"
    ,"* improves heart health\n* improve skin health\n* prevent asthma\n* prevent cancer\n* improves hair health\n* improve digestion",

    /* "reduce cold& cough"
      "anti cancer properties"
      "good for diabetes"*/];
  final CollectionReference _product = FirebaseFirestore.instance
      .collection('product'); //refer to the table we created

  final CollectionReference _products = FirebaseFirestore.instance
      .collection('notify'); //refer to the table we created
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _plantController.text = documentSnapshot['notification'];
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            child: Container(
              height: 300,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text('Add Plant Suggestion'),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        controller: _plantController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          border: InputBorder.none,
                          hintText: "enter suggestions",
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {

                          final String plant_name = _plantController.text;

                          if (plant_name != null) {
                            await _products.add({
                              "notification": plant_name,
                            });
                            _plantController.text = '';
                          }
                        },
                        child: Text('submit')),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text(
          'HERBAL',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body:
      StreamBuilder(

      stream: _product.snapshots(),
    builder: (BuildContext context,

    AsyncSnapshot<QuerySnapshot>streamSnapshot){

    if(streamSnapshot.hasData){
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: [

          Text("Analysis",style: TextStyle(fontSize: 30,color: Colors.green,fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
                itemCount:  streamSnapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {

                  final DocumentSnapshot documentSnapshot=streamSnapshot.data!.docs[index];
                  print("snap ${documentSnapshot}");
                  return  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius:40,
                          backgroundImage: NetworkImage(documentSnapshot['image']),
                        ),
                    
                        SizedBox(width: 5,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Text(documentSnapshot['plant_name'],style: TextStyle(fontSize: 20,color: Colors.green)),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Text(documentSnapshot['description'],maxLines: 2,
                                    overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 15)),
                              ),
                            ],
                          ),
                        )
                      ],

                    ),
                  );
                },
              ),
        ],
      ),
    );

    }
    return const Center(
    child: CircularProgressIndicator(),
    );
    },
    ),
      floatingActionButton:
      Padding(
        padding: const EdgeInsets.only(left: 300),
        child: Row(
            children: [
            FloatingActionButton(
            onPressed: () {
              _create();
      },
        backgroundColor: Colors.teal[900],
        child: Icon(Icons.add),
      ),]))
    );
  }
}
