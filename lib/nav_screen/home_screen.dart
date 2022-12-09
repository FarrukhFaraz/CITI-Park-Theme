import 'package:flutter/material.dart';

import '../util/colors.dart';
import '../util/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: key,
        endDrawer: const DrawerScreen(),
        backgroundColor: kWhite,
        //bottomNavigationBar: bottomNav,
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        backgroundColor: kColor,
                        radius: 12,
                        child: Container(
                            padding: const EdgeInsets.only(left: 3),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: kWhite,
                              size: 18,
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Scaffold.of(context).openDrawer();
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
              Image.asset(
                'assets/home_page_logo.png',
                width: MediaQuery.of(context).size.width,
              ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Welcome to',
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w600, color: kBlack),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Theme Park App',
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w600, color: kBlack),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.03,
                  ),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Rides',
                    style: TextStyle(
                        fontSize: 15,
                        color: kBlack,
                        fontWeight: FontWeight.w600),
                  )),
              Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.03,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Select a ride',
                    style: TextStyle(color: kBlack),
                  )),
              const SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03,
                ),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff967c1d),
                          borderRadius: BorderRadius.circular(20)),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 8,
                        color: kColor,
                        child: Container(
                          decoration: BoxDecoration(
                            color: kColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.03,
                              vertical: 6),
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/home_page_item.png',
                            height: MediaQuery.of(context).size.height * 0.15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff967c1d),
                          borderRadius: BorderRadius.circular(20)),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 2,
                        color: kColor,
                        child: Container(
                          decoration: BoxDecoration(
                            color: kColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.03,
                              vertical: 6),
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/logo.png',
                            height: MediaQuery.of(context).size.height * 0.15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff967c1d),
                          borderRadius: BorderRadius.circular(20)),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 2,
                        color: kColor,
                        child: Container(
                          decoration: BoxDecoration(
                            color: kColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.03,
                              vertical: 6),
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/home_page_item.png',
                            height: MediaQuery.of(context).size.height * 0.15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff967c1d),
                          borderRadius: BorderRadius.circular(20)),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 2,
                        color: kColor,
                        child: Container(
                          decoration: BoxDecoration(
                            color: kColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.03,
                              vertical: 6),
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/logo.png',
                            height: MediaQuery.of(context).size.height * 0.15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
