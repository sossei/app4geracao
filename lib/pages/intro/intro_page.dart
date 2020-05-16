import 'package:app4geracao/pages/cadastro/cadastro_page.dart';
import 'package:app4geracao/pages/login/login_page.dart';
import 'package:app4geracao/widgets/button_4geracao.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
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
          )),
        )
      ],
    );
  }

  _buildTexts() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              'Seja bem vindo',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              'Para uma experiência de verdade, agende',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  _buildButtonCadastrar() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Button4Geracao(
        title: 'Cadastrar',
        action: () {
          Navigator.of(context).push(MaterialPageRoute(
              settings: RouteSettings(name: "/Cadastro/Email"),
              builder: (context) => CadastroPage()));
        },
      ),
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
      child: Container(
        padding: EdgeInsets.all(16),
        child: Text(
          'Já sou cliente',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              color: Colors.black),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            settings: RouteSettings(name: "/Login"),
            builder: (context) => LoginPage()));
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
