import 'package:flutter/material.dart';

class PanelRequesting extends StatelessWidget {
  final String descricao;
  final bool withCard;
  const PanelRequesting(
      {Key key, this.descricao = 'Carregando', this.withCard = true})
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
      return Padding(
        padding: EdgeInsets.all(16),
        child: _body(),
      );
    }
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
