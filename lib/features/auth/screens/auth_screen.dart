// import 'package:amazon_clone/common/widgets/customButton.dart';
// import 'package:amazon_clone/common/widgets/customTextfield.dart';
// import 'package:amazon_clone/constants/globalVariables.dart';
// import 'package:amazon_clone/features/auth/services/auth_service.dart';
// import 'package:email_otp_auth/email_otp_auth.dart';
// import 'package:flutter/material.dart';

// enum Auth {
//   signin,
//   signup,
// }

// class AuthScreen extends StatefulWidget {
//   static const String routeName = '/auth-screen';
//   const AuthScreen({super.key});

//   @override
//   State<AuthScreen> createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen> {
//   Auth _auth = Auth.signup;
//   final _signUpFormkey = GlobalKey<FormState>();
//   final _signInFormkey = GlobalKey<FormState>();
//   final AuthService authService = AuthService();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController nameController = TextEditingController();
//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     nameController.dispose();
//     super.dispose();
//   }

//   void emailAuthOTP() async {
//     EmailOtpAuth.sendOTP(email: emailController.text);
//   }
//   void emailOTPVerify()async{
//     await EmailOtpAuth.verifyOtp(otp: otp);
//   }

//   void signUpUser() {
//     authService.signUpUser(
//       context: context,
//       email: emailController.text,
//       name: nameController.text,
//       password: passwordController.text,
//     );
//   }

//   void signInUser() {
//     authService.signInUser(
//       context: context,
//       email: emailController.text,
//       password: passwordController.text,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: GlobalVariables.greyBackgroundCOlor,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SafeArea(
//             child:
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Text(
//                 "Welcome",
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               ListTile(
//                 tileColor: _auth == Auth.signup
//                     ? GlobalVariables.backgroundColor
//                     : GlobalVariables.greyBackgroundCOlor,
//                 leading: Radio(
//                   activeColor: GlobalVariables.secondaryColor,
//                   value: Auth.signup,
//                   groupValue: _auth,
//                   onChanged: (Auth? value) {
//                     setState(
//                       () {
//                         _auth = value!;
//                       },
//                     );
//                   },
//                 ),
//                 title: Text(
//                   "Create Account",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               if (_auth == Auth.signup)
//                 Container(
//                   padding: EdgeInsets.all(8),
//                   color: GlobalVariables.backgroundColor,
//                   child: Form(
//                     key: _signUpFormkey,
//                     child: Column(
//                       children: [
//                         Customtextfield(
//                             passwordtext: false,
//                             textInputType: TextInputType.emailAddress,
//                             hintText: "Email",
//                             controller: emailController),
//                         SizedBox(
//                           height: 12,
//                         ),
//                         Customtextfield(
//                             passwordtext: false,
//                             textInputType: TextInputType.name,
//                             hintText: "name",
//                             controller: nameController),
//                         SizedBox(
//                           height: 12,
//                         ),
//                         Customtextfield(
//                             passwordtext: true,
//                             hintText: "Password",
//                             controller: passwordController),
//                         SizedBox(
//                           height: 12,
//                         ),
//                         CustomButton(
//                           color: GlobalVariables.secondaryColor,
//                           text: "SignUp",
//                           onTap: () {
//                             if (_signUpFormkey.currentState!.validate()) {
//                               signUpUser();
//                             }
//                             ;
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ListTile(
//                 tileColor: _auth == Auth.signin
//                     ? GlobalVariables.backgroundColor
//                     : GlobalVariables.greyBackgroundCOlor,
//                 leading: Radio(
//                   activeColor: GlobalVariables.secondaryColor,
//                   value: Auth.signin,
//                   groupValue: _auth,
//                   onChanged: (Auth? value) {
//                     setState(
//                       () {
//                         _auth = value!;
//                       },
//                     );
//                   },
//                 ),
//                 title: Text(
//                   "Sign-In",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               if (_auth == Auth.signin)
//                 Container(
//                   padding: EdgeInsets.all(8),
//                   color: GlobalVariables.backgroundColor,
//                   child: Form(
//                     key: _signInFormkey,
//                     child: Column(
//                       children: [
//                         Customtextfield(
//                             passwordtext: false,
//                             textInputType: TextInputType.emailAddress,
//                             hintText: "Email",
//                             controller: emailController),
//                         SizedBox(
//                           height: 12,
//                         ),
//                         Customtextfield(
//                             passwordtext: true,
//                             textInputType: TextInputType.text,
//                             hintText: "Password",
//                             controller: passwordController),
//                         SizedBox(
//                           height: 12,
//                         ),
//                         CustomButton(
//                           color: GlobalVariables.secondaryColor,
//                           text: "SignIn",
//                           onTap: () {
//                             if (_signInFormkey.currentState!.validate()) {
//                               signInUser();
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//             ]),
//           ),
//         ),
//       ),
//     );
//   }
// }
