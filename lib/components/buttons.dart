import 'package:flutter/material.dart';

class AuthButton extends StatefulWidget {
  AuthButton(
      {super.key,
      required this.title,
      required this.onClick,
      this.loading = false});
  final Widget title;
  final void Function()? onClick;
  bool loading;

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        height: 75,
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            )),
        child: TextButton(onPressed: widget.onClick, child: widget),
      ),
    );
  }
}
