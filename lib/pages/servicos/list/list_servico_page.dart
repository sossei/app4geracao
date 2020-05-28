import 'package:app4geracao/control/nav/nav.dart';
import 'package:app4geracao/model/servico.dart';
import 'package:app4geracao/model/trabalho.dart';
import 'package:app4geracao/pages/barbeiros/list/list_barbeiro_page.dart';
import 'package:app4geracao/pages/servicos/save/save_servico_page.dart';
import 'list_servico_controller.dart';
import 'package:app4geracao/widgets/image_oval.dart';
import 'package:app4geracao/widgets/panel_empty.dart';
import 'package:app4geracao/widgets/panel_error.dart';
import 'package:app4geracao/widgets/panel_requesting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ListServicoPage extends StatefulWidget {
  final Trabalho trabalho;

  const ListServicoPage({Key key, this.trabalho}) : super(key: key);
  @override
  _ListServicoPageState createState() => _ListServicoPageState();
}

class _ListServicoPageState extends State<ListServicoPage>
    with WidgetsBindingObserver {
  ListServicoController _controller = ListServicoController();
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
      appBar: AppBar(title: Text('Serviços')),
      body: buildBody(),
      floatingActionButton: widget.trabalho != null
          ? null
          : FloatingActionButton(
              onPressed: () {
                push(context, SaveServicoPage())
                    .then((value) => _controller.fetchData());
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

      if (_controller.servicos == null || _controller.servicos.isEmpty)
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
          Servico servico = _controller.servicos[pos];
          return GestureDetector(
            child: Card(
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/default_servico.png',
                    image: servico.urlFoto75,
                    fit: BoxFit.fitWidth,
                    imageErrorBuilder: (context, obj, _) {
                      return Image.asset('assets/images/default_servico.png');
                    },
                  ),
                ),
                title: Text(servico.descricao),
                subtitle: Text('Tempo: ${servico.tempoFormatted}'),
                trailing: Text('R\$ ${servico.valor / 100}'),
              ),
            ),
            onTap: () {
              if (widget.trabalho == null)
                push(
                    context,
                    SaveServicoPage(
                      servico: servico,
                    )).then((value) => _controller.fetchData());
              else {
                widget.trabalho.servico = servico;
                push(
                    context,
                    ListBarbeiroPage(
                      trabalho: widget.trabalho,
                    ));
              }
            },
            onLongPress: () {
              if (widget.trabalho == null) askDelete(servico);
            },
          );
        },
        itemCount: _controller.servicos.length,
        padding: EdgeInsets.all(8),
      ),
    );
  }

  askDelete(Servico servico) {
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
            _controller.deleteItem(servico);
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
