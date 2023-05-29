import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_wall/utils/toast.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Posts'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut().then((value) {
                Utilities.showToast(
                    msg: 'Signed out Successfully', color: Colors.green);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              }).onError((error, stackTrace) {
                Utilities.showToast(msg: error.toString(), color: Colors.red);
              });
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
