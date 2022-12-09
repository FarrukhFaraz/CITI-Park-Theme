import 'package:flutter/material.dart';

import '../home_page.dart';
import 'colors.dart';
import 'navigator.dart';

Widget bottomNav(BuildContext context, int index) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    currentIndex: index,
    iconSize: 28,
    selectedItemColor: const Color(0xff967c1d),
    unselectedItemColor: kBlack,
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: InkWell(
            onTap: () {
              navReplace(context, const HomePage(index: 0));
            },
            child: const Icon(Icons.home_outlined)),
        label: "",
      ),
      BottomNavigationBarItem(
        icon: InkWell(
            onTap: () {
              navReplace(context, const HomePage(index: 1));
            },
            child: const Icon(Icons.notifications_none_outlined)),
        label: "",
      ),
      BottomNavigationBarItem(
        icon: InkWell(
            onTap: () {
              navReplace(context, const HomePage(index: 2));
            },
            child: const Icon(Icons.favorite_border_outlined)),
        label: "",
      ),
      BottomNavigationBarItem(
        icon: InkWell(
            onTap: () {
              navReplace(context, const HomePage(index: 3));
            },
            child: const Icon(Icons.search_outlined)),
        label: "",
      ),
    ],
  );
}
