import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:the_wall/components/buttons.dart';
import 'package:the_wall/utils/toast.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController postController = TextEditingController();
  final dbRef = FirebaseDatabase.instance.ref('Posts');
  bool uploading = false;
  void upload(BuildContext context) {
    dbRef.child('1').set({
      'title': postController.text.toString(),
    }).then((value) {
      Utilities.showToast(msg: 'Uploaded Successfully', color: Colors.green);
    }).onError((error, stackTrace) {
      Utilities.showToast(msg: error.toString(), color: Colors.red);
    });
    Navigator.of(context).pop();
  }

  void uploadPost(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Post',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: postController,
                      decoration: const InputDecoration(
                          hintText: 'What are your thoughts'),
                    ),
                    AuthButton(
                        title: uploading
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Upload',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                        onClick: () {
                          upload(context);
                        }),
                    AuthButton(
                        title: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        onClick: () {
                          Navigator.of(context).pop();
                        })
                  ],
                ),
              ),
            ));
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          uploadPost(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
