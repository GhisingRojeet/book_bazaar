import 'package:flutter/material.dart';

class ReusableAccountContainer extends StatelessWidget {
  final String title;
  final Icon icon;
  final VoidCallback ontap;

  const ReusableAccountContainer(
      {super.key,
      required this.title,
      required this.icon,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      height: MediaQuery.of(context).size.height * 0.065,
      child: ListTile(
        onTap: ontap,
        title: Text(title),
        leading: icon,
      ),
    );
  }
}
