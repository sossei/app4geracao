import 'dart:convert';

import 'package:app4geracao/control/nav/nav.dart';
import 'package:app4geracao/control/web/aws.dart';
import 'package:app4geracao/model/barbeiro.dart';
import 'package:app4geracao/model/servico.dart';
import 'package:app4geracao/model/trabalho.dart';
import 'package:app4geracao/model/usuario.dart';
import 'package:app4geracao/widgets/image_oval.dart';
import 'package:app4geracao/widgets/panel_uploadimage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TrabalhoDetahePage extends StatefulWidget {
  final Trabalho trabalho;

  const TrabalhoDetahePage({Key key, this.trabalho}) : super(key: key);
  @override
  _TrabalhoDetahePageState createState() => _TrabalhoDetahePageState();
}

class _TrabalhoDetahePageState extends State<TrabalhoDetahePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - 150;
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

  Widget buttonSalvar() {
    return RaisedButton(
      onPressed: () {
        askTrabalho();
      },
      color: Theme.of(context).accentColor,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Text(
          'Cancelar',
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
        _panelFeedback(trab),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  _panelFeedback(trab) {
    if (!trab.isFinished) return Container();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Divider(),
        Text(
          'Feedback',
          style: textStyleBold(),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'Comentário do cliente:',
          style: textStyleBold(),
        ),
        Text(
          '${trab.feedback ?? 'Nenhum'}',
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'Nota:',
          style: textStyleBold(),
        ),
        ratingBar(trab),
        SizedBox(
          height: 8,
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Text('Antes: '),
                  UploadImageWidget(
                    size: 100,
                    initImage: trab.antes,
                    onImageUploaded: (fileName) {
                      trab.antes = fileName;
                      salvar();
                    },
                    placeHolder: 'assets/images/perfil.jpg',
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Text('Depois: '),
                  UploadImageWidget(
                    size: 100,
                    initImage: trab.depois,
                    onImageUploaded: (fileName) {
                      trab.depois = fileName;
                      salvar();
                    },
                    placeHolder: 'assets/images/perfil.jpg',
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  ratingBar(trab) {
    return RatingBar(
      initialRating: double.parse(trab.rating.toString()) ?? 0,
      itemCount: 5,
      allowHalfRating: false,
      ignoreGestures: true,
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return Icon(
              Icons.star,
              color: Colors.yellow,
            );
          case 1:
            return Icon(
              Icons.star,
              color: Colors.yellow,
            );
          case 2:
            return Icon(
              Icons.star,
              color: Colors.yellow,
            );
          case 3:
            return Icon(
              Icons.star,
              color: Colors.yellow,
            );
          case 4:
            return Icon(
              Icons.star,
              color: Colors.yellow,
            );
        }
      },
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }

  textStyleBold({double size = 18}) {
    return TextStyle(fontWeight: FontWeight.bold, fontSize: size);
  }

  salvar() async {
    String url = '$awsurl/trabalho/save';
    String json = jsonEncode(widget.trabalho.toJsonWeb());
    var response = await http
        .post(url,
            headers: awskey, body: json, encoding: Encoding.getByName('utf-8'))
        .timeout(Duration(seconds: 15));
    getResponse(response);
  }

  cancelar() async {
    String url = '$awsurl/trabalho/delete';
    String json = jsonEncode({'trabTimestamp': widget.trabalho.trabTimestamp});
    var response = await http
        .post(url,
            headers: awskey, body: json, encoding: Encoding.getByName('utf-8'))
        .timeout(Duration(seconds: 15));
    getResponse(response);
    pop(context);
  }

  askTrabalho() {
    AlertDialog alert = AlertDialog(
      title: Text("Cancelar agendamento"),
      content: Text(
          "Tem certeza que deseja cancelar este agendamento? Este cancelamento não poderá ser restaurado."),
      actions: [
        FlatButton(
          child: Text("Cancelar"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("Sim"),
          onPressed: () {
            cancelar();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
