import 'package:app4geracao/pages/perfil/edit/edit_perfil_controller.dart';
import 'package:app4geracao/widgets/panel_error.dart';
import 'package:app4geracao/widgets/panel_requesting.dart';
import 'package:app4geracao/widgets/panel_uploadimage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EditPerfilpage extends StatefulWidget {
  @override
  _EditPerfilpageState createState() => _EditPerfilpageState();
}

class _EditPerfilpageState extends State<EditPerfilpage>
    with TickerProviderStateMixin {
  EditPerfilController _controller = EditPerfilController();

  final FocusNode _telefone = FocusNode();
  final FocusNode _nome = FocusNode();
  final FocusNode _sobrenome = FocusNode();
  final FocusNode _dataNascimento = FocusNode();
  final maskCelular = MaskTextInputFormatter(
      mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});
  final maskDataNascimento = MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});
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
        title: Text('Editar perfil'),
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
                descricao: 'Editando...',
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
                        Text('Foto'),
                        UploadImageWidget(
                          initImage: _controller.usuario.urlFoto480,
                          onImageUploaded: (url) {
                            _controller.usuario.fotoPerfil =
                                url.replaceAll("\"", '');
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          focusNode: _telefone,
                          inputFormatters: [maskCelular],
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(_telefone, _nome);
                          },
                          keyboardType: TextInputType.phone,
                          initialValue: _controller.usuario.telefone,
                          validator: (value) {
                            value = maskCelular.getUnmaskedText();
                            if (value.isEmpty) return 'Campo obrigatório';
                            if (value.length < 11)
                              return 'Celulcar inválido. Exemplo correto: (12) 12345-6789';
                            _controller.usuario.telefone =
                                maskCelular.getMaskedText();
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: '(12) 12345-6789',
                            labelStyle:
                                TextStyle(color: Theme.of(context).accentColor),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF402719),
                              ),
                            ),
                            labelText: 'Celular',
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
                            _fieldFocusChange(_sobrenome, _dataNascimento);
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
                          focusNode: _dataNascimento,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.datetime,
                          initialValue: _controller.usuario.dataNascimento,
                          validator: (value) {
                            value = maskDataNascimento.getUnmaskedText();
                            if (value.isEmpty) return 'Campo obrigatório';
                            _controller.usuario.dataNascimento =
                                maskDataNascimento.getMaskedText();
                            return null;
                          },
                          inputFormatters: [maskDataNascimento],
                          decoration: InputDecoration(
                            labelText: 'Data nascimento',
                            hintText: '00/00/0000',
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
                  _controller.save();
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
