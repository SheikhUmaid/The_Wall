import 'dart:async';

import 'package:flutter/material.dart';

class SplashService {
  init(BuildContext context) {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      Navigator.pushReplacementNamed(context, '/login');
      timer.cancel();
    });
  }
}
