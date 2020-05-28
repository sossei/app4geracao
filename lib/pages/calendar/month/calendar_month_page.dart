import 'package:app4geracao/control/nav/nav.dart';
import 'package:app4geracao/model/trabalho.dart';
import 'package:app4geracao/pages/calendar/day/calendar_day_page.dart';
import 'package:app4geracao/pages/calendar/month/calendar_month_controller.dart';
import 'package:app4geracao/pages/trabalho/trabalho_detalhes_page.dart';
import 'package:app4geracao/widgets/image_oval.dart';
import 'package:app4geracao/widgets/panel_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarMonthPage extends StatefulWidget {
  final Trabalho trabalho;
  final bool isAdmin;
  const CalendarMonthPage({Key key, this.trabalho, this.isAdmin = false})
      : super(key: key);

  @override
  _CalendarMonthPageState createState() => _CalendarMonthPageState();
}

class _CalendarMonthPageState extends State<CalendarMonthPage>
    with TickerProviderStateMixin {
  CalendarMonthController _controller = CalendarMonthController();
  var keyScafold = new GlobalKey<ScaffoldState>();
  CalendarController calendarController = CalendarController();
  @override
  void initState() {
    _controller.animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _controller.setAdmin(widget.isAdmin);
    super.initState();
    _controller.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: keyScafold,
      appBar: AppBar(title: Text('Seleciona a data')),
      body: body(),
    );
  }

  @override
  void dispose() {
    _controller.animationController.dispose();
    calendarController.dispose();
    super.dispose();
  }

  Widget body() {
    return panelMain();
  }

  Widget panelMain() {
    return Column(
      children: <Widget>[
        Observer(builder: (_) {
          return panelLoading();
        }),
        Observer(builder: (_) {
          return calendar();
        }),
        Expanded(
          child: Observer(builder: (_) {
            if (_controller.msgErro != null) return panelError();
            return widget.isAdmin
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(child: trabalhoList()),
                      buttonDetalhes(),
                    ],
                  )
                : Container();
          }),
        ),
      ],
    );
  }

  Widget panelError() {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: PanelError(
              action: _controller.setMsgErro(null),
              descAction: 'Tentar novamente',
              msgErro: _controller.msgErro,
            )));
  }

  Widget panelLoading() {
    if (_controller.isRequesting)
      return LinearProgressIndicator();
    else
      return Container();
  }

  Widget calendar() {
    return TableCalendar(
      locale: 'pt',
      calendarController: calendarController,
      events: _controller.mapDates,
      initialCalendarFormat:
          widget.isAdmin ? CalendarFormat.week : CalendarFormat.month,
      initialSelectedDay: DateTime.now(),
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      enabledDayPredicate: _enabledDayPredicate,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Semanal',
        CalendarFormat.week: 'Mensal',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: true,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: true,
      ),
      builders: CalendarBuilders(
        outsideDayBuilder: outsideDate,
        outsideWeekendDayBuilder: outsideDate,
        unavailableDayBuilder: unavailableDate,
        dayBuilder: dayBuilder,
        selectedDayBuilder: selectedDayBuilder,
        todayDayBuilder: todayDayBuilder,
        markersBuilder: makerBuilder,
      ),
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
      onDaySelected: _onDaySelected,
    );
  }

  List<Widget> makerBuilder(BuildContext context, DateTime date,
      List<dynamic> trabalhos, List<dynamic> holidays) {
    final children = <Widget>[];
    if (trabalhos.isNotEmpty) {
      children.add(
        Positioned(
          right: 1,
          bottom: 1,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
              color: calendarController.isSelected(date)
                  ? Colors.brown[500]
                  : calendarController.isToday(date)
                      ? Colors.brown[300]
                      : Colors.blue[400],
            ),
            width: 24.0,
            height: 18.0,
            child: Center(
              child: Text(
                '${trabalhos.length}',
                style: TextStyle().copyWith(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return children;
  }

  Widget todayDayBuilder(
      BuildContext context, DateTime date, List<dynamic> trabalhos) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.only(top: 5.0, left: 6.0),
      decoration: BoxDecoration(
        color: Colors.green[300],
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.green[300].withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      width: 100,
      height: 100,
      child: Text(
        '${date.day}',
        style: TextStyle().copyWith(fontSize: 16.0),
      ),
    );
  }

  Widget selectedDayBuilder(
      BuildContext context, DateTime date, List<dynamic> trabalhos) {
    return FadeTransition(
      opacity:
          Tween(begin: 0.0, end: 1.0).animate(_controller.animationController),
      child: Container(
        padding: const EdgeInsets.only(top: 5.0, left: 6.0),
        decoration: BoxDecoration(
          color: Colors.deepOrange[300],
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.deepOrange[300].withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        width: 100,
        height: 100,
        child: Text(
          '${date.day}',
          style: TextStyle().copyWith(fontSize: 16.0),
        ),
      ),
    );
  }

  Widget dayBuilder(
      BuildContext context, DateTime date, List<dynamic> trabalhos) {
    bool isSabado = date.weekday == 6;
    return FadeTransition(
      opacity:
          Tween(begin: 0.9, end: 1.0).animate(_controller.animationController),
      child: Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.only(top: 5.0, left: 6.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Theme.of(context).primaryColor),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        width: 100,
        height: 100,
        child: Text(
          '${date.day}',
          style: TextStyle(color: isSabado ? Colors.blue : Colors.black)
              .copyWith(fontSize: 16.0),
        ),
      ),
    );
  }

  Widget unavailableDate(
      BuildContext context, DateTime date, List<dynamic> trabalhos) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.only(top: 5.0, left: 6.0),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      width: 100,
      height: widget.isAdmin ? 100 : 200,
      child: Text(
        '${date.day}',
        style: TextStyle().copyWith(fontSize: 16.0),
      ),
    );
  }

  Widget outsideDate(
      BuildContext context, DateTime date, List<dynamic> trabalhos) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.only(top: 5.0, left: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      width: 100,
      height: widget.isAdmin ? 100 : 200,
      child: Text(
        '${date.day}',
        style: TextStyle(color: Colors.grey).copyWith(fontSize: 16.0),
      ),
    );
  }

  Widget trabalhoList() {
    return FadeTransition(
      opacity:
          Tween(begin: 0.5, end: 1.0).animate(_controller.animationController),
      child: ListView(
        children: _controller.selectedTrabalhos.map(
          (trab) {
            DateTime init = trab.date;
            DateTime end = trab.date.add(Duration(minutes: trab.servico.tempo));
            DateFormat format = DateFormat('HH:mm');
            return InkWell(
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return Container(
                        child: TrabalhoDetahePage(
                          trabalho: trab,
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
              child: Card(
                  child: Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                trab.usuario.nome,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Text(trab.servico.descricao),
                        Text(trab.barbeiro.nome),
                      ],
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text('R\$ ${trab.servico.valorFormatted}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(
                            'Das ${format.format(init)} até ${format.format(end)}'),
                        Row(
                          children: <Widget>[
                            OvalImage(
                              networkurl: trab.usuario.urlFoto75,
                              placeholder: 'assets/images/perfil.jpg',
                              size: 30,
                            ),
                            OvalImage(
                              networkurl: trab.servico.urlFoto75,
                              placeholder: 'assets/images/perfil.jpg',
                              size: 30,
                            ),
                            OvalImage(
                              networkurl: trab.barbeiro.urlFoto75,
                              placeholder: 'assets/images/perfil.jpg',
                              size: 30,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            );
          },
        ).toList(),
      ),
    );
  }

  Widget buttonDetalhes() {
    return RaisedButton(
      onPressed: () {
        push(
            context,
            CalendarDaypage(
              _controller.selectedDate,
              widget.trabalho,
              _controller.selectedTrabalhos,
              showData: widget.isAdmin,
              isTwo: widget.trabalho == null
                  ? false
                  : widget.trabalho.servico.tempo == 40,
            ));
      },
      color: Theme.of(context).accentColor,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Text(
          'Detalhes',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      textColor: Color(0xFFFFFFFF),
    );
  }

  bool _enabledDayPredicate(DateTime date) {
    if (date.weekday == 7) return false;
    if (widget.isAdmin) return true;
    DateTime hoje = DateTime.now();
    hoje = DateTime(hoje.year, hoje.month, hoje.day);
    if (date.isBefore(hoje)) return false;
    return true;
  }

  _showMessage(String msg) {
    keyScafold.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 3),
    ));
  }

  void _onDaySelected(DateTime day, List trabalhos) {
    print('CALLBACK: _onDaySelected');
    _controller.setSelectedDate(day);
    if (trabalhos is List<Trabalho>)
      _controller.setSelectedTrabalhos(trabalhos);
    else
      _controller.setSelectedTrabalhos([]);
    if (!widget.isAdmin) {
      push(
          context,
          CalendarDaypage(
            _controller.selectedDate,
            widget.trabalho,
            _controller.selectedTrabalhos,
            showData: widget.isAdmin,
            isTwo: widget.trabalho.servico.tempo == 40,
          ));
    }
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    _controller.fetchData(first, last);
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    _controller.fetchData(first, last);
  }
}

class TrabalhoDetalhePage {}
