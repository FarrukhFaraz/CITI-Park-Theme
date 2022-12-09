import 'package:citi_theme_park/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/colors.dart';
import '../util/drawer.dart';
import '../util/navigator.dart';
import '../util/show_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> key = GlobalKey();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  loginUser() {
    if (usernameController.text.trim().isEmpty) {
      showMessage(context, 'Please chose a username', kRed);
    } else if (passwordController.text.trim().isEmpty) {
      showMessage(context, 'Please chose a valid password', kRed);
    } else {
      checkLoginData();    /////////// saving user data , no need to login again
    }
  }

  checkLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', usernameController.text);
    showResult();    ////////////// showing message
  }

  showResult() {
    showMessage(context, 'Login Successfully', kGreen);
    navPush(context, const HomePage(index: 0));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: key,
        endDrawer: const DrawerScreen(),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/logo.png'),
                        fit: BoxFit.fill)),
              ),
              /* Image.asset(
                'assets/logo.png',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fitWidth,
              ),*/
              Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            //  Navigator.pop(context);
                          },
                          child: CircleAvatar(
                            backgroundColor: kColor,
                            radius: 12,
                            child: Padding(
                                padding: const EdgeInsets.only(left: 3),
                                // alignment: Alignment.center,
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: kWhite,
                                  size: 18,
                                )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            key.currentState!.openEndDrawer();
                          },
                          child: const Icon(
                            Icons.menu,
                            color: Color(0xff967c1d),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.38,
                  ),
                  textField(usernameController, 'Username'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  textField(passwordController,'Password'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        loginUser();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.18,
                            vertical: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: const Color(0xff967c1d)),
                        child: Text(
                          'SignIn',
                          style: TextStyle(color: kWhite, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Forgot Password? ',
                        style: TextStyle(fontSize: 16, color: kBlack),
                      ),
                      const Text(
                        'Click here ',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFFab912d),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField( TextEditingController controller ,String hint){
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.13),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Color(0xFFab912d), width: 2))),
      child: TextField(
        autofocus: false,
        cursorColor: kColor,
        controller: controller,
        decoration: InputDecoration(
          isDense: true,
          enabledBorder:
          const OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder:
          const OutlineInputBorder(borderSide: BorderSide.none),
          hintText: hint,
        ),
      ),
    );
  }

}
