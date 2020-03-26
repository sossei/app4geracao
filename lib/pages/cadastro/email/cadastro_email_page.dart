import 'package:flutter/material.dart';

class CadastroEmailPage extends StatefulWidget {
  @override
  _CadastroEmailPageState createState() => _CadastroEmailPageState();
}

class _CadastroEmailPageState extends State<CadastroEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Form(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Digite seu e-mail',
                          labelStyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF402719),
                            ),
                          ),
                          labelText: 'E-mail',
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Nome',
                          hintText: 'Digite seu nome',
                          labelStyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF402719),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Sobrenome',
                          hintText: 'Digite seu sobrenome',
                          labelStyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF402719),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          hintText: 'Digite sua senha',
                          labelStyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF402719),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                print('Fazer requisição de cadastro');
              },
              color: Theme.of(context).accentColor,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'Prosseguir',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              textColor: Color(0xFFFFFFFF),
            )
          ],
        )),
      ),
    );
  }
}
