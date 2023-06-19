import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  get user => _auth.currentUser;

//SIGN UP METHOD
  Future<String?> signUp({required String email, required String password,required String name,required String age,required String phone,}) async {
    try {
      UserCredential result= await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user=result.user;
      await _db.collection('user_Tb').doc(user!.uid).set({
        'fullname': name,
        'phone': phone,
        'age':age,
        'isAccepted':false,
        'isRejected':true,
        'status':'',
      });
      print("user data${user}");
      await _db.collection('login').doc(user!.uid).set({
        'email': email,
        'password': password,
        'role':"user",
      });
   //   sendNotificationToAdmin(result.user!.uid);

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
/*  void sendNotificationToAdmin(String userId) async {
    // Retrieve admin device token from the database or other means
    String adminDeviceToken = 'ADMIN_DEVICE_TOKEN';

    // Prepare the notification payload
    final message = {
      'notification': {
        'title': 'New user registration',
        'body': 'A new user has registered and requires approval',
      },
      'data': {
        'user_id': userId,
      },
      'token': adminDeviceToken,
    };

    try {
      // Send the notification using the FCM API
      await FirebaseMessaging.instance.send(message);
      print('Notification sent to admin successfully');
    } catch (e) {
      print('Error sending notification to admin: $e');
    }
  }
 */ Future<String?> Signupdoc({required String email, required String password,required String name,required String qualification,required String phone,required String image}) async {
    try {
      UserCredential result= await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user=result.user;
      await _db.collection('doctor').doc(user!.uid).set({
        'fullname': name,
        'phone': phone,
        'qualification':qualification,
        'image':image,
        'isAccepted':false,
        'isRejected':true,
        'status':'',

      });
      print("user data${user}");
      await _db.collection('login').doc(user!.uid).set({
        'email': email,
        'password': password,
        'role':"doctor",
      });
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
  Future<String?> Signupad({required String email, required String password}) async {
    try {
      UserCredential result= await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user=result.user;
      await _db.collection('admin').doc(user!.uid).set({
        'email': email,
        'password': password,

      });
      print("user data${user}");
      await _db.collection('login').doc(user!.uid).set({
        'email': email,
        'password': password,
        'role':"doctor",
      });
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHODJ
  Future<String?> signIn({required String email, required String password}) async {
    try {
      UserCredential result= await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user=result.user;
      await _db.collection('login').doc(user!.uid).set({
        'email': email,
        'password': password,

       // 'role':qualification,
      });
      print("user data${user}");
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

//read
   read() async {
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot = await   _db.collection('user_Tb').doc(user!.uid).get();
      print(documentSnapshot.data());
    } catch (e) {
      print(e);
    }
  }

  //SIGN OUT METHOD
  Future<void> signOut() async {
    await _auth.signOut();

    print('signout');
  }
}