import 'package:app4geracao/control/nav/nav.dart';
import 'package:app4geracao/control/web/aws.dart';
import 'package:app4geracao/model/barbeiro.dart';
import 'package:app4geracao/pages/administrador/barbeiros/save/save_barbeiro_page.dart';
import 'package:app4geracao/widgets/image_oval.dart';
import 'package:app4geracao/widgets/panel_empty.dart';
import 'package:app4geracao/widgets/panel_error.dart';
import 'package:app4geracao/widgets/panel_requesting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'list_barbeiros_controller.dart';

class ListBarbeiroPage extends StatefulWidget {
  @override
  _ListBarbeiroPageState createState() => _ListBarbeiroPageState();
}

class _ListBarbeiroPageState extends State<ListBarbeiroPage>
    with WidgetsBindingObserver {
  ListBarbeiroController _controller = ListBarbeiroController();
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _controller.fetchData();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _controller.fetchData();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Barbeiros')),
      body: buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          push(context, SaveBarbeiroPage());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Observer buildBody() {
    return Observer(builder: (_) {
      if (_controller.msgErro != null)
        return PanelError(
          msgErro: _controller.msgErro,
          withCard: false,
          descAction: 'Tentar novamente',
          action: () {
            _controller.fetchData();
          },
        );

      if (_controller.isRequesting)
        return PanelRequesting(
          descricao: 'Carregando aguarde...',
          withCard: false,
        );

      if (_controller.barbeiros == null || _controller.barbeiros.isEmpty)
        return PanelEmpty(
          withCard: false,
          action: () {
            _controller.fetchData();
          },
        );
      return _body();
    });
  }

  _body() {
    return ListView.builder(
      itemBuilder: (_, pos) {
        Barbeiro barbeiro = _controller.barbeiros[pos];
        return GestureDetector(
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ListTile(
                  leading: OvalImage(
                      networkurl: barbeiro.urlFoto75,
                      placeholder: 'assets/images/perfil.jpg',
                      size: 48),
                  title: Text(
                    barbeiro.nome,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Trabalhos',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Container(
                  height: 100,
                  child: ListView.builder(
                    itemBuilder: (_, pos) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0),
                          ),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            heightFactor: 0.5,
                            child: Image.network(
                              awss3 + 't75_' + barbeiro.ultimostrabalhos[pos],
                              errorBuilder: (context, obj, _) {
                                return Image.asset(
                                    'assets/images/default_servico.png');
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                    itemCount: barbeiro.ultimostrabalhos.length,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            push(
                context,
                SaveBarbeiroPage(
                  barbeiro: barbeiro,
                ));
          },
          onLongPress: () {
            askDelete(barbeiro);
          },
        );
      },
      itemCount: _controller.barbeiros.length,
      padding: EdgeInsets.all(8),
    );
  }

  askDelete(Barbeiro barbeiro) {
    AlertDialog alert = AlertDialog(
      title: Text("Deletar item"),
      content: Text("Você tem certeza que deseja deletar este item?"),
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
            _controller.deleteItem(barbeiro);
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
