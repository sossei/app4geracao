import 'package:flutter/material.dart';

class Button4Geracao extends StatelessWidget {
  final String title;
  final Function action;
  const Button4Geracao({
    Key key,
    this.title,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.all(4),
      shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(60.0),
          side: BorderSide(color: Colors.black)),
      elevation: 4,
      onPressed: action,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      color: Theme.of(context).accentColor,
      textColor: Color(0xFFFFFFFF),
    );
  }
}
