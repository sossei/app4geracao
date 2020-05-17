import 'package:app4geracao/control/nav/nav.dart';
import 'package:app4geracao/pages/cadastro/cadastro_controller.dart';
import 'package:app4geracao/widgets/panel_error.dart';
import 'package:app4geracao/widgets/panel_requesting.dart';
import 'package:app4geracao/widgets/panel_uploadimage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  CadastroController _controller = CadastroController();
  final FocusNode _email = FocusNode();
  final FocusNode _telefone = FocusNode();
  final FocusNode _nome = FocusNode();
  final FocusNode _sobrenome = FocusNode();
  final FocusNode _senha = FocusNode();
  final FocusNode _rua = FocusNode();
  final FocusNode _numero = FocusNode();
  final FocusNode _estado = FocusNode();
  final FocusNode _cidade = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Observer(builder: (_) {
          return Text(_controller.title);
        }),
      ),
      body: Observer(builder: (_) {
        return Center(child: _body());
      }),
    );
  }

  _body() {
    return _controller.msgErro != null
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
                descricao: 'Efetuando cadastro....',
                withCard: false,
              )
            : _controller.isEndereco
                ? _buildFormEndereco()
                : _buildFormCliente();
  }

  _buildFormCliente() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Form(
          key: _controller.formCliente,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Text('Foto'),
                        UploadImageWidget(
                          onImageUploaded: (url) {
                            _controller.usuario.fotoPerfil =
                                url.replaceAll("\"", '');
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          focusNode: _email,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(_email, _telefone);
                          },
                          keyboardType: TextInputType.emailAddress,
                          initialValue: _controller.usuario.email,
                          validator: (value) {
                            if (value.isEmpty) return 'Campo obrigatório';
                            if (!value.contains('@') || !value.contains('.'))
                              return 'Campo email inválido!';

                            _controller.usuario.email = value;
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Digite seu e-mail',
                            labelStyle:
                                TextStyle(color: Theme.of(context).accentColor),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF402719),
                              ),
                            ),
                            labelText: 'E-mail',
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          focusNode: _telefone,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(_telefone, _nome);
                          },
                          keyboardType: TextInputType.phone,
                          initialValue: _controller.usuario.telefone,
                          validator: (value) {
                            if (value.isEmpty) return 'Campo obrigatório';
                            if (value.length < 11)
                              return 'Telefone inválido. Exemplo correto: 14999998888';
                            _controller.usuario.telefone = value;
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Digite seu telefone',
                            labelStyle:
                                TextStyle(color: Theme.of(context).accentColor),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF402719),
                              ),
                            ),
                            labelText: 'Telefone',
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          focusNode: _nome,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(_nome, _sobrenome);
                          },
                          textCapitalization: TextCapitalization.words,
                          initialValue: _controller.usuario.nome,
                          validator: (value) {
                            if (value.isEmpty) return 'Campo obrigatório';
                            _controller.usuario.nome = value;
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Nome',
                            hintText: 'Digite seu nome',
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
                        TextFormField(
                          focusNode: _sobrenome,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(_sobrenome, _senha);
                          },
                          textCapitalization: TextCapitalization.words,
                          initialValue: _controller.usuario.sobrenome,
                          validator: (value) {
                            if (value.isEmpty) return 'Campo obrigatório';
                            _controller.usuario.sobrenome = value;
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Sobrenome',
                            hintText: 'Digite seu sobrenome',
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
                        TextFormField(
                          focusNode: _senha,
                          initialValue: _controller.usuario.senha,
                          validator: (value) {
                            if (value.isEmpty) return 'Campo obrigatório';
                            if (value.length < 6) return 'Mínimo 6 caracteres';
                            _controller.usuario.senha = value;
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            hintText: 'Digite sua senha',
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
                      ],
                    ),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  _controller.cadastro();
                },
                color: Theme.of(context).accentColor,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    'Prosseguir',
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

  _buildFormEndereco() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Form(
          key: _controller.formCliente,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          focusNode: _rua,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(_rua, _numero);
                          },
                          textCapitalization: TextCapitalization.words,
                          initialValue: _controller.endereco.rua,
                          validator: (value) {
                            if (value.isEmpty) return 'Campo obrigatório';
                            _controller.endereco.rua = value;
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Digite o nome da rua',
                            labelStyle:
                                TextStyle(color: Theme.of(context).accentColor),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF402719),
                              ),
                            ),
                            labelText: 'Rua',
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          focusNode: _numero,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(_numero, _estado);
                          },
                          initialValue: _controller.endereco.numero,
                          validator: (value) {
                            if (value.isEmpty) return 'Campo obrigatório';
                            _controller.endereco.numero = value;
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Número',
                            hintText: 'Digite o número',
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
                        TextFormField(
                          focusNode: _estado,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(_estado, _cidade);
                          },
                          maxLength: 2,
                          initialValue: _controller.endereco.estado,
                          textCapitalization: TextCapitalization.characters,
                          validator: (value) {
                            if (value.isEmpty) return 'Campo obrigatório';
                            _controller.endereco.estado = value;
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Estado (sigla)',
                            hintText: 'Digite o estado',
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
                        TextFormField(
                          focusNode: _cidade,
                          textCapitalization: TextCapitalization.words,
                          initialValue: _controller.endereco.cidade,
                          validator: (value) {
                            if (value.isEmpty) return 'Campo obrigatório';
                            _controller.endereco.cidade = value;
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Cidade',
                            hintText: 'Digite a cidade',
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
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      returnSplash(context);
                    },
                    color: Theme.of(context).accentColor,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        'Pular',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                    textColor: Color(0xFFFFFFFF),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {
                        _controller
                            .editar()
                            .then((value) => returnSplash(context));
                      },
                      color: Theme.of(context).accentColor,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                          'Prosseguir',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                      textColor: Color(0xFFFFFFFF),
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }

  _fieldFocusChange(FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
