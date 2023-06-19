
import 'package:flutter/material.dart';
import 'package:herbit/register_doctor.dart';
import 'package:herbit/signup_user.dart';


import 'Login.dart';
import 'Signup_Doctor.dart';


class MainDash extends StatelessWidget {
  const MainDash({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: const MainDashB(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainDashB extends StatefulWidget {
  const MainDashB({super.key, required this.title});

  final String title;

  @override
  State<MainDashB> createState() => _MainDashBState();
}

class _MainDashBState extends State<MainDashB> {

  Card makeDashboardItem(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child:  InkWell(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                      icon,
                      size: 40.0,
                      color: Colors.black,
                    )),
                SizedBox(height: 20.0),
                Center(
                  child:  Text(title,
                      style:
                      TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[900],
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text( "REGISTRATION",
          style:TextStyle(
              fontSize:25,
              fontWeight:FontWeight.bold,
              color:Colors.white
          ),),
        leading:IconButton(
          icon:Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>  Login()));
          },
        ),
        /// elevation: .1,
        //  backgroundColor: Color.fromRGBO(49, 87, 110, 1.0),
        backgroundColor: Colors.green[900],
      ),
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            children: [

              /*Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text( "Registration",
                  style:TextStyle(
                      fontSize:20,
                      fontWeight:FontWeight.bold,
                      color:Colors.black54
                  ),),
              ),*/ SizedBox(
                height: 40,
              ),
              //  GridView.count(
              //   shrinkWrap: true,
              //    crossAxisCount: 2,
              //    padding: EdgeInsets.all(3.0),
              //    children: <Widget>[
              //      makeDashboardItem("USER", Icons.person_2),
              //      makeDashboardItem("COMPANY", Icons.business),
              //      makeDashboardItem("DEPARTMENT", Icons.factory),
              //    ],
              //  ),
              GridView(

                shrinkWrap: true,
                padding: EdgeInsets.all(80.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,mainAxisSpacing:15,crossAxisSpacing: 10),

                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>User_signup()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:Colors.greenAccent[100],
                      ),
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person,size:50,color:Colors.black),
                          SizedBox(height: 5,),
                          Text("USER",
                              style:
                              TextStyle(fontSize: 18.0, color: Colors.black)),
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>register_doctor()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:Colors.greenAccent[100],
                      ),
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.medical_information_outlined,size:50,color:Colors.black),
                          SizedBox(height: 5,),
                          Text("DOCTOR",
                              style:
                              TextStyle(fontSize: 18.0, color: Colors.black)),
                        ],
                      ),),
                  ),



                ],)
            ],
          ),
        ),
      ),
    );
  }
}