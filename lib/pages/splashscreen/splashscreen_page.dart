import 'package:app4geracao/control/nav/nav.dart';
import 'package:app4geracao/control/preferences/user_pref.dart';
import 'package:app4geracao/model/usuario.dart';
import 'package:app4geracao/pages/administrador/administrador_page.dart';
import 'package:app4geracao/pages/cliente/trabalho/add/add_trab_page.dart';
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
      if (usu.estabelecimento != null) {
        pushReplacment(context, AdministradorPage());
      } else {
        Usuario usuario = await UsuarioPref().getUsuario();
        pushReplacment(context, AddTrabPage(usuario: usuario));
      }
    }
  }
}
