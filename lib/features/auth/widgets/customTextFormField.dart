import 'package:flutter/material.dart';

class Customtextformfield extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isObsecure;

  final String hintText;
  const Customtextformfield(
      {super.key,
      required this.textEditingController,
      required this.hintText,
      required this.isObsecure});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your $hintText";
        }
        return null;
      },
      obscureText: isObsecure,
      controller: textEditingController,
      decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey),
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );
  }
}
