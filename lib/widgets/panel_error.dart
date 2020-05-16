import 'package:flutter/material.dart';

import 'button_4geracao.dart';

class PanelError extends StatelessWidget {
  final String msgErro;
  final Function action;
  final String descAction;
  final bool withCard;
  const PanelError(
      {Key key,
      this.msgErro,
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 48,
        ),
        SizedBox(height: 24),
        Text(
          msgErro,
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
