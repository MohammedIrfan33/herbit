import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herbit/doctor/home_doctor.dart';
class profile_doctor extends StatefulWidget {
  const profile_doctor({Key? key}) : super(key: key);

  @override
  State<profile_doctor> createState() => _profile_doctorState();
}

class _profile_doctorState extends State<profile_doctor> {
  String userId='';
  User? user;
  TextEditingController fullnameController=TextEditingController();
  TextEditingController phnController=TextEditingController();
  TextEditingController qlController=TextEditingController();
  void fetchUserData() {
    user = FirebaseAuth.instance.currentUser;
    userId = user!.uid;
    FirebaseFirestore.instance.collection('doctor').doc(userId).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

      setState(() {
        String fullname = data['fullname'] as String;
        String phone = data['phone'] as String;
        String ql = data['qualification'] as String;

        fullnameController.text=fullname;
        phnController.text=phone;
        qlController.text=ql;
        print('Fullname: $fullname');
        print('Place: $phone');
      });
      } else {
        print('User document does not exist');
      }
    }).catchError((error) {
      print('Failed to fetch user data: $error');
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserData();
  }
  void updateUserData(String fullname, String phn,String quali) {
    FirebaseFirestore.instance.collection('doctor').doc(userId).update({
      'fullname': fullname,
      'phone': phn,
      'qualification':quali
    }).then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const home_doctor()));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data updated successfully'),
        ),
      );
      print('User data updated successfully!');
    }).catchError((error) {
      print('Failed to update user data: $error');
    });
  }

/*
  var firebaseUser = FirebaseAuth.instance.currentUser!;
  final CollectionReference doctor = FirebaseFirestore.instance
      .collection('doctor');
  void initState() {
    super.initState();
    // Load current user details when the widget initializes
    loadCurrentUserDetails();
  }
  void loadCurrentUserDetails() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      _emailcontroller.text = user.email ?? '';
      _namecontroller.text = user.displayName ?? '';
      _phonecontroller.text=user.phoneNumber??'';
    }
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('profile'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding:  EdgeInsets.symmetric(vertical: 10),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('images/Herbal.jpg'),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: TextField(
                controller: fullnameController,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.person),
                  border: InputBorder.none,
                  hintText: 'username',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: TextField(
                controller: phnController,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.email),
                  border: InputBorder.none,
                  hintText: 'Email',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: TextField(
                controller: qlController,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.medical_information,),
                  border: InputBorder.none,
                  hintText: 'qualifications',
                ),
              ),
            ),
            ElevatedButton(onPressed: (){
              updateUserData(fullnameController.text.trim(), phnController.text.trim(), qlController.text.trim());
            }, child: const Text("Update"))

          ],
        ),
      ),
    );
  }
}
