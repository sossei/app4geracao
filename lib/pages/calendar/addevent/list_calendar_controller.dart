import 'dart:collection';

import 'package:app4geracao/model/trabalho.dart';
import 'package:app4geracao/pages/calendar/addevent/list_calendar_repository.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'list_calendar_controller.g.dart';

class ListCalendarController = _ListCalendarControllerBase
    with _$ListCalendarController;

abstract class _ListCalendarControllerBase with Store {
  ListCalendarRepository _repository;
  final Trabalho trabalho;
  _ListCalendarControllerBase(this.trabalho) {
    _repository = ListCalendarRepository();
  }
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
  _setRequesting(bool pRequesting) {
    isRequesting = pRequesting;
  }

  @observable
  UnmodifiableListView<Calendar> calendars;
  @action
  setCalendars(UnmodifiableListView<Calendar> calendars) {
    this.calendars = calendars;
  }

  fetchData() async {
    setMsgErro(null);
    _setRequesting(true);
    try {
      UnmodifiableListView<Calendar> calendars =
          await _repository.getCalendars();
      if (calendars.length == 1) {
        await _repository.createEvent(calendars[0], trabalho);
      } else
        setCalendars(calendars);
    } catch (e, s) {
      debugPrint('$e - $s');
      setMsgErro(e.toString());
    }

    _setRequesting(false);
  }

  createEvenet(Calendar calendar) async {
    setMsgErro(null);
    _setRequesting(true);
    try {
      await _repository.createEvent(calendar, trabalho);
    } catch (e, s) {
      debugPrint('$e - $s');
      setMsgErro(e.toString());
    }
    _setRequesting(false);
  }
}
