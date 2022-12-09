import 'package:flutter/material.dart';

import '../util/colors.dart';

Widget drawerWidget(IconData icon, String text) {
  return Row(
    children: [
      Container(
        width: 50,
        height: 40,
        decoration: BoxDecoration(
          color: kColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: const [
            BoxShadow(
              color: Color(0xd0967c1d),
              spreadRadius: 2,
              offset: Offset(0.01, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: CircleAvatar(
          radius: 10,
          backgroundColor: kWhite,
          child: Icon(
            icon,
            size: 15,
            color: kBlack,
          ),
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Container(
          height: 40,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: kColor,
            boxShadow: const [
              BoxShadow(
                color: Color(0xd0967c1d),
                spreadRadius: 2,
                offset: Offset(0.01, 3),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(text),
        ),
      )
    ],
  );
}
