import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  final String buttonText;
  final Color color;
  const Custombutton(
      {super.key, required this.buttonText, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(12), color: color),
      height: 50,
      width: 350,
      child: Text(
        buttonText,
        style: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
