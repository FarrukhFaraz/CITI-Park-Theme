import 'dart:async';

import 'package:citi_theme_park/home_page.dart';
import 'package:citi_theme_park/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  splash() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var user = sharedPreferences.getString("user");
    Timer(const Duration(milliseconds: 1800), (() {
      if (user == null) {
        ////////////////////   no user data found , it requires login
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => const LoginScreen())));
      } else {
        ////////////////// user data is saved , no need to login
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: ((context) => const HomePage(index: 0))));
      }
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splash();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBlack,
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/splash_screen.png",
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            Image.asset(
              "assets/splash_bottom_logo.png",
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
            ),
          ],
        ),
      ),
    );
  }
}
