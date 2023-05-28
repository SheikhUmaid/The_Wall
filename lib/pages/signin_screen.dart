import 'package:flutter/material.dart';
import 'package:the_wall/components/buttons.dart';
import 'package:the_wall/components/round_tl.dart';
import 'package:the_wall/components/text_fields.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    AuthTextField(
                      controller: nameController,
                      title: 'Name',
                      hint: 'JOHN DOE',
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
                    AuthTextField(
                      controller: confirmPasswordController,
                      title: 'Confirm Password',
                      hint: '********',
                      isPassword: true,
                    ),
                    AuthButton(
                      title: 'Sign Up',
                      onClick: () {},
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
        ],
      ),
    );
  }
}
