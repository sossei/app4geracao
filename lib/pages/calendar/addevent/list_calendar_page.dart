import 'package:app4geracao/model/barbeiro.dart';
import 'package:app4geracao/model/trabalho.dart';
import 'package:app4geracao/pages/calendar/addevent/list_calendar_controller.dart';
import 'package:app4geracao/widgets/panel_error.dart';
import 'package:app4geracao/widgets/panel_requesting.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ListCalendarPage extends StatefulWidget {
  final Trabalho trabalho;

  const ListCalendarPage({Key key, this.trabalho}) : super(key: key);
  @override
  _ListCalendarPageState createState() => _ListCalendarPageState();
}

class _ListCalendarPageState extends State<ListCalendarPage>
    with TickerProviderStateMixin {
  ListCalendarController _controller;
  AnimationController animationController;
  @override
  void initState() {
    _controller = ListCalendarController(widget.trabalho);
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Editar perfil'),
      ),
      body: Observer(builder: (_) {
        return Center(child: _body());
      }),
    );
  }

  _body() {
    animationController.forward(from: 0.0);
    Widget child = _controller.msgErro != null
        ? PanelError(
            msgErro: _controller.msgErro,
            action: () {
              _controller.setMsgErro(null);
            },
            descAction: 'OK',
            withCard: false,
          )
        : _controller.isRequesting
            ? PanelRequesting(
                descricao: 'Editando...',
                withCard: false,
              )
            : main();
    return FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(animationController),
        child: child);
  }

  Widget main() {
    if (_controller.calendars == null) Navigator.pop(context);
    return ListView.separated(
        itemBuilder: (_, pos) {
          Calendar calendar = _controller.calendars[pos];
          if (calendar.isReadOnly) return Container();
          return ListTile(
              onTap: () async {
                _controller.createEvenet(calendar).then((_) {
                  Navigator.pop(context);
                });
              },
              title: Text(calendar.name),
              leading: Icon(FontAwesome.calendar));
        },
        separatorBuilder: (_, pos) {
          return Divider();
        },
        itemCount: _controller.calendars.length);
  }
}
