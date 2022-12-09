import 'dart:async';

import 'package:citi_theme_park/screens/bar_code_scan_page.dart';
import 'package:citi_theme_park/screens/settings.dart';
import 'package:citi_theme_park/screens/user_setting.dart';
import 'package:citi_theme_park/util/colors.dart';
import 'package:citi_theme_park/util/navigator.dart';
import 'package:citi_theme_park/util/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/login_screen.dart';
import '../widgets/drawer_widget.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  bool logOutLoader = false;
  String? username;

  //////////////// Displaying user name on drawer
  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('user');
    });
  }

  /////////////// Alert dialog for user logout
  logOut() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, StateSetter setState) {
          return AlertDialog(
            title: const Text("Logout"),
            content: logOutLoader
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.09,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      color: kColor,
                    ))
                : const Text("Are you sure to logout"),
            actions: [
              logOutLoader
                  ? const Text("")
                  : TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: kColor,
                            borderRadius: BorderRadius.circular(6)),
                        width: MediaQuery.of(context).size.width * 0.18,
                        child: Text(
                          "No",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kWhite,
                              fontSize: 16),
                        ),
                      ),
                    ),
              logOutLoader
                  ? const Text("")
                  : TextButton(
                      onPressed: () async {
                        setState(() {
                          logOutLoader = true;
                        });
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        await prefs.clear();
                        Timer.periodic(const Duration(seconds: 4), (t) {
                          t.cancel();
                          Navigator.pop(context);
                          showMessage(context, "Logout successfully", kGreen);
                          navPush(context, const LoginScreen());
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: kColor,
                            borderRadius: BorderRadius.circular(6)),
                        width: MediaQuery.of(context).size.width * 0.18,
                        child: Text(
                          "Yes",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kWhite,
                              fontSize: 16),
                        ),
                      ),
                    )
            ],
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.025, vertical: 6),
      width: MediaQuery.of(context).size.width / 1.25,
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(8),
                  child: const Icon(Icons.close),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              Icon(
                CupertinoIcons.person_circle,
                size: MediaQuery.of(context).size.width * 0.4,
                color: kBlack,
              ),
              username == null ? const SizedBox() : Text('$username'),
              SizedBox(height: MediaQuery.of(context).size.height * 0.07),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    navPush(context, const UserSetting());
                  },
                  child: drawerWidget(Icons.play_arrow, 'User Settings'),
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    navPush(context, const BarCodeScanPage());
                  },
                  child: drawerWidget(Icons.refresh, 'Scan Card'),
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    navPush(context, const Settings());
                  },
                  child: drawerWidget(Icons.settings, 'Settings'),
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: InkWell(
                  onTap: () {
                    logOut();
                  },
                  child: drawerWidget(Icons.logout, 'Log Out'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
