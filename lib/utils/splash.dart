import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashService {
  void isUserLoggedIn(BuildContext context) {
    final auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  init(BuildContext context) {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      isUserLoggedIn(context);
      timer.cancel();
    });
  }
}
