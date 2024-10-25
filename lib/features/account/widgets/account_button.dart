import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  final String text;
  final VoidCallback ontap;
  const AccountButton({super.key, required this.text, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.0,
          color: Colors.black12.withOpacity(0.03),
        ),
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
      ),
      child: OutlinedButton(
          onPressed: ontap,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                50,
              ),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          )),
    );
  }
}
