import 'package:flutter/material.dart';
import 'package:herbit/admin/pending_details.dart';
import 'package:herbit/admin/user_details.dart';

class manageuser extends StatefulWidget {
  const manageuser({Key? key}) : super(key: key);

  @override
  State<manageuser> createState() => _manageuserState();
}

class _manageuserState extends State<manageuser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: const Text('Manage user'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 90),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const user_details()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green[900],
                        borderRadius: BorderRadius.circular(10)),
                    /* ]*/
                    height: 60,
                    width: 269,
                    child: const Center(child: Text(
                      'View user',
                      style: TextStyle(color: Colors.white),
                      )),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const pending_details()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.green[900],
                        borderRadius: BorderRadius.circular(10)),
                    width: 269,
                    child: const Center(
                      child: Text(
                        'Pending user',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
