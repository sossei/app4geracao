import 'package:app4geracao/widgets/panel_error.dart';
import 'package:app4geracao/widgets/panel_requesting.dart';
import 'package:app4geracao/widgets/panel_uploadimage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'trocar_senha_controller.dart';

class TrocarSenhaPage extends StatefulWidget {
  @override
  _TrocarSenhaPageState createState() => _TrocarSenhaPageState();
}

class _TrocarSenhaPageState extends State<TrocarSenhaPage>
    with TickerProviderStateMixin {
  TrocarSenhaController _controller = TrocarSenhaController();

  final FocusNode _senha = FocusNode();
  final FocusNode _novaSenha = FocusNode();

  AnimationController animationController;
  @override
  void initState() {
    _controller.fetchData();
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Trocar senha'),
      ),
      body: Observer(builder: (_) {
        return Center(child: _body());
      }),
    );
  }

  _body() {
    animationController.forward(from: 0.0);
    Widget child = _controller.msgErro != null
        ? PanelError(
            msgErro: _controller.msgErro,
            action: () {
              _controller.setMsgErro(null);
            },
            descAction: 'OK',
            withCard: false,
          )
        : _controller.isRequesting
            ? PanelRequesting(
                descricao: 'Trocando senha...',
                withCard: false,
              )
            : _buildFormCliente();
    return FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(animationController),
        child: child);
  }

  _buildFormCliente() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Form(
          key: _controller.formCliente,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 32,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          focusNode: _senha,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(_senha, _novaSenha);
                          },
                          validator: (value) {
                            if (value.isEmpty) return 'Campo obrigatório';
                            if (value.length < 6) return 'Mínimo 6 caracteres';
                            _controller.senha = value;
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Senha atual',
                            hintText: 'Digite sua senha atual',
                            labelStyle:
                                TextStyle(color: Theme.of(context).accentColor),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF402719),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Divider(),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          focusNode: _novaSenha,
                          validator: (value) {
                            if (value.isEmpty) return 'Campo obrigatório';
                            if (value.length < 6) return 'Mínimo 6 caracteres';
                            _controller.usuario.senha = value;
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Nova Senha',
                            hintText: 'Digite sua nova senha',
                            labelStyle:
                                TextStyle(color: Theme.of(context).accentColor),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF402719),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  _controller.save().then((value) async {
                    Navigator.pop(context);
                  });
                },
                color: Theme.of(context).accentColor,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    'Salvar',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
                textColor: Color(0xFFFFFFFF),
              )
            ],
          )),
    );
  }

  _fieldFocusChange(FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
