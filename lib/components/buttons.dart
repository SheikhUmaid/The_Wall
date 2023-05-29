import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.title, required this.onClick});
  final Widget title;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: onClick,
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
          child: Center(child: title),
        ),
      ),
    );
  }
}

class OtherLogin extends StatelessWidget {
  const OtherLogin({super.key, required this.iconData, this.onClick});
  final IconData iconData;
  final void Function()? onClick;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 75,
        width: 75,
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Icon(
          iconData,
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}
