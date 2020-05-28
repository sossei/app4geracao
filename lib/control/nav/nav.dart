import 'package:app4geracao/pages/splashscreen/splashscreen_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

Future push(BuildContext context, Widget page) {
  return Navigator.push(
      context,
      PageTransition(
          type: PageTransitionType.rightToLeftWithFade, child: page));
}

pushReplacment(BuildContext context, Widget page) {
  Navigator.pushReplacement(
      context,
      PageTransition(
          type: PageTransitionType.rightToLeftWithFade, child: page));
}

pop(BuildContext context) {
  Navigator.pop(context);
}

returnSplash(BuildContext context) {
  Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
          type: PageTransitionType.leftToRightWithFade, child: SplashScreen()),
      ModalRoute.withName('/'));
}
