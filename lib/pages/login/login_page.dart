import 'package:app4geracao/widgets/button_4geracao.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: _buildBody(),
                  ),
                ),
              ],
            ),
          )),
        )
      ],
    );
  }

  Padding _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(16.0),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 16),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Digite seu e-mail',
                      labelStyle: TextStyle(color: Color(0xFF261610)),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF402719),
                        ),
                      ),
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Theme.of(context).accentColor,
                      ),
                      hintText: 'Digite sua senha',
                      labelStyle: TextStyle(color: Color(0xFF261610)),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF402719),
                        ),
                      ),
                      labelText: 'Senha',
                    ),
                  ),
                  SizedBox(height: 16),
                  Button4Geracao(
                    title: 'Prosseguir',
                    action: () {
                      print('Iniciando cadastro');
                    },
                  ),
                  SizedBox(height: 16),
                  _buildEsqueciSenha(),
                  // Add TextFormFields and RaisedButton here.
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildEsqueciSenha() {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Text(
          'Esqueci minha senha',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
      ),
      onTap: () {
        print('Esqueci minha senha!');
      },
    );
  }
}
