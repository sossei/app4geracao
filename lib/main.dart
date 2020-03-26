import 'package:app4geracao/pages/splashscreen/splashscreen_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Color(0xFF261610),
        ),
        bottomAppBarColor: Color(0xFFFFFFFF),
        primaryColor: Color(0xFF261610),
        primarySwatch: Colors.blue,
        backgroundColor: Color(0xFFBFBCAA),
        accentColor: Color(0xFF261610),
        fontFamily: 'gloucester',
        buttonColor: Color(0xFF261610),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontSize: 20,
            color: Color(0xFF402719),
          ),
          bodyText2: TextStyle(
            fontSize: 20,
            color: Color(0xFF402719),
          ),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
