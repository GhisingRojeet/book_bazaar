import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:amazon_clone/features/auth/widgets/customTextFormField.dart';
import 'package:amazon_clone/features/auth/widgets/custombutton.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      phone: _phoneController.text,
      name: _nameController.text,
      password: _passwordController.text,
    );
  }

  NavigateToSignUpScreen() {
    // Navigator.pushNamed(context, routeName)
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "LogIn",
                      style: TextStyle(
                          fontSize: 20, color: Colors.deepPurpleAccent),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "Name",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Customtextformfield(
                          isObsecure: false,
                          textEditingController: _nameController,
                          hintText: "Name"),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Customtextformfield(
                          isObsecure: false,
                          textEditingController: _emailController,
                          hintText: "Email"),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "Phone",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Customtextformfield(
                          isObsecure: false,
                          textEditingController: _phoneController,
                          hintText: "Phone"),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "Password",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Customtextformfield(
                          isObsecure: true,
                          textEditingController: _passwordController,
                          hintText: "Password"),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                          onTap: () {
                            if (_formkey.currentState!.validate()) {
                              signUpUser();
                            }
                          },
                          child: Center(
                              child: Custombutton(
                            buttonText: "Sign Up",
                            color: Colors.red,
                          )))
                    ],
                  )),
              SizedBox(
                height: 45,
              ),
              // Custombutton(
              //   buttonText: "Login With FaceBook",
              //   color: Colors.blue,
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Custombutton(
              //   buttonText: "Login With Google",
              //   color: Colors.red,
              // )
            ],
          ),
        ),
      )),
    );
  }
}
