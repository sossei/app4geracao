import 'package:app4geracao/control/nav/nav.dart';
import 'package:app4geracao/pages/trabalho/add/add_trab_page.dart';
import 'package:app4geracao/pages/trabalho/atual/trabalho_controller.dart';
import 'package:app4geracao/widgets/image_oval.dart';
import 'package:app4geracao/widgets/panel_error.dart';
import 'package:app4geracao/widgets/panel_requesting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TrabalhoPage extends StatefulWidget {
  @override
  _TrabalhoPageState createState() => _TrabalhoPageState();
}

class _TrabalhoPageState extends State<TrabalhoPage>
    with TickerProviderStateMixin {
  TrabalhoController _controller = TrabalhoController();
  AnimationController animationController;
  @override
  void initState() {
    _controller.fetchData();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    animationController.forward(from: 0.0);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Stack(
        children: <Widget>[
          Container(
            height: 180,
            color: Theme.of(context).primaryColor,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Barber 4°',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(25),
                  decoration: new BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 1,
                          offset: Offset(2, 4),
                          spreadRadius: 2,
                        )
                      ],
                      borderRadius: new BorderRadius.all(Radius.circular(25.0)),
                      shape: BoxShape.rectangle,
                      color: Colors.white),
                  child: Observer(builder: (_) {
                    animationController.forward(from: 0.0);
                    Widget child = _controller.msgErro != null
                        ? buildError()
                        : _controller.isRequesting
                            ? buildLoading()
                            : _controller.trabalho == null
                                ? naoTemTrabalho()
                                : _controller.trabalho.isFinished
                                    ? trabalhoFinalizado()
                                    : trabalhoAberto();
                    return FadeTransition(
                        opacity: Tween(begin: 0.0, end: 1.0)
                            .animate(animationController),
                        child: child);
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildLoading() {
    return Center(
        child: PanelRequesting(
      descricao: 'Carregando...',
      withCard: false,
    ));
  }

  Widget buildError() {
    return Center(
        child: PanelError(
      msgErro: _controller.msgErro,
      action: () {
        _controller.fetchData();
      },
      withCard: false,
    ));
  }

  Widget trabalhoAberto() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              FontAwesome.calendar,
              size: 48,
              color: Colors.grey,
            ),
            Text(
              _controller.trabalho.dateFormatted,
              style: Theme.of(context).textTheme.headline1.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              _controller.trabalho.barbeiro.nome,
              style: Theme.of(context).textTheme.headline1.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                height: 100,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(blurRadius: 4, color: Colors.black.withOpacity(0.5))
                ]),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/perfil.jpg',
                  image: _controller.trabalho.barbeiro.urlFoto150,
                  fit: BoxFit.fitWidth,
                  imageErrorBuilder: (context, obj, _) {
                    return Image.asset(
                      'assets/images/perfil.jpg',
                      fit: BoxFit.fitWidth,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              _controller.trabalho.servico.descricao,
              style: Theme.of(context).textTheme.headline1.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                height: 100,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(blurRadius: 4, color: Colors.black.withOpacity(0.5))
                ]),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/default_service.png',
                  image: _controller.trabalho.servico.urlFoto150,
                  fit: BoxFit.fitWidth,
                  imageErrorBuilder: (context, obj, _) {
                    return Image.asset(
                      'assets/images/default_servico.png',
                      fit: BoxFit.fitWidth,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        Spacer(),
        Container(
          child: Text(
            'Detalhes',
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headline1.copyWith(
                color: Theme.of(context).primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Theme.of(context).primaryColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Tempo ${_controller.trabalho.servico.tempo} min',
                style: Theme.of(context).textTheme.headline1.copyWith(
                    color: Theme.of(context).primaryColor, fontSize: 18),
              ),
              Text(
                'R\$ ${_controller.trabalho.servico.valorFormatted}',
                style: Theme.of(context).textTheme.headline1.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Spacer(),
      ],
    );
  }

  Widget trabalhoFinalizado() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      FontAwesome.check_circle,
                      size: 48,
                      color: Colors.green[400],
                    ),
                    Text(
                      _controller.trabalho.dateFormatted,
                      style: Theme.of(context).textTheme.headline1.copyWith(
                          color: Colors.green[400],
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                ListTile(
                  title: Text(_controller.trabalho.servico.descricao),
                  subtitle: Text('${_controller.trabalho.servico.tempo} min'),
                  trailing: Text(
                      'R\$ ${_controller.trabalho.servico.valorFormatted}'),
                  leading: OvalImage(
                    networkurl: _controller.trabalho.servico.urlFoto150,
                    placeholder: 'assets/images/default_servico.png',
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(_controller.trabalho.barbeiro.nome),
                  leading: OvalImage(
                    networkurl: _controller.trabalho.barbeiro.urlFoto150,
                    placeholder: 'assets/images/perfil.jpg',
                  ),
                ),
                Divider(),
                Text(
                  'Feedback',
                  style: TextStyle(fontSize: 22),
                ),
                Text('Qual sua nota?'),
                RatingBar(
                  onRatingUpdate: (rating) {
                    _controller.trabalho.rating = rating.round();
                  },
                  initialRating: 5,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemSize: 48,
                  minRating: 1,
                  maxRating: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Icon(
                          FontAwesome.star,
                          color: Colors.yellow,
                        );
                      case 1:
                        return Icon(
                          FontAwesome.star,
                          color: Colors.yellow,
                        );
                      case 2:
                        return Icon(
                          FontAwesome.star,
                          color: Colors.yellow,
                        );
                      case 3:
                        return Icon(
                          FontAwesome.star,
                          color: Colors.yellow,
                        );
                      case 4:
                        return Icon(
                          FontAwesome.star,
                          color: Colors.yellow,
                        );
                    }
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                Text('Deixe-nos seu comentário'),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Digite seu comentário',
                    labelStyle: TextStyle(color: Color(0xFF261610)),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF402719),
                      ),
                    ),
                    labelText: 'Comentário',
                  ),
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: null,
                  onChanged: (value) {
                    _controller.trabalho.feedback = value;
                  },
                ),
              ],
            ),
          ),
        ),
        RaisedButton(
          onPressed: () {
            _controller.saveTrabalho();
          },
          color: Theme.of(context).accentColor,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Text(
              'Avaliar',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          textColor: Color(0xFFFFFFFF),
        )
      ],
    );
  }

  Widget naoTemTrabalho() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            height: 150,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/perfil.jpg',
              image: _controller.usuario.urlFoto480,
              fit: BoxFit.fitWidth,
              imageErrorBuilder: (context, obj, _) {
                return Image.asset(
                  'assets/images/perfil.jpg',
                  fit: BoxFit.fitWidth,
                );
              },
            ),
          ),
        ),
        Spacer(),
        Text(
          'Bom te ver de novo!',
          style: TextStyle(fontSize: 26),
        ),
        Text(
          _controller.usuario.nome,
          style: TextStyle(fontSize: 18),
        ),
        Spacer(),
        Text('Faça um agendamento!'),
        Spacer(),
        InkWell(
          onTap: () => push(context, AddTrabPage(usuario: _controller.usuario)),
          child: Icon(
            FontAwesome.calendar_plus_o,
            size: 100,
          ),
        ),
        Spacer(),
      ],
    );
  }
}
