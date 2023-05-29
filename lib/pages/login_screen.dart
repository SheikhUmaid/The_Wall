import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_wall/components/buttons.dart';
import 'package:the_wall/components/round_tl.dart';
import 'package:the_wall/components/text_fields.dart';
import 'package:the_wall/utils/toast.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool loggingIn = false;

  void login() {
    setState(() {
      loggingIn = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      Utilities.showToast(msg: 'Signed in Successfully', color: Colors.green);
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      setState(() {
        loggingIn = false;
      });
    }).onError((error, stackTrace) {
      Utilities.showToast(msg: error.toString(), color: Colors.red);
      setState(() {
        loggingIn = false;
      });
    });
  }

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
              child: Icon(
                Icons.message,
                size: 100,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: RoundTL(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AuthTextField(
                        controller: emailController,
                        title: 'Email',
                        hint: 'name@email.domain',
                      ),
                      AuthTextField(
                        controller: passwordController,
                        title: 'Password',
                        hint: '********',
                        isPassword: true,
                      ),
                      AuthButton(
                        title: loggingIn
                            ? const CircularProgressIndicator()
                            : const Text(
                                'login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                        onClick: () {
                          login();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: const Text(
                          'Don\'t have an account? Sign up.',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OtherLogin(
                            onClick: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  '/phoneLoginScreen', (route) => false);
                            },
                            iconData: Icons.phone,
                          ),
                          OtherLogin(
                            onClick: () {},
                            iconData: Icons.pivot_table_chart_rounded,
                          ),
                        ],
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
