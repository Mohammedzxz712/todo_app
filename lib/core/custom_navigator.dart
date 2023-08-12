import 'package:flutter/material.dart';

class CustomNavigation {
  static void navigatorTo(context, widget) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}
