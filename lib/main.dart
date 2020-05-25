import 'dart:io';

import 'package:app4geracao/pages/splashscreen/splashscreen_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  Widget build(BuildContext context) {
    firebaseCloudMessaging_Listeners();
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
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

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();
    _firebaseMessaging.setAutoInitEnabled(true);
    _firebaseMessaging.getToken().then((token) {
      print('Token: $token');
    });
    _firebaseMessaging.onTokenRefresh.asBroadcastStream().listen((token) {
      print('Refersh token: $token');
    });
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}
