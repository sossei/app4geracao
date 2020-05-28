import 'package:app4geracao/control/nav/nav.dart';
import 'package:app4geracao/model/trabalho.dart';
import 'package:app4geracao/pages/cliente/list_cliente_page.dart';
import 'package:app4geracao/pages/trabalho/add/add_trab_page.dart';
import 'package:app4geracao/pages/trabalho/trabalho_detalhes_page.dart';
import 'package:app4geracao/widgets/button_4geracao.dart';
import 'package:app4geracao/widgets/panel_error.dart';
import 'package:app4geracao/widgets/panel_requesting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'list_trabalho_controller.dart';

class ListTrabalhoPage extends StatefulWidget {
  @override
  _ListTrabalhoPageState createState() => _ListTrabalhoPageState();
}

class _ListTrabalhoPageState extends State<ListTrabalhoPage> {
  ListTrabalhoController _controller = ListTrabalhoController();
  @override
  void initState() {
    _controller.fecthData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text(
            'Agendamentos',
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          trailing: Observer(builder: (_) {
            if (_controller.isFiltered) {
              return InkWell(
                child: Icon(
                  Icons.check_box,
                  color: Colors.white,
                ),
                onTap: () {
                  _controller.setFilter(false);
                },
              );
            }
            return InkWell(
              child: Icon(
                Icons.check_box_outline_blank,
                color: Colors.white,
              ),
              onTap: () {
                _controller.setFilter(true);
              },
            );
          }),
        ),
      ),
      body: _body(),
    );
  }

  _buildError() {
    return Center(
      child: PanelError(
        withCard: false,
        msgErro: _controller.msgErro,
        descAction: 'OK',
        action: () {
          _controller.setMsgErro(null);
        },
      ),
    );
  }

  _builEmpty() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(
            Icons.error_outline,
            color: Colors.grey,
            size: 48,
          ),
          SizedBox(height: 24),
          Text(
            'Não foram encontrados agendamentos para hoje',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24),
          Button4Geracao(
              title: 'Atualizar',
              action: () {
                _controller.fecthData();
              }),
        ],
      ),
    );
  }

  _buildRequesting() {
    return Center(
        child: PanelRequesting(
      descricao: 'Carregando...',
      withCard: false,
    ));
  }

  _body() {
    return Observer(
      builder: (_) {
        return _controller.msgErro != null
            ? _buildError()
            : _controller.isRequesting ? _buildRequesting() : _bodyPanel();
      },
    );
  }

  _bodyPanel() {
    return Observer(builder: (_) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ListTile(
                trailing: InkWell(
                  child: Text('Hoje'),
                  onTap: () {
                    _controller.setData(DateTime.now());
                  },
                ),
                title: InkWell(
                  onTap: () async {
                    final DateTime picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020, 5),
                        lastDate: DateTime(2024));
                    _controller.setData(picked);
                  },
                  child: Text(
                    _controller.dataFormatted,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
          ),
          Expanded(
            child: _controller.trabalhos.isEmpty
                ? _builEmpty()
                : ListView.builder(
                    itemBuilder: (_, pos) {
                      Trabalho trabalho = _controller.trabalhos[pos];
                      bool isOld = trabalho.trabTimestamp <
                          DateTime.now().millisecondsSinceEpoch;
                      if (_controller.isFiltered && isOld) return Container();
                      return Card(
                          color: isOld
                              ? Colors.blueGrey.withOpacity(0.3)
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(16.0),
                          ),
                          elevation: 4,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: ListTile(
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) {
                                      return Container(
                                        child: TrabalhoDetahePage(
                                          trabalho: trabalho,
                                        ),
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20))),
                                      );
                                    });
                              },
                              leading: ClipOval(
                                child: Container(
                                  color: Theme.of(context).primaryColor,
                                  child: Image.network(
                                    trabalho.servico.urlFoto75,
                                    height: 36,
                                    width: 36,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Text(
                                '${trabalho.usuario.nome} ${trabalho.usuario.sobrenome}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      '${trabalho.servico.descricao} (R\$ ${trabalho.servico.valorFormatted})'),
                                  Text(
                                    trabalho.barbeiro.nome,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    trabalho.timeFormatted,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  Text('Tempo: ${trabalho.servico.tempo} min',
                                      style: TextStyle(fontSize: 12)),
                                ],
                              ),
                            ),
                          ));
                    },
                    itemCount: _controller.trabalhos.length,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Button4Geracao(
                title: 'Adicionar',
                action: () {
                  push(context, ListClientePage());
                }),
          ),
        ],
      );
    });
  }
}
