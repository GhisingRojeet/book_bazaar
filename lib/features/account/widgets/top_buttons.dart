import 'package:amazon_clone/features/account/widgets/account_button.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/cart/screens/cart_screen.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  final AdminServices adminServices = AdminServices();

  void logOut() {
    adminServices.logOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AccountButton(
                text: "Your orders",
                ontap: () {},
              ),
            ),
            Expanded(
              child: AccountButton(
                text: "Cart",
                ontap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => CartScreen()));
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: AccountButton(
                text: "Log Out",
                ontap: () {
                  logOut();
                },
              ),
            ),
            Expanded(
              child: AccountButton(
                text: "Shop",
                ontap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
