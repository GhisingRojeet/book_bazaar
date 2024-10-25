import 'package:amazon_clone/features/admin/screens/analytics_screen.dart';
import 'package:amazon_clone/features/admin/screens/user_list.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/admin/views/product_screen.dart';
import 'package:flutter/material.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  final AdminServices adminServices = AdminServices();
  void logOutAdmin() {
    adminServices.logOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  child: Icon(
                    Icons.person,
                    size: 50,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  "Admin",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Divider(
            thickness: 0.5,
          ),
          ListTile(
            leading: Icon(Icons.production_quantity_limits_outlined),
            visualDensity: VisualDensity.compact,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProductScreen()));
            },
            title: Text("All Products"),
          ),
          ListTile(
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => UserList()));
            },
            title: Text("Users"),
          ),
          ListTile(
            leading: Icon(Icons.pie_chart_outline_outlined),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AnalyticsScreen()));
            },
            title: Text("Analytics"),
          ),
          ListTile(
            leading: Icon(Icons.event_available_outlined),
            visualDensity: VisualDensity.compact,
            onTap: () {},
            title: Text("About"),
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new_rounded),
            visualDensity: VisualDensity.compact,
            onTap: () {
              logOutAdmin();
            },
            title: Text("Log Out"),
          )
        ],
      ),
    );
  }
}
