import 'package:flutter/material.dart';

navPush(BuildContext context, var screen) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
}

navReplace(BuildContext context, var home) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => home));
}
