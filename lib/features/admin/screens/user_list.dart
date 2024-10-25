import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final AdminServices adminServices = AdminServices();
  List<User>? users;

  @override
  void initState() {
    super.initState();
    fetchAllUsers();
  }

  void fetchAllUsers() async {
    users = await adminServices.fetchAllUsers(context);
    setState(() {});
  }

  void deleteUser(User user, int index) async {
    adminServices.deleteUser(
        context: context,
        user: user,
        onSuccess: () {
          users!.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: users!.length,
        itemBuilder: (context, index) {
          final userData = users![index];
          return Container(
              height: 100,
              child: ListTile(
                leading: Icon(Icons.person_2_outlined),
                trailing: IconButton(
                    onPressed: () {
                      deleteUser(userData, index);
                    },
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.red,
                    )),
                subtitle: Text("${userData.email}"),
                title: Text("${userData.name}"),
              ));
        },
      ),
    );
  }
}
