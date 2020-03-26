import 'package:app4geracao/pages/intro/intro_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 4)).then((_) => Navigator.of(context)
        .pushReplacement(MaterialPageRoute(
            settings: RouteSettings(name: "/Intro"),
            builder: (context) => IntroPage())));
    return Scaffold(
      body: _body(),
    );
  }

  _body() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFBFBCAA),
      ),
      child: Center(
        child: Image(
          image: AssetImage('assets/images/logo_black.png'),
          height: 200,
        ),
      ),
    );
  }
}
