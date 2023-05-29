import 'package:flutter/material.dart';
import 'package:the_wall/pages/home_screen.dart';
import 'package:the_wall/pages/phone_login_screen.dart';
import 'package:the_wall/pages/signup_screen.dart';
import 'package:the_wall/pages/login_screen.dart';
import 'package:the_wall/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.black,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => HomeScreen(),
        '/phoneLoginScreen': (_) => const PhoneLoginScreen()
      },
    );
  }
}
