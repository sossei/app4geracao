import 'package:app4geracao/pages/splashscreen/splashscreen_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

Future push(BuildContext context, Widget page) {
  return Navigator.push(context, AnimRoute(page: page));
}

pushReplacment(BuildContext context, Widget page) {
  Navigator.pushReplacement(context, AnimRoute(page: page));
}

pop(BuildContext context) {
  Navigator.pop(context);
}

returnSplash(BuildContext context) {
  Navigator.pushAndRemoveUntil(
      context, AnimRoute(page: SplashScreen()), ModalRoute.withName('/'));
}

class AnimRoute extends PageRouteBuilder {
  final Widget page;
  AnimRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionDuration: Duration(milliseconds: 400),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(-1.0, 0.0),
                ).animate(secondaryAnimation),
                child: child,
              ),
            ),
          ),
        );
}
