import 'dart:convert';

import 'package:app4geracao/control/nav/nav.dart';
import 'package:app4geracao/control/web/aws.dart';
import 'package:app4geracao/model/barbeiro.dart';
import 'package:app4geracao/model/servico.dart';
import 'package:app4geracao/model/trabalho.dart';
import 'package:app4geracao/model/usuario.dart';
import 'package:app4geracao/pages/calendar/addevent/list_calendar_page.dart';
import 'package:app4geracao/widgets/image_oval.dart';
import 'package:app4geracao/widgets/panel_requesting.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CliAddTrabPage extends StatefulWidget {
  final Trabalho trabalho;

  const CliAddTrabPage({Key key, this.trabalho}) : super(key: key);
  @override
  CliAddTrabPageState createState() => CliAddTrabPageState();
}

class CliAddTrabPageState extends State<CliAddTrabPage> {
  bool isRequesting = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - 150;
    if (isRequesting)
      return Center(
          child: PanelRequesting(
        descricao: 'Salvando aguarde...',
      ));

    return Container(
      constraints: new BoxConstraints(
        minHeight: 100.0,
        maxHeight: height,
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  panelTrabalho(),
                  Divider(),
                  panelCliente(),
                  Divider(),
                  panelBarbeiro(),
                  Divider(),
                  panelServico(),
                ],
              ),
            ),
          ),
          buttonSalvar(),
        ],
      ),
    );
  }

  void _showDialogError() {
    Navigator.pop(context);
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Falha ao salvar"),
          content: new Text(
              "Ocorreu uma falha ao savar seu agendamento tente novamente"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  adicionarEventoCalendario() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Seu calendário"),
          content: new Text(
              "Deseja criar um evento em seu calendario, para te lembrar?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Sim"),
              onPressed: () {
                push(context, ListCalendarPage(trabalho: widget.trabalho))
                    .then((value) => returnSplash(context));
              },
            ),
            new FlatButton(
              child: new Text("Não"),
              onPressed: () {
                returnSplash(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget buttonSalvar() {
    return RaisedButton(
      onPressed: () {
        isRequesting = true;
        setState(() {});
        try {
          salvar();
        } catch (e, s) {
          debugPrint('$e - $s');
          _showDialogError();
        }
      },
      color: Theme.of(context).accentColor,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Text(
          'Finalizar',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      textColor: Color(0xFFFFFFFF),
    );
  }

  Widget panelCliente() {
    Usuario usu = widget.trabalho.usuario;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Cliente',
          style: textStyleBold(),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: <Widget>[
            OvalImage(
              networkurl: usu.urlFoto75,
              size: 40,
              placeholder: 'assets/images/perfil.jpg',
            ),
            SizedBox(
              width: 8,
            ),
            Text('${usu.nome} ${usu.sobrenome}')
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'Email: ${usu.email}',
          style: textStyleBold(size: 14),
        ),
        Text(
          'Telefone: ${usu.telefone}',
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget panelBarbeiro() {
    Barbeiro barb = widget.trabalho.barbeiro;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Barbeiro',
          style: textStyleBold(),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: <Widget>[
            OvalImage(
              networkurl: barb.urlFoto75,
              size: 40,
              placeholder: 'assets/images/perfil.jpg',
            ),
            SizedBox(
              width: 8,
            ),
            Text('${barb.nome} ')
          ],
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget panelServico() {
    Servico serv = widget.trabalho.servico;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Serviço',
          style: textStyleBold(),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: <Widget>[
            OvalImage(
              networkurl: serv.urlFoto75,
              size: 40,
              placeholder: 'assets/images/default_servico.png',
            ),
            SizedBox(
              width: 8,
            ),
            Text('${serv.descricao}')
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Text('Tempo: ${serv.tempo} min'),
        SizedBox(
          height: 8,
        ),
        Text(
          'Valor: R\$ ${serv.valorFormatted}',
          style: textStyleBold(size: 22),
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget panelTrabalho() {
    Trabalho trab = widget.trabalho;
    DateTime init = DateTime.fromMillisecondsSinceEpoch(trab.trabTimestamp);
    DateTime end = init.add(Duration(minutes: trab.servico.tempo));
    DateFormat df = DateFormat('dd/MM/yyyy HH:mm');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Agendamento',
          style: textStyleBold(),
        ),
        SizedBox(
          height: 8,
        ),
        Text('Inicio: ${df.format(init)}'),
        Text('Fim: ${df.format(end)}'),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  textStyleBold({double size = 18}) {
    return TextStyle(fontWeight: FontWeight.bold, fontSize: size);
  }

  salvar() async {
    try {
      String url = '$awsurl/trabalho/save';
      String json = jsonEncode(widget.trabalho.toJsonWeb());
      var response = await http
          .post(url,
              headers: awskey,
              body: json,
              encoding: Encoding.getByName('utf-8'))
          .timeout(Duration(seconds: 15));
      getResponse(response);
      adicionarEventoCalendario();
    } catch (e, s) {
      debugPrint('$e - $s');
      _showDialogError();
    }
  }
}
