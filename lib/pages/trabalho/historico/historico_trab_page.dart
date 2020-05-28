import 'package:app4geracao/model/trabalho.dart';
import 'package:app4geracao/pages/trabalho/historico/historico_trab_controller.dart';
import 'package:app4geracao/widgets/panel_error.dart';
import 'package:app4geracao/widgets/panel_requesting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouped_list/grouped_list.dart';

import '../trabalho_detalhes_page.dart';

class HistoricoTrabPage extends StatefulWidget {
  @override
  _HistoricoTrabPageState createState() => _HistoricoTrabPageState();
}

class _HistoricoTrabPageState extends State<HistoricoTrabPage> {
  HistoricoTrabController _controller = HistoricoTrabController();
  @override
  void initState() {
    _controller.fecthData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Histórico')),
      body: body(),
    );
  }

  Widget body() {
    return Observer(builder: (_) {
      if (_controller.msgErro != null) return error();
      if (_controller.isRequesting) return loading();
      return main();
    });
  }

  Widget loading() {
    return Center(
        child: PanelRequesting(
      descricao: 'Carregando...',
      withCard: false,
    ));
  }

  Widget error() {
    return Center(
        child: PanelError(
      msgErro: _controller.msgErro,
      action: () => _controller.fecthData(),
    ));
  }

  Widget main() {
    return RefreshIndicator(
        child: GroupedListView<Trabalho, String>(
          elements: _controller.trabalhos,
          groupBy: (trab) => trab.justDateFormatted,
          groupSeparatorBuilder: _buildGroupSeparator,
          itemBuilder: (context, trab) => buildItem(trab),
          order: GroupedListOrder.ASC,
        ),
        onRefresh: () => _controller.fecthData());
  }

  Widget _buildGroupSeparator(String groupByValue) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '$groupByValue',
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
      ),
    );
  }

  Widget buildItem(Trabalho trabalho) {
    return Card(
      child: ListTile(
        onTap: (){
           showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return Container(
                  child: TrabalhoDetahePage(
                    trabalho: trabalho,canCancel:false,
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
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/images/default_servico.png',
            image: trabalho.servico.urlFoto75,
            fit: BoxFit.fitWidth,
            imageErrorBuilder: (context, obj, _) {
              return Image.asset('assets/images/default_servico.png');
            },
          ),
        ),
        title: Text(
            '${trabalho.servico.descricao} (R\$ ${trabalho.servico.valorFormatted})'),
        subtitle: Text(
          trabalho.barbeiro.nome,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              trabalho.timeFormatted,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Text('Tempo: ${trabalho.servico.tempo} min',
                style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
