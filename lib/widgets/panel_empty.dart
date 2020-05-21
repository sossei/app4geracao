import 'package:flutter/material.dart';

import 'button_4geracao.dart';

class PanelEmpty extends StatelessWidget {
  final String descricao;
  final Function action;
  final String descAction;
  final bool withCard;
  const PanelEmpty(
      {Key key,
      this.descricao = 'OOPs! Não foi encontrado nenhum dado',
      this.action,
      this.descAction = 'Tentar novamente',
      this.withCard = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (withCard) {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(16.0),
        ),
        elevation: 4,
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: _body(),
        ),
      );
    } else {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: _body(),
        ),
      );
    }
  }

  _body() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Icon(
          Icons.announcement,
          size: 48,
        ),
        SizedBox(height: 24),
        Text(
          descricao,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 24),
        Button4Geracao(
          title: descAction,
          action: action,
        )
      ],
    );
  }
}
