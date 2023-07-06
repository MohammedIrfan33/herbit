import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herbit/admin/addnotify.dart';
import 'package:herbit/admin/addsymptoms.dart';
import 'package:herbit/public_user/homepage.dart';
import 'package:herbit/admin/managedoctor.dart';
import 'package:herbit/admin/manageuser.dart';
import 'package:herbit/admin/product.dart';

class home_admin extends StatefulWidget {
  const home_admin({Key? key}) : super(key: key);

  @override
  State<home_admin> createState() => _home_adminState();
}

class _home_adminState extends State<home_admin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  int count = 0;

  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void updateIsHideValue() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('notify').get();

    List<QueryDocumentSnapshot> documents = querySnapshot.docs;

    WriteBatch batch = FirebaseFirestore.instance.batch();

    for (var document in documents) {
      batch.update(document.reference, {'isHide': true});
    }

    await batch.commit();
    print('Update complete');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("home"),
        backgroundColor: Colors.teal[900],
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(color: Colors.green[900]),
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 8,
                  shrinkWrap: true,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const addsymptoms()));
                      },
                      child: Card(
                        elevation: 10,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Image.asset(
                                'images/symptoms.png',
                                height: 80,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 30),
                              child: Text(
                                'symptoms',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const product()));
                      },
                      child: Card(
                        elevation: 10,
                        child: Column(
                          children: [
                            Image.asset(
                              'images/alternative-medicine-or-herbal-cure-of-energy-therapies-with-ginseng-root-essential-oil-and-seeds-in-flat-cartoon-hand-drawn-templates-illustration-2KE95YD.jpg',
                              height: 120,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(),
                              child: Text(
                                'Analysis',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const manageuser()));
                      },
                      child: Card(
                        elevation: 10,
                        child: Column(
                          children: [
                            Image.asset(
                              'images/manageuser.jpeg',
                              height: 110,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Text(
                                'Manage user',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const managedoctor()));
                      },
                      child: Card(
                        elevation: 10,
                        child: Column(
                          children: [
                            Image.asset(
                              'images/managedoctor.jpeg',
                              height: 110,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 10, top: 3),
                              child: Text(
                                'Manage doctor',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await _auth.signOut();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const homepage()),
                            (Route route) => false);
                      },
                      child: Card(
                        elevation: 10,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Image.asset(
                                'images/logout.jpg',
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 30),
                              child: Text(
                                'Logout',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        updateIsHideValue();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddNotify(),
                            ));
                      },
                      child: Card(
                        elevation: 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('notify')
                                    .where('isHide', isEqualTo: false)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return  Stack(
                                      children: [
                                        const Icon(
                                          Icons.notifications,
                                          size: 60,
                                        ),
                                      snapshot.data!.docs.isEmpty ? const SizedBox.shrink()  :  Positioned(
                                            top: 5,
                                            right: 5,
                                            child: Container(
                                              width: 20,
                                              height: 20,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.red),
                                              child: Center(
                                                  child: Text(
                                                snapshot.data!.docs.length
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              )),
                                            ))
                                      ],
                                    );
                                  } else {
                                    return SizedBox.shrink();
                                  }
                                }),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 30),
                              child: Text(
                                'Notifications',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
    );
  }
}
