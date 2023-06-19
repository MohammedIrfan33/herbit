import 'package:flutter/material.dart';
class details_user extends StatefulWidget {
  const details_user({Key? key}) : super(key: key);

  @override
  State<details_user> createState() => _details_userState();
}

class _details_userState extends State<details_user> {
  List name=["shibila",];

  List email=["sh@gmail.com",];

  List age=["34", ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
  backgroundColor: Colors.green[900],
  actions: [
  IconButton(onPressed: (){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login(),));
  }, icon: Icon(Icons.home))
  ],
  ),*/
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child:ListView.builder( itemCount: name.length,itemBuilder: (context, index) {
              return        Container(
                child: Column(
                  children: [
                    Container(height: 150,
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text("name:"+name[index],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                            Text("email:"+email[index],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                            Text("qualification:"+ age[index],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),

                            SizedBox(height: 10,),
                            Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 100,
                                  height: 40,
                                  color: Colors.green[900],
                                  child: TextButton(onPressed: (){},
                                    child: Text('accept',style: TextStyle(color: Colors.white),),),
                                ),SizedBox(width: 10,),
                                Container(
                                  width: 100,
                                  height: 40,
                                  color: Colors.green[900],
                                  child: TextButton(onPressed: (){},
                                    child: Text('Remove',style: TextStyle(color: Colors.white),),),
                                ),
                              ],
                            ),
                          ], ),
                      ),
                    ),
                  ],),
              );

            },)
        )
    );
  }
}



