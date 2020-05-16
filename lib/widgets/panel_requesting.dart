import 'package:flutter/material.dart';

import 'button_4geracao.dart';

class PanelRequesting extends StatelessWidget {
  final String descricao;

  const PanelRequesting({
    Key key,
    this.descricao = 'Carregando',
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
  }

  _body() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        SizedBox(
          height: 24,
        ),
        Text(descricao),
      ],
    );
  }
}
