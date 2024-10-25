import 'package:amazon_clone/features/account/screens/account_screen.dart';

import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/cart/screens/cart_screen.dart';
import 'package:amazon_clone/features/user_profile/edit_users_credentials%20.dart';
import 'package:amazon_clone/features/user_profile/screens/reusable_account_container.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserAccountScreen extends StatefulWidget {
  const UserAccountScreen({super.key});

  @override
  State<UserAccountScreen> createState() => _UserAccountScreenState();
}

class _UserAccountScreenState extends State<UserAccountScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.13,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 45,
                          child: Icon(Icons.person),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userProvider.user.name,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              userProvider.user.email,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.settings,
                          size: 30,
                        ),
                        onPressed: () {
                          //directs to setting for user profile
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditUserCredentials()));
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.18,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
                    child: Text(
                      "Account",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.017,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600),
                    ),
                  ),
                  ReusableAccountContainer(
                    title: "Orders",
                    icon: Icon(Icons.shopping_bag_outlined),
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AccountScreen()));
                    },
                  ),
                  // Divider(),
                  ReusableAccountContainer(
                    title: "Cart",
                    icon: Icon(Icons.shopping_cart_outlined),
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CartScreen()));
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.33,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
                    child: Text(
                      "Help & Legal",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.017,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600),
                    ),
                  ),
                  ReusableAccountContainer(
                    title: "Help & Support",
                    icon: Icon(Icons.contact_support_outlined),
                    ontap: () {},
                  ),
                  ReusableAccountContainer(
                    title: "Permissions",
                    icon: Icon(Icons.security_outlined),
                    ontap: () {},
                  ),
                  ReusableAccountContainer(
                    title: "Policies",
                    icon: Icon(Icons.description_outlined),
                    ontap: () {},
                  ),
                  ReusableAccountContainer(
                    title: "Rate us",
                    icon: Icon(Icons.star_rate_outlined),
                    ontap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              color: Colors.white,
              child: ReusableAccountContainer(
                title: "Log out",
                icon: Icon(Icons.logout),
                ontap: () => AdminServices().logOut(context),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 5,
            ),
            Center(child: Text("Version 1.0.0")),
            SizedBox(
              height: 20,
            )
          ],
        ),
      )),
    );
  }
}
