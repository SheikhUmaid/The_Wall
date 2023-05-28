import 'package:flutter/material.dart';

class RoundTL extends StatelessWidget {
  const RoundTL({super.key, required this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color.fromARGB(200, 255, 255, 255),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
        ),
      ),
      child: child,
    );
  }
}
