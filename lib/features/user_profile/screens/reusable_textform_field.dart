import 'package:flutter/material.dart';

class ReusableTextformfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  const ReusableTextformfield(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.isPassword});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(

          // labelText: "Full Name",
          hintText: hintText,
          border: OutlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.solid))),
    );
  }
}
