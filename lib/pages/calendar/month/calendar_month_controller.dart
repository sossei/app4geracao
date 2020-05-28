import 'package:app4geracao/model/trabalho.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:table_calendar/table_calendar.dart';

import 'calendar_month_repository.dart';
part 'calendar_month_controller.g.dart';

class CalendarMonthController = _CalendarMonthControllerBase
    with _$CalendarMonthController;

abstract class _CalendarMonthControllerBase with Store {
  @observable
  bool isAdmin = false;
  @observable
  DateTime selectedDate = DateTime.now();
  @observable
  List<Trabalho> selectedTrabalhos = [];
  @observable
  Map<DateTime, List<Trabalho>> mapDates = {};
  @observable
  bool isRequesting = false;
  @observable
  String msgErro;
  @action
  setMsgErro(String msg) {
    msgErro = msg;
    isRequesting = false;
  }

  @action
  setAdmin(bool admin) {
    if (isAdmin != admin) isAdmin = admin;
  }

  @action
  _setRequesting(bool pRequesting) {
    msgErro = null;
    isRequesting = pRequesting;
  }

  @action
  setSelectedDate(DateTime selectedDate) {
    this.selectedDate = selectedDate;
    animationController.forward(from: 0.0);
  }

  @action
  setMap(mapDates) {
    List<Trabalho> trabalhos = mapDates[selectedDate] ?? [];
    this.selectedTrabalhos = trabalhos;
    // setSelectedTrabalhos(trabalhos);
    this.mapDates = mapDates;
    animationController.forward(from: 0.0);
  }

  @action
  setSelectedTrabalhos(List<Trabalho> selectedEvents) {
    this.selectedTrabalhos = selectedEvents;
  }

  AnimationController animationController;

  fetchData(DateTime initDate, DateTime endDate) async {
    setMsgErro(null);
    _setRequesting(true);

    try {
      Map map;
      if (isAdmin)
        map = await CalendarMonthRepository().listTrabalho(initDate, endDate);
      else
        map = await CalendarMonthRepository()
            .listTrabalhoSimples(initDate, endDate);
      setMap(map);
      _setRequesting(false);
      animationController.forward();
    } catch (e, s) {
      debugPrint('$e - $s');
      setMsgErro(e?.toString() ?? 'Sem conexão com servidor');
    }
  }
}
