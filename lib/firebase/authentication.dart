import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/notifications.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  get user => _auth.currentUser;

//SIGN UP METHOD
  Future<String?> signUp({
    required String email,
    required String password,
    required String name,
    required String age,
    required String phone,
  }) async {
    final token = await FirebaseNotificatios().getAdminToken();
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      await _db.collection('user_Tb').doc(user!.uid).set({
        'fullname': name,
        'phone': phone,
        'age': age,
        'isAccepted': false,
        'isRejected': true,
        'status': '',
        'token': token,
        'pimage': null,
      });

      await _db.collection('login').doc(user.uid).set({
        'email': email,
        'password': password,
        'role': "user",
        'isAccepted': false
      });

      await FirebaseNotificatios().sendNotification(
          deviceToken: token,
          body: 'New user Registered',
          title: 'Registration');

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> Signupdoc(
      {required String email,
      required String password,
      required String name,
      required String qualification,
      required String phone,
      required List image,
      required String specialisation}) async {
    final token = await FirebaseNotificatios().getAdminToken();

    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      await _db.collection('doctor').doc(user!.uid).set({
        'fullname': name,
        'phone': phone,
        'qualification': qualification,
        'image': image,
        'isAccepted': false,
        'isRejected': true,
        'status': '',
        'specialisation': specialisation,
        'token': token,
        'pimage': null,
      });

      await _db.collection('login').doc(user.uid).set({
        'email': email,
        'password': password,
        'role': "doctor",
        'isAccepted': false
      });

      await FirebaseNotificatios().sendNotification(
          deviceToken: token,
          body: 'New Doctor Registered',
          title: 'Registration');

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> Signupad(
      {required String email, required String password}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      await _db.collection('admin').doc(user!.uid).set({
        'email': email,
        'password': password,
      });

      await _db.collection('login').doc(user.uid).set({
        'email': email,
        'password': password,
        'role': "admin",
      });
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHODJ
  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await _db.collection('login').doc(user!.uid).set({
        'email': email,
        'password': password,

        // 'role':qualification,
      });
      print("user data$user");
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

//read
  read() async {
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot = await _db.collection('user_Tb').doc(user!.uid).get();
      print(documentSnapshot.data());
    } catch (e) {
      print(e);
    }
  }

  //SIGN OUT METHOD
  Future<void> signOut() async {
    await _auth.signOut();
  }

  //get uid
  String getUid() {
    String? uid = _auth.currentUser?.uid;

    return uid ?? '';
  }
}
