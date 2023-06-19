import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herbit/public_user/user.dart';
import 'package:herbit/user/home_user.dart';
import 'package:image_picker/image_picker.dart';
class profile_user extends StatefulWidget {
  const profile_user({Key? key}) : super(key: key);

  @override
  State<profile_user> createState() => _profile_userState();

}

class _profile_userState extends State<profile_user> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _phonecontroller = TextEditingController();
  ImagePicker picker = ImagePicker();
  XFile? image;

  final _formKey = GlobalKey<FormState>();
  @override
  String userId='';
  User? user;
  TextEditingController fullnameController=TextEditingController();
  TextEditingController phnController=TextEditingController();
  TextEditingController ageController=TextEditingController();
  void fetchUserData() {
    user = FirebaseAuth.instance.currentUser;
    userId = user!.uid;
    FirebaseFirestore.instance.collection('user_Tb').doc(userId).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        String fullname = data['fullname'] as String;
        String age = data['age'] as String;
        String phone = data['phone'] as String;

        fullnameController.text=fullname;
        phnController.text=phone;
        ageController.text=age;
        print('Fullname: $fullname');
        print('Place: $phone');
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
  void updateUserData(String fullname, String age,String phn) {
    FirebaseFirestore.instance.collection('user_Tb').doc(userId).update({
      'fullname': fullname,
      'age': age,
      'phone':phn
    }).then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Homeuser()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data updated successfully'),
        ),
      );
      print('User data updated successfully!');
    }).catchError((error) {
      print('Failed to update user data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('profile'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    onTap: ()async{
                      image = await picker.pickImage(
                          source: ImageSource.gallery);
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('images/Herbal.jpg'),

                    ),

                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: TextField(
                    controller: fullnameController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.person),
                      border: InputBorder.none,
                      hintText: 'username',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Mobile Number';
                      }
                      RegExp number = new RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
                      if (number.hasMatch(value)) {
                        return null;
                      } else {
                        return 'Invalid Mobile Number';
                      }
                    },
                    keyboardType: TextInputType.number,
                    controller: phnController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.phone),
                      border: InputBorder.none,
                      hintText: 'Email',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: TextField(
                    controller: ageController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.date_range_sharp,),
                      border: InputBorder.none,
                      hintText: 'phone',
                    ),
                  ),
                ),
                ElevatedButton(onPressed: (){
                  updateUserData(fullnameController.text.trim(), phnController.text.trim(), ageController.text.trim());
                }, child: Text("Update"))

              ],
          ),
        ),
      ),
    );
  }
}
