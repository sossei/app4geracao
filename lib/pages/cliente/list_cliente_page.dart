import 'package:app4geracao/control/nav/nav.dart';
import 'package:app4geracao/model/usuario.dart';
import 'package:app4geracao/pages/cadastro/cadastro_page.dart';
import 'package:app4geracao/pages/servicos/save/save_servico_page.dart';
import 'package:app4geracao/pages/trabalho/add/add_trab_page.dart';
import 'package:app4geracao/widgets/panel_empty.dart';
import 'package:app4geracao/widgets/panel_error.dart';
import 'package:app4geracao/widgets/panel_requesting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'list_cliente_controller.dart';

class ListClientePage extends StatefulWidget {
  const ListClientePage({Key key}) : super(key: key);
  @override
  _ListClientePageState createState() => _ListClientePageState();
}

class _ListClientePageState extends State<ListClientePage>
    with WidgetsBindingObserver {
  ListClienteController _controller = ListClienteController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
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
      appBar: AppBar(title: Text('Clientes')),
      body: buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          push(context, CadastroPage())
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

      if (_controller.usuarios == null || _controller.usuarios.isEmpty)
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
    return Column(
      children: <Widget>[
        Card(
          child: TextField(
            cursorColor: Colors.black,
            decoration: InputDecoration(
                hintText: 'Pesquisar',
                labelStyle: TextStyle(color: Color(0xFF261610)),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                suffixIcon: Icon(FontAwesome.search)),
            onChanged: (value) {
              _controller.filtrar(value);
            },
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () => _controller.fetchData(),
            child: ListView.builder(
              itemBuilder: (_, pos) {
                Usuario usuario = _controller.usuarios[pos];
                if (_controller.filter != null &&
                    _controller.filter.isNotEmpty) {
                  if (!usuario.nome
                      .toLowerCase()
                      .contains(_controller.filter.toLowerCase()))
                    return Container();
                }
                if (usuario.estabelecimento != null) return Container();
                return GestureDetector(
                  child: Card(
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/perfil.jpg',
                          image: usuario.urlFoto75,
                          fit: BoxFit.fitWidth,
                          imageErrorBuilder: (context, obj, _) {
                            return Image.asset('assets/images/perfil.jpg');
                          },
                        ),
                      ),
                      title: Text(usuario.nome),
                      subtitle: Text('Email: ${usuario.email}'),
                      trailing: Text(usuario.telefone),
                    ),
                  ),
                  onTap: () {
                    push(context, AddTrabPage(usuario: usuario));
                  },
                );
              },
              itemCount: _controller.usuarios.length,
              padding: EdgeInsets.all(8),
            ),
          ),
        ),
      ],
    );
  }
}
