import 'package:app4geracao/control/nav/nav.dart';
import 'package:app4geracao/control/web/aws.dart';
import 'package:app4geracao/model/servico.dart';
import 'package:app4geracao/pages/administrador/servicos/save/save_servico_controller.dart';
import 'package:app4geracao/widgets/panel_error.dart';
import 'package:app4geracao/widgets/panel_requesting.dart';
import 'package:app4geracao/widgets/panel_uploadimage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

class SaveServicoPage extends StatefulWidget {
  final Servico servico;

  const SaveServicoPage({Key key, this.servico}) : super(key: key);
  @override
  _SaveServicoPageState createState() => _SaveServicoPageState(servico);
}

class _SaveServicoPageState extends State<SaveServicoPage> {
  SaveServicoController _controller = SaveServicoController();
  final Servico servico;

  final FocusNode _descricao = FocusNode();
  final FocusNode _tempo = FocusNode();
  final FocusNode _valor = FocusNode();
  MoneyMaskedTextController lowPrice =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  _SaveServicoPageState(this.servico);
  @override
  void initState() {
    if (servico != null) _controller.setServico(servico);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de serviço')),
      body: buildBody(),
    );
  }

  buildBody() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Observer(builder: (_) {
        if (_controller.msgErro != null)
          return PanelError(
            msgErro: _controller.msgErro,
            withCard: false,
            descAction: 'Tentar novamente',
            action: () {
              _controller.setMsgErro(null);
            },
          );

        if (_controller.isRequesting)
          return PanelRequesting(
            descricao: 'Carregando aguarde...',
            withCard: false,
          );

        return _body();
      }),
    );
  }

  _body() {
    lowPrice = MoneyMaskedTextController(
        leftSymbol: 'R\$ ',
        initialValue: _controller.servico.valor == null
            ? 0.0
            : _controller.servico.valor.toDouble() / 100,
        decimalSeparator: '.',
        thousandSeparator: ',');

    return Form(
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
                    SizedBox(
                      height: 32,
                    ),
                    Text('Foto'),
                    UploadImageWidget(
                      onImageUploaded: (url) {
                        _controller.servico.foto = url.replaceAll("\"", '');
                      },
                      initImage: _controller.servico.foto == null
                          ? null
                          : awss3 + 't512_' + _controller.servico.foto,
                      placeHolder: 'assets/images/default_servico.png',
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    TextFormField(
                      focusNode: _descricao,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(_descricao, _tempo);
                      },
                      initialValue: _controller.servico.descricao,
                      textCapitalization: TextCapitalization.sentences,
                      validator: (value) {
                        if (value.isEmpty) return 'Campo obrigatório';
                        _controller.servico.descricao = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Descrição do serviço',
                        labelStyle:
                            TextStyle(color: Theme.of(context).accentColor),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF402719),
                          ),
                        ),
                        labelText: 'Descrição',
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      focusNode: _tempo,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(_tempo, _valor);
                      },
                      initialValue: _controller.servico.tempo == null
                          ? null
                          : _controller.servico.tempo.toString(),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) return 'Campo obrigatório';
                        _controller.servico.tempo = int.parse(value);
                        return null;
                      },
                      maxLength: 4,
                      decoration: InputDecoration(
                        hintText: 'Tempo do serviço em minutos',
                        labelStyle:
                            TextStyle(color: Theme.of(context).accentColor),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF402719),
                          ),
                        ),
                        labelText: 'Tempo',
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: lowPrice,
                      focusNode: _valor,
                      onFieldSubmitted: (term) {
                        FocusScope.of(context).unfocus();
                      },
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) return 'Campo obrigatório';
                        _controller.servico.valor =
                            lowPrice.numberValue.round() * 100;
                        return null;
                      },
                      onChanged: (value) {
                        _controller.servico.valor =
                            lowPrice.numberValue.round() * 100;
                      },
                      decoration: InputDecoration(
                        hintText: 'Valor do serviço',
                        labelStyle:
                            TextStyle(color: Theme.of(context).accentColor),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF402719),
                          ),
                        ),
                        labelText: 'Valor',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {
              _controller.save().then((value) {
                if (value) pop(context);
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
      ),
    );
  }

  _fieldFocusChange(FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      print(true);
      return newValue;
    }
    double value = double.parse(newValue.text);

    final formatter = new NumberFormat("###,###.##", "pt-br");

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
