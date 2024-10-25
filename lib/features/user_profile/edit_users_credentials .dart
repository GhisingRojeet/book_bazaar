import 'package:amazon_clone/features/user_profile/screens/reusable_textform_field.dart';
import 'package:amazon_clone/features/user_profile/services/user_sevices.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditUserCredentials extends StatefulWidget {
  const EditUserCredentials({super.key});

  @override
  State<EditUserCredentials> createState() => _EditUserCredentialsState();
}

class _EditUserCredentialsState extends State<EditUserCredentials> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final UserServices userServices = UserServices();

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _nameController.text = userProvider.user.name;
    _emailController.text = userProvider.user.email;
    _phoneController.text = userProvider.user.phone;
    _passwordController.text = userProvider.user.password;
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void updateUser() async {
    try {
      await userServices.editUser(
        context: context,
        id: Provider.of<UserProvider>(context, listen: false).user.id,
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        password: _passwordController.text,
      );
      setState(() {});
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating user: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(45),
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 45,
                      child: Icon(Icons.person_2_outlined),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ReusableTextformfield(
                      isPassword: false,
                      controller: _nameController,
                      hintText: userProvider.user.name),
                  SizedBox(
                    height: 20,
                  ),
                  ReusableTextformfield(
                      isPassword: false,
                      controller: _emailController,
                      hintText: userProvider.user.email),
                  SizedBox(
                    height: 20,
                  ),
                  ReusableTextformfield(
                      isPassword: false,
                      controller: _phoneController,
                      hintText: userProvider.user.phone),
                  SizedBox(
                    height: 20,
                  ),
                  // ReusableTextformfield(
                  //     isPassword: true,
                  //     controller: _passwordController,
                  //     hintText: userProvider.user.password),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      updateUser();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12)),
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: Text(
                        "Save",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
