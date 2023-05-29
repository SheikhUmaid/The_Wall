import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_wall/components/buttons.dart';
import 'package:the_wall/components/round_tl.dart';
import 'package:the_wall/components/text_fields.dart';
import 'package:the_wall/utils/toast.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool sendingOTP = false;

  void phoneLogin() {
    setState(() {
      sendingOTP = !sendingOTP;
    });

    _auth.verifyPhoneNumber(
      phoneNumber: phoneController.text,
      verificationCompleted: (_) {},
      verificationFailed: (e) {},
      codeSent: (_, __) {},
      codeAutoRetrievalTimeout: (e) {},
    );
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
                        'SMS Login',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AuthTextField(
                        controller: phoneController,
                        title: 'Phone',
                        hint: '+91 7006786167',
                      ),
                      AuthButton(
                        title: sendingOTP
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Send OTP',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                        onClick: () {
                          phoneLogin();
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
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/login', (route) => false);
                            },
                            iconData: Icons.email,
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
