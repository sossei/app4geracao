import 'package:app4geracao/control/nav/nav.dart';
import 'package:app4geracao/pages/cadastro/cadastro_page.dart';
import 'package:app4geracao/pages/login/login_page.dart';
import 'package:app4geracao/widgets/button_4geracao.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with TickerProviderStateMixin {
  AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
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
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/background.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: body(),
        )
      ],
    );
  }

  Widget body() {
    Widget child = Padding(
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
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _buildTexts(),
                _buildButtons(),
              ],
            ),
          ),
        ],
      ),
    );
    return SafeArea(
      child: FadeTransition(
          opacity: Tween(begin: 0.0, end: 1.0).animate(animationController),
          child: child),
    );
  }

  _buildTexts() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        // cros,
        children: <Widget>[
          Text(
            'Seja bem vindo',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          Text(
            'Para uma experiência de verdade, agende',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
        ],
      ),
    );
  }

  _buildButtonCadastrar() {
    return Button4Geracao(
      title: 'Cadastrar',
      action: () {
        push(context, CadastroPage());
      },
    );
  }

  _buildButtons() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildButtonCadastrar(),
        _buildSouCliente(),
        _buildInstagram(),
      ],
    );
  }

  _buildSouCliente() {
    return InkWell(
      child: Text(
        'Já sou cliente',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            color: Colors.black),
      ),
      onTap: () {
        push(context, LoginPage());
      },
    );
  }

  _buildInstagram() {
    return Container(
      child: Center(
        child: InkWell(
          onTap: () {
            _launchInstagram();
          },
          child: Container(
            padding: EdgeInsets.all(16),
            child: Image.asset(
              'assets/images/instagram.png',
              height: 48,
            ),
          ),
        ),
      ),
    );
  }

  _launchInstagram() async {
    const url = 'https://www.instagram.com/barbearia4geracao/';
    if (await canLaunch(url)) {
      await launch(url,
          forceWebView: true, forceSafariVC: true, enableJavaScript: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}
