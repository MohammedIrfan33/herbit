import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:herbit/public_user/homepage.dart';
import 'package:herbit/splashpage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 // await PushNotificationService().setupInteractedMessage();

  runApp(const MaterialApp(
    home: SplashScreen(),

    debugShowCheckedModeBanner: false,));
}




class MyAPP extends StatelessWidget {
  const MyAPP({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(body:  homepage(),
    );
  }

}