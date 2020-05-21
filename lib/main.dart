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
        scaffoldBackgroundColor: Color(0xFFF7F3F0),
        iconTheme: IconThemeData(
          color: Color(0xFF5B4D33),
        ),
        bottomAppBarColor: Color(0xFFFFFFFF),
        primaryColor: Color(0xFF5B4D33),
        primarySwatch: Colors.blue,
        backgroundColor: Color(0xFFF7F3F0),
        accentColor: Color(0xFF5B4D33),
        fontFamily: 'athiti',
        buttonColor: Color(0xFF5B4D33),
        textTheme: TextTheme(
          headline6: TextStyle(
              fontSize: 16, fontFamily: 'antonio', fontWeight: FontWeight.bold),
          button: TextStyle(fontSize: 16, fontFamily: 'antonio'),
          bodyText1: TextStyle(fontSize: 16, fontFamily: 'athiti'),
          bodyText2: TextStyle(fontSize: 16, fontFamily: 'athiti'),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
