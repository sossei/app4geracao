import 'package:app4geracao/control/nav/nav.dart';
import 'package:app4geracao/control/web/aws.dart';
import 'package:app4geracao/model/barbeiro.dart';
import 'package:app4geracao/pages/administrador/barbeiros/save/save_barbeiro_controller.dart';
import 'package:app4geracao/widgets/panel_error.dart';
import 'package:app4geracao/widgets/panel_requesting.dart';
import 'package:app4geracao/widgets/panel_uploadimage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SaveBarbeiroPage extends StatefulWidget {
  final Barbeiro barbeiro;

  const SaveBarbeiroPage({Key key, this.barbeiro}) : super(key: key);
  @override
  _SaveBarbeiroPageState createState() => _SaveBarbeiroPageState(barbeiro);
}

class _SaveBarbeiroPageState extends State<SaveBarbeiroPage> {
  SaveBarbeiroController _controller = SaveBarbeiroController();
  final Barbeiro barbeiro;
  _SaveBarbeiroPageState(this.barbeiro);
  @override
  void initState() {
    if (barbeiro != null) _controller.setBarbeiro(barbeiro);
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
                        _controller.barbeiro.foto = url.replaceAll("\"", '');
                      },
                      initImage: _controller.barbeiro.foto == null
                          ? null
                          : awss3 + 't150_' + _controller.barbeiro.foto,
                      placeHolder: 'assets/images/perfil.jpg',
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      initialValue: _controller.barbeiro.nome,
                      onFieldSubmitted: (term) {
                        FocusScope.of(context).unfocus();
                      },
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value.isEmpty) return 'Campo obrigatório';
                        _controller.barbeiro.nome = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Nome do barbeiro',
                        labelStyle:
                            TextStyle(color: Theme.of(context).accentColor),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF402719),
                          ),
                        ),
                        labelText: 'Nome',
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
}
