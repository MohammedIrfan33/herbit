import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class disease extends StatefulWidget {
  final List<String> selectedItems;

  const disease({required this.selectedItems});

  @override
  State<disease> createState() => _diseaseState();
}

class _diseaseState extends State<disease> {
  List<Map<String, dynamic>> allData = [];
  List<Map<String, dynamic>> filteredData = [];

  String datas = '';
  List<Widget>? listSymptms;
  List<dynamic>  diseases = [];

  bool loading = false;


   @override
  void initState() {
    super.initState();
    fetchData();
    listSymptms = widget.selectedItems.map((e) => Text(e,style: const TextStyle(fontSize: 16),)).toList();
  }

  Future<void> fetchData() async {

    setState(() {
      loading  = true;
    });

    
    // Retrieve data from Firebase collection
    final snapshot = await FirebaseFirestore.instance.collection('symptom').where('symptoms',whereIn: widget.selectedItems).get();

     snapshot.docs.forEach((element) { 
       diseases.addAll(element.get('disease'));
     });

     setState(() {
       loading =false;
     });

    
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
                      builder: (context) => const homepage(),
                    ));
              },
              icon: const Icon(Icons.home))
        ],
      ),
      body:loading ? const Center(child: CircularProgressIndicator(),)  :SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Symptoms:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: listSymptms!,
              ),
              const SizedBox(
                height: 20,
              ),

              
            
              const Text(
                'Diseases :',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54),
              ),

              const SizedBox(height: 10,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: diseases.map((e) => Text(e,style: const TextStyle(fontSize: 16),)).toList(),
              ),
              
              const SizedBox(
                height: 150,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 70),
                height: 60,
                color: Colors.green[900],
                child: TextButton(
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const homepage(),
                        ));
                  },
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
