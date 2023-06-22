
import 'package:flutter/material.dart';
import 'package:herbit/admin/pending_doctor.dart';
import 'package:herbit/admin/viewdoctor.dart';
class managedoctor extends StatefulWidget {
  const managedoctor({Key? key}) : super(key: key);

  @override
  State<managedoctor> createState() => _managedoctorState();
}

class _managedoctorState extends State<managedoctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor: Colors.green[900],
        title: const Text('manage Doctor'),),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 150),
          child: Column(
            children:[
              GestureDetector(onTap: (){ Navigator.push(
                context, MaterialPageRoute(builder:(context) => const viewdoctor()),
              );},
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green[900],           borderRadius: BorderRadius.circular(10)
                    ),                /* ]*/
                    height: 60,
                    width:269,
                    child: const Center(child: Text(
                      'View doctor',
                      style:TextStyle(color:Colors.white)
                      )),

                  ),
                ),),
              GestureDetector(onTap: (){Navigator.push(
                context, MaterialPageRoute(builder:(context) => const pending_doctor()),
              );},     child:Padding(padding: const EdgeInsets.all(16.0),
                child: Container(  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.green[900],           borderRadius: BorderRadius.circular(10)
                  ),
                  width:269 ,
                  child: const Center(child: Text(
                    'pending doctor',
                    style: TextStyle(color: Colors.white),
                    )),


                ),
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
