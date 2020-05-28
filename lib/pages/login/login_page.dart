import 'package:app4geracao/control/nav/nav.dart';
import 'package:app4geracao/pages/login/login_controller.dart';
import 'package:app4geracao/widgets/button_4geracao.dart';
import 'package:app4geracao/widgets/panel_error.dart';
import 'package:app4geracao/widgets/panel_requesting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  BuildContext context;
  LoginController _controller = LoginController();
  AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
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
          backgroundColor: Colors.transparent,
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
                  flex: 5,
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

  _buildBody() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Observer(
        builder: (_) {
          animationController.forward(from: 0.0);
          Widget child = _controller.msgErro != null
              ? _buildError()
              : _controller.isRequesting ? _buildRequesting() : _buildPanel();
          return FadeTransition(
              opacity: Tween(begin: 0.0, end: 1.0).animate(animationController),
              child: child);
        },
      ),
    );
  }

  _buildError() {
    return PanelError(
      msgErro: _controller.msgErro,
      descAction: 'OK',
      action: () {
        _controller.setMsgErro(null);
      },
    );
  }

  _buildRequesting() {
    return PanelRequesting(descricao: 'Efetuando login...');
  }

  _buildPanel() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(16.0),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 16),
                TextFormField(
                  initialValue: _controller.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty) return 'Campo obrigatório';
                    _controller.email = value;
                    return null;
                  },
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
                  initialValue: _controller.senha,
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) return 'Campo obrigatório';
                    _controller.senha = value;
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      FontAwesome.lock,
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
                    _controller.login().then((value) {
                      if (value) returnSplash(context);
                    });
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
