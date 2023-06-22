import 'package:flutter/material.dart';
import 'package:herbit/admin/view_certificate.dart';
class doctor_details extends StatefulWidget {
  const doctor_details({Key? key}) : super(key: key);

  @override
  State<doctor_details> createState() => _doctor_detailsState();
}

class _doctor_detailsState extends State<doctor_details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Padding(
                padding: EdgeInsets.only(top: 70),
                child: Row(
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ), SizedBox(
                      width: 14,
                    ),
                    Text(
                      ':',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Rabeehath Sarhana ',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      'Age',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 29,
                  ),
                  Text(
                    ':',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    '40',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Row(
                children: [
                  Text(
                    'email',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    ':',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'shibila@gmail.com',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Row(
                children: [
                  Text(
                    'qualification',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    ':',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'MBBS',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Row(
                children: [
                  Text(
                    'email',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    ':',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'shibila@gmail.com',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: 100,
                  height: 40,
                  color: Colors.green[900],
                  child: TextButton(onPressed: (){Navigator.push(
                      context, MaterialPageRoute(builder:(context) => const view_certificate()),);},
                    child: const Text('view',style: TextStyle(color: Colors.white),),),
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 40,
                      color: Colors.green[900],
                      child: TextButton(onPressed: (){},
                        child: const Text('Remove',style: TextStyle(color: Colors.white),),),
                    ),
                    const SizedBox(width: 10,),
                    Container(
                      width: 100,
                      height: 40,
                      color: Colors.green[900],
                      child: TextButton(onPressed: (){},
                        child: const Text('Accept',style: TextStyle(color: Colors.white),),),
                    ),


                  ],
                ),
              ),
            ], ),
        ),
      ), );
  }
}

