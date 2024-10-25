import 'package:flutter/material.dart';

class Customtextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  // Icon otpIcon;
  final int maxLines;
  final TextInputType textInputType;
  final bool passwordtext;
  const Customtextfield(
      {super.key,
      required this.controller,
      required this.hintText,
      this.maxLines = 1,
      this.textInputType = TextInputType.text,
      required this.passwordtext});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: passwordtext,
      keyboardType: textInputType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your $hintText";
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        // suffixIcon: ,

        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
      ),
      maxLines: maxLines,
    );
  }
}
