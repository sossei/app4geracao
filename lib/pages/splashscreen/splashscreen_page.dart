import 'package:app4geracao/control/nav/nav.dart';
import 'package:app4geracao/control/preferences/user_pref.dart';
import 'package:app4geracao/model/usuario.dart';
import 'package:app4geracao/pages/intro/intro_logado_page.dart';
import 'package:app4geracao/pages/intro/intro_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    fetch(context);
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

  fetch(BuildContext context) async {
    Usuario usu = await UsuarioPref().getUsuario();
    if (usu == null) {
      Future.delayed(Duration(seconds: 2))
          .then((_) => pushReplacment(context, IntroPage()));
    } else {
      Future.delayed(Duration(seconds: 1))
          .then((_) => pushReplacment(context, IntroLogadoPage()));
    }
  }
}
