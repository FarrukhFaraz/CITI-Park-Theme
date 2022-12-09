import 'package:citi_theme_park/nav_screen/fav_screen.dart';
import 'package:citi_theme_park/nav_screen/notification_screen.dart';
import 'package:citi_theme_park/nav_screen/search_screen.dart';
import 'package:citi_theme_park/util/colors.dart';
import 'package:flutter/material.dart';

import 'nav_screen/home_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.index}) : super(key: key);

   final int index;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int? index;

  List bottomNavList = [
    const HomeScreen(),
    const NotificationScreen(),
    const FavScreen(),
    const SearchScreen()
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      index = widget.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: index!,
        onTap: (ind) {
          setState(() {
            index = ind;
          });
        },
         iconSize: 28,
        selectedItemColor: bottomNavColor,
        unselectedItemColor: kBlack,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: "",
          ),
        ],
      ),
      body: bottomNavList[index!],
    ));
  }
}
