import 'package:app4geracao/control/nav/nav.dart';
import 'package:app4geracao/control/web/aws.dart';
import 'package:app4geracao/model/barbeiro.dart';
import 'package:app4geracao/model/trabalho.dart';
import 'package:app4geracao/pages/barbeiros/save/save_barbeiro_page.dart';
import 'package:app4geracao/pages/calendar/month/calendar_month_page.dart';

import 'package:app4geracao/widgets/image_oval.dart';
import 'package:app4geracao/widgets/panel_empty.dart';
import 'package:app4geracao/widgets/panel_error.dart';
import 'package:app4geracao/widgets/panel_requesting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'list_barbeiros_controller.dart';

class ListBarbeiroPage extends StatefulWidget {
  final Trabalho trabalho;

  const ListBarbeiroPage({Key key, this.trabalho}) : super(key: key);
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
      floatingActionButton: widget.trabalho != null
          ? null
          : FloatingActionButton(
              onPressed: () {
                push(context, SaveBarbeiroPage())
                    .then((value) => _controller.fetchData());
              },
              child: Icon(FontAwesome.plus),
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
    return RefreshIndicator(
      onRefresh: () => _controller.fetchData(),
      child: ListView.builder(
        itemBuilder: (_, pos) {
          Barbeiro barbeiro = _controller.barbeiros[pos];
          return GestureDetector(
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/perfil.jpg',
                        image: barbeiro.urlFoto75,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, obj, _) {
                          return Image.asset('assets/images/perfil.jpg');
                        },
                      ),
                    ),
                    title: Text(
                      barbeiro.nome,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Trabalhos',
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
              if (widget.trabalho != null) widget.trabalho.barbeiro = barbeiro;
              push(
                      context,
                      widget.trabalho != null
                          ? CalendarMonthPage(
                              trabalho: widget.trabalho,
                            )
                          : SaveBarbeiroPage(
                              barbeiro: barbeiro,
                            ))
                  .then((value) => _controller.fetchData());
            },
            onLongPress: () {
              if (widget.trabalho == null) askDelete(barbeiro);
            },
          );
        },
        itemCount: _controller.barbeiros.length,
        padding: EdgeInsets.all(8),
      ),
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
