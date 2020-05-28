import 'package:app4geracao/control/nav/nav.dart';
import 'package:app4geracao/model/barbeiro.dart';
import 'package:app4geracao/model/servico.dart';
import 'package:app4geracao/model/trabalho.dart';
import 'package:app4geracao/model/usuario.dart';
import 'package:app4geracao/pages/calendar/month/calendar_month_page.dart';
import 'package:app4geracao/pages/servicos/list/list_servico_page.dart';
import 'package:app4geracao/widgets/panel_error.dart';
import 'package:app4geracao/widgets/panel_requesting.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'add_trab_controller.dart';

class AddTrabPage extends StatefulWidget {
  final Usuario usuario;

  const AddTrabPage({Key key, this.usuario}) : super(key: key);
  @override
  _AddTrabPageState createState() => _AddTrabPageState();
}

class _AddTrabPageState extends State<AddTrabPage> {
  AddTrabController _controller;
  @override
  void initState() {
    _config();

    super.initState();
  }

  _config() {
    _controller = AddTrabController(widget.usuario);
    _controller.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo agendamento'),
        actions: <Widget>[
          InkWell(
              onTap: () {
                pushReplacment(
                    context, ListServicoPage(trabalho: _controller.trabalho));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.list),
              ))
        ],
      ),
      body: Observer(builder: (_) {
        return body();
      }),
    );
  }

  Widget body() {
    if (_controller.msgErro != null) {
      return Center(
        child: PanelError(
          msgErro: _controller.msgErro,
          action: _controller.fetchData(),
        ),
      );
    }
    if (_controller.isRequesting)
      return Center(
        child: PanelRequesting(
          descricao: 'Carregando...',
        ),
      );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                carouselServico(),
                Divider(),
                caoruselBarbeiro(),
              ],
            ),
          ),
        ),
        buttonProsseguir(),
      ],
    );
  }

  Widget carouselServico() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            'Selecione o serviço',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        CarouselSlider.builder(
          itemCount: _controller?.servicos?.length ?? 0,
          itemBuilder: (context, index) {
            Servico servico = _controller.servicos[index];
            double _opacityValue = index == _controller.indexServico ? 1 : 0.5;
            return Opacity(
              opacity: _opacityValue,
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 4,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: item(servico.urlFoto480, servico.descricao,
                      subtitle: 'R\$ ${servico.valorFormatted}',
                      trailing: '${servico.tempo} min'),
                ),
              ),
            );
          },
          options: CarouselOptions(
            autoPlay: false,
            onPageChanged: (index, reason) {
              print(_controller.servicos[index].descricao);
              _controller.setServico(index);
            },
            enableInfiniteScroll: false,
            aspectRatio: 2.5,
            initialPage: 0,
            enlargeCenterPage: true,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _controller.servicos.map((url) {
            int index = _controller.servicos.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _controller.indexServico == index
                    ? Color.fromRGBO(0, 0, 0, 0.9)
                    : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget caoruselBarbeiro() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            'Selecione seu barbeiro preferido',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        CarouselSlider.builder(
          itemCount: _controller?.barbeiros?.length ?? 0,
          itemBuilder: (context, index) {
            Barbeiro barbeiro = _controller.barbeiros[index];
            double _opacityValue = index == _controller.indexBarbeiro ? 1 : 0.5;
            return Opacity(
              opacity: _opacityValue,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 4,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      item(
                        barbeiro.urlFoto480,
                        barbeiro.nome,
                        height: 150,
                        radiusBottom: false,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(5.0)),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  'Trabalhos',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(child: carouselTrabalhos(barbeiro)),
                            ],
                          ),
                          padding: EdgeInsets.all(8),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            autoPlay: false,
            onPageChanged: (index, reason) {
              print(_controller.barbeiros[index].nome);
              _controller.setBarbeiro(index);
            },
            enableInfiniteScroll: false,
            aspectRatio: 1,
            enlargeCenterPage: true,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _controller.barbeiros.map((url) {
            int index = _controller.barbeiros.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _controller.indexBarbeiro == index
                    ? Color.fromRGBO(0, 0, 0, 0.9)
                    : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget item(String url, String title,
      {String subtitle,
      String trailing,
      double height = 580,
      bool radiusBottom = true}) {
    return Container(
      height: height,
      child: Container(
        child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0),
              topRight: Radius.circular(5.0),
              bottomLeft: Radius.circular(radiusBottom ? 5.0 : 0),
              bottomRight: Radius.circular(radiusBottom ? 5.0 : 0),
            ),
            child: Stack(
              children: <Widget>[
                Image.network(url, fit: BoxFit.cover, width: 1000.0),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(250, 255, 255, 255),
                            Color.fromARGB(0, 255, 255, 255),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          title,
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: subtitle == null
                            ? null
                            : Text(
                                subtitle,
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                        trailing: trailing == null
                            ? null
                            : Text(
                                trailing,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      )),
                ),
              ],
            )),
      ),
    );
  }

  Widget carouselTrabalhos(Barbeiro barbeiro) {
    if (barbeiro.ultimostrabalhos == null) barbeiro.ultimostrabalhos = [];
    if (barbeiro.ultimostrabalhos.isEmpty) {
      return Container(
        child: Center(
          child: Text(
            'Não há registros',
            style: TextStyle(),
          ),
        ),
      );
    }
    return Container(
      child: CarouselSlider.builder(
        options: CarouselOptions(
          aspectRatio: 2.0,
          enlargeCenterPage: false,
          viewportFraction: 1,
        ),
        itemCount: (barbeiro.ultimostrabalhos.length / 2).round(),
        itemBuilder: (context, index) {
          final int first = index * 2;
          final int second = first + 1;
          return Row(
            children: [first, second].map((idx) {
              return Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Image.network(
                        't75_' + barbeiro.ultimostrabalhos[idx],
                        fit: BoxFit.cover),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget buttonProsseguir() {
    return RaisedButton(
      onPressed: () async {
        Trabalho trabalho = Trabalho();
        trabalho.usuario = widget.usuario;
        trabalho.servico = _controller.servicos[_controller.indexServico];
        trabalho.barbeiro = _controller.barbeiros[_controller.indexBarbeiro];
        push(context, CalendarMonthPage(trabalho: trabalho));
      },
      color: Theme.of(context).accentColor,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18),
        child: Text(
          'Prosseguir',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      textColor: Color(0xFFFFFFFF),
    );
  }
}
