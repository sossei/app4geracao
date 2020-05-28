import 'package:app4geracao/control/nav/nav.dart';
import 'package:app4geracao/control/preferences/user_pref.dart';
import 'package:app4geracao/model/usuario.dart';
import 'package:app4geracao/pages/administrador/administrador_page.dart';

import 'package:app4geracao/pages/intro/intro_page.dart';
import 'package:app4geracao/pages/menu_cliente/cliente_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animationController.forward(from: 0.0);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fetch(context);
    return Scaffold(
      backgroundColor: Color(0xFFBFBCAA),
      body: _body(),
    );
  }

  _body() {
    Widget child = Container(
      child: Center(
        child: Image(
          image: AssetImage('assets/images/logo_black.png'),
          height: 200,
        ),
      ),
    );
    return SafeArea(
      child: FadeTransition(
          opacity: Tween(begin: 0.0, end: 1.0).animate(animationController),
          child: child),
    );
  }

  fetch(BuildContext context) async {
    Usuario usu = await UsuarioPref().getUsuario();
    if (usu == null) {
      Future.delayed(Duration(seconds: 2))
          .then((_) => pushReplacment(context, IntroPage()));
    } else {
      if (usu.estabelecimento != null) {
        Future.delayed(Duration(seconds: 1))
            .then((_) => pushReplacment(context, AdministradorPage()));
      } else {
        Future.delayed(Duration(seconds: 1))
            .then((_) => pushReplacment(context, ClientePage()));
      }
    }
  }
}
