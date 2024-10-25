import 'dart:async';

import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/features/admin/screens/admin_screen.dart';
import 'package:amazon_clone/features/auth/screens/logIn_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      if (userProvider.user.token.isNotEmpty) {
        if (userProvider.user.type == 'user') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomBar()),
          );
        } else if (userProvider.user.type == 'admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AdminScreen()),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LogInScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.purpleAccent[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.menu_book_sharp,
              size: 50,
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: AnimatedTextKit(animatedTexts: [
                TyperAnimatedText(
                  "Books Heaven Awaits",
                  speed: Duration(milliseconds: 100),
                  textStyle: GoogleFonts.pacifico(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                TyperAnimatedText("Book Bazaar",
                    speed: Duration(milliseconds: 100),
                    textStyle: GoogleFonts.pacifico(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
