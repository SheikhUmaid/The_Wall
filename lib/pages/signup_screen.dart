import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_wall/components/buttons.dart';
import 'package:the_wall/components/round_tl.dart';
import 'package:the_wall/components/text_fields.dart';
import 'package:the_wall/utils/toast.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            child: Center(
              child: Text(
                'Sign Up',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: RoundTL(
              child: SingleChildScrollView(
                child: Form(
                  key: _globalKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      AuthTextField(
                        controller: nameController,
                        title: 'Name',
                        hint: 'JOHN DOE',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required Name';
                          }
                          return null;
                        },
                      ),
                      AuthTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required Email';
                          }
                          return null;
                        },
                        controller: emailController,
                        title: 'Email',
                        hint: 'name@email.domain',
                      ),
                      AuthTextField(
                        controller: passwordController,
                        title: 'Password',
                        hint: '********',
                        isPassword: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required Password';
                          }
                          if (value.length < 6) {
                            return 'Must be 6 chars long';
                          }
                          return null;
                        },
                      ),
                      AuthTextField(
                        controller: confirmPasswordController,
                        title: 'Confirm Password',
                        hint: '********',
                        isPassword: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required Password';
                          }
                          if (value.length < 6) {
                            return 'Must be 6 chars long';
                          }
                          return null;
                        },
                      ),
                      AuthButton(
                        title: const Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        onClick: () {
                          if (_globalKey.currentState!.validate()) {
                            _auth
                                .createUserWithEmailAndPassword(
                                    email: emailController.text.toString(),
                                    password:
                                        passwordController.text.toString())
                                .then((value) {
                              debugPrint('then called');
                              Utilities.showToast(
                                  msg: 'User Created', color: Colors.green);
                              Navigator.pop(context);
                            }).onError((error, stackTrace) {
                              Utilities.showToast(
                                  msg: error.toString(), color: Colors.red);
                            });
                          }
                        },
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Already have an account? Login',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
