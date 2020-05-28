import 'package:app4geracao/pages/perfil/edit/address/edit_address_controller.dart';
import 'package:app4geracao/widgets/panel_error.dart';
import 'package:app4geracao/widgets/panel_requesting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class EditAddressPage extends StatefulWidget {
  @override
  _EditAddressPageState createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage>
    with TickerProviderStateMixin {
  EditAddressController _controller = EditAddressController();
  final FocusNode _rua = FocusNode();
  final FocusNode _numero = FocusNode();
  final FocusNode _estado = FocusNode();
  final FocusNode _cidade = FocusNode();
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
        title: Observer(builder: (_) {
          return Text('Editar endereço');
        }),
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
                descricao: 'Efetuando cadastro....',
                withCard: false,
              )
            : _buildFormEndereco();
    return FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(animationController),
        child: child);
  }

  _buildFormEndereco() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Form(
            key: _controller.form,
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
                              labelStyle: TextStyle(
                                  color: Theme.of(context).accentColor),
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
                              labelStyle: TextStyle(
                                  color: Theme.of(context).accentColor),
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
                              labelStyle: TextStyle(
                                  color: Theme.of(context).accentColor),
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
                              labelStyle: TextStyle(
                                  color: Theme.of(context).accentColor),
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
                    _controller.save().then((value) async {
                      Navigator.pop(context);
                    });
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
              ],
            )),
      ),
    );
  }

  _fieldFocusChange(FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
