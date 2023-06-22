import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class analysis extends StatefulWidget {
  const analysis({Key? key}) : super(key: key);

  @override
  State<analysis> createState() => _analysisState();
}

class _analysisState extends State<analysis> {

  final TextEditingController _plantController = TextEditingController();
  // List image=["images/download.jpg","images/curryleaf.jpg","images/turmeric.jpg","images/images.jpg"];
  // List name=["Thulasi","curry leave","turmeric","sunflower",];
  // List discription=["* natural immunity booster \n* reduce cold& cough \n* anti cancer properties\n* good for diabetes"
  //   ,"* powerful antioxidant\n* may reduce risk of cancer\n* help in management of diabetes\n* analgesic\n* neuroprotective effect",
  //   "* reduce inflammation\n* helps ease joint pain\n* enhances mood\n* guards your hearts\n* treats your gut\n* improve immunity system\n* fight free radical damages"
  //   ,"* improves heart health\n* improve skin health\n* prevent asthma\n* prevent cancer\n* improves hair health\n* improve digestion",

    /* "reduce cold& cough"
      "anti cancer properties"
     "good for diabetes"];*/
  final CollectionReference _product = FirebaseFirestore.instance
      .collection('product'); //refer to the table we created

  final CollectionReference _products = FirebaseFirestore.instance
      .collection('notify'); //refer to the table we created
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
   
     showDialog(
        
        context: context,
        
        builder: (BuildContext ctx) {
          return AlertDialog(
            contentPadding:const EdgeInsets.all(20),
            title: const Center(
              child:  Text(
                'Add plant Suggestion',
                style: TextStyle(fontSize: 15),
                ),
            ),
            
            
            content: Column(
              
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

              const SizedBox(height: 10,),
               
                
                TextField(
                  controller: _plantController,
                  decoration:const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    border: InputBorder.none,
                    hintText: "enter suggestions",
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[900],
                            elevation: 0,
                            
                            
                          ),
                          onPressed: () async {
                              
                            final String plantName = _plantController.text;
                              
                            await _products.add({
                              "notification": plantName,
                            });
                            _plantController.text = '';
                          },
                          child:const Text('submit')),
                    ),

                   const SizedBox(width: 10,),

                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[900],
                            
                          ),
                          onPressed: () async {
                              
                            Navigator.pop(context);
                          },
                          child:const Text('cancel')),
                    ),

                        
                  ],
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title:const Text(
          'ANALYSIS',
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
      physics: const ScrollPhysics(),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 30,left: 20,right: 20),
        separatorBuilder: (context, index) => const Divider(
          thickness: 1,
        
          
          height: 30,
        ),
        shrinkWrap: true,
            itemCount:  streamSnapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {

              final DocumentSnapshot documentSnapshot=streamSnapshot.data!.docs[index];
              
              return  Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network(
                      documentSnapshot['image'],
                      fit: BoxFit.cover
                      ),

                  ),
              
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                     
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(documentSnapshot['plant_name'],style:const TextStyle(fontSize: 20,color: Colors.green)),
                         const  SizedBox(height: 10,),
                        Text(documentSnapshot['description'],maxLines: 2,
                            overflow: TextOverflow.ellipsis,style:   TextStyle(fontSize: 15,color: Colors.grey[500])),
                      ],
                    ),
                  )
                ],

              );
            },
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
        child: const Icon(Icons.add),
      ),]))
    );
  }
}
