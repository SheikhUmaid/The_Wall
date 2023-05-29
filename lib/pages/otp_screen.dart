import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_wall/components/buttons.dart';
import 'package:the_wall/components/round_tl.dart';
import 'package:the_wall/components/text_fields.dart';
import 'package:the_wall/utils/toast.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key, required this.verificationId});
  final String verificationId;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool sendingOTP = false;

  Future<void> verifyOTP(String verificationCode, BuildContext context) async {
    setState(() {
      sendingOTP = !sendingOTP;
    });
    final credentials = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: verificationCode);

    try {
      await _auth.signInWithCredential(credentials);
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } catch (e) {
      Utilities.showToast(msg: e.toString(), color: Colors.red);
      setState(() {
        sendingOTP = !sendingOTP;
      });
    }
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
                        'Enter OTP',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      OtpTextField(
                        numberOfFields: 6,
                        borderColor: Colors.black,
                        showFieldAsBox: true,
                        fieldWidth: 50,

                        onCodeChanged: (String code) async {},
                        //runs when every textfield is filled

                        onSubmit: (String verificationCode) async {
                          Utilities.showToast(msg: verificationCode);
                          await verifyOTP(verificationCode, context);
                        }, // end onSubmit
                      ),
                      AuthButton(
                        title: sendingOTP
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Continue',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                        onClick: () {},
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
