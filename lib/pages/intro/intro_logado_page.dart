import 'package:app4geracao/control/nav/nav.dart';
import 'package:app4geracao/control/preferences/user_pref.dart';
import 'package:app4geracao/control/web/aws.dart';
import 'package:app4geracao/pages/intro/intro_logado_controller.dart';
import 'package:app4geracao/widgets/button_4geracao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class IntroLogadoPage extends StatefulWidget {
  @override
  _IntroLogadoPageState createState() => _IntroLogadoPageState();
}

class _IntroLogadoPageState extends State<IntroLogadoPage>
    with TickerProviderStateMixin {
  IntroLogadoController _controller = IntroLogadoController();
  AnimationController controller;
  Animation<double> animation;
  AnimationController controllerLabel;
  Animation<double> animationLAbel;
  @override
  void initState() {
    _controller.fetchData();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInCubic);
    controllerLabel = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    animationLAbel =
        CurvedAnimation(parent: controllerLabel, curve: Curves.easeIn);
    controller.forward();
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controllerLabel.forward();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/background.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Container(
                    child: Center(
                      child: Image.asset(
                        'assets/images/logo_black.png',
                        height: 200,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 8,
                  child: Container(),
                ),
              ],
            ),
          )),
        ),
        SafeArea(
          child: Container(
            margin: EdgeInsets.all(16),
            width: double.infinity,
            child: FadeTransition(
              opacity: animation,
              child: Observer(
                builder: (_) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(16.0),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: _controller.usuario != null
                          ? _buildForm()
                          : _buildRequesting(),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildRequesting() {
    return CircularProgressIndicator();
  }

  _buildForm() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: 150,
          width: 150,
          child: ClipOval(
            child: _controller.usuario.fotoPerfil != null
                ? FadeInImage.assetNetwork(
                    placeholder: 'assets/images/perfil.jpg',
                    image: awss3 + _controller.usuario.fotoPerfil,
                    fit: BoxFit.fitWidth,
                  )
                : Image.asset('assets/images/perfil.jpg'),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        FadeTransition(
          opacity: animationLAbel,
          child: Text(
            'Bem vindo ${_controller.usuario.nome}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Button4Geracao(
          title: 'Deslogar',
          action: () async {
            await UsuarioPref().clear();
            returnSplash(context);
          },
        ),
      ],
    );
  }
}
