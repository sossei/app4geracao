import 'package:app4geracao/pages/splashscreen/splashscreen_page.dart';
import 'package:flutter/material.dart';

push(BuildContext context, Widget page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

pushReplacment(BuildContext context, Widget page) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

pop(BuildContext context) {
  Navigator.pop(context);
}

returnSplash(BuildContext context) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => SplashScreen()),
      ModalRoute.withName('/'));
}
