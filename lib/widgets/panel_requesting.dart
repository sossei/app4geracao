import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
      children: <Widget>[
        SpinKitFadingCube(
          color: Color(0xFF5B4D33),
          size: 50.0,
        ),
        SizedBox(
          height: 24,
        ),
        Text(descricao,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            )),
      ],
    );
  }
}
