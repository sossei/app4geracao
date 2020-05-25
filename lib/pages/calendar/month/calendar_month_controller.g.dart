// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_month_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CalendarMonthController on _CalendarMonthControllerBase, Store {
  final _$isAdminAtom = Atom(name: '_CalendarMonthControllerBase.isAdmin');

  @override
  bool get isAdmin {
    _$isAdminAtom.context.enforceReadPolicy(_$isAdminAtom);
    _$isAdminAtom.reportObserved();
    return super.isAdmin;
  }

  @override
  set isAdmin(bool value) {
    _$isAdminAtom.context.conditionallyRunInAction(() {
      super.isAdmin = value;
      _$isAdminAtom.reportChanged();
    }, _$isAdminAtom, name: '${_$isAdminAtom.name}_set');
  }

  final _$selectedDateAtom =
      Atom(name: '_CalendarMonthControllerBase.selectedDate');

  @override
  DateTime get selectedDate {
    _$selectedDateAtom.context.enforceReadPolicy(_$selectedDateAtom);
    _$selectedDateAtom.reportObserved();
    return super.selectedDate;
  }

  @override
  set selectedDate(DateTime value) {
    _$selectedDateAtom.context.conditionallyRunInAction(() {
      super.selectedDate = value;
      _$selectedDateAtom.reportChanged();
    }, _$selectedDateAtom, name: '${_$selectedDateAtom.name}_set');
  }

  final _$selectedTrabalhosAtom =
      Atom(name: '_CalendarMonthControllerBase.selectedTrabalhos');

  @override
  List<Trabalho> get selectedTrabalhos {
    _$selectedTrabalhosAtom.context.enforceReadPolicy(_$selectedTrabalhosAtom);
    _$selectedTrabalhosAtom.reportObserved();
    return super.selectedTrabalhos;
  }

  @override
  set selectedTrabalhos(List<Trabalho> value) {
    _$selectedTrabalhosAtom.context.conditionallyRunInAction(() {
      super.selectedTrabalhos = value;
      _$selectedTrabalhosAtom.reportChanged();
    }, _$selectedTrabalhosAtom, name: '${_$selectedTrabalhosAtom.name}_set');
  }

  final _$mapDatesAtom = Atom(name: '_CalendarMonthControllerBase.mapDates');

  @override
  Map<DateTime, List<Trabalho>> get mapDates {
    _$mapDatesAtom.context.enforceReadPolicy(_$mapDatesAtom);
    _$mapDatesAtom.reportObserved();
    return super.mapDates;
  }

  @override
  set mapDates(Map<DateTime, List<Trabalho>> value) {
    _$mapDatesAtom.context.conditionallyRunInAction(() {
      super.mapDates = value;
      _$mapDatesAtom.reportChanged();
    }, _$mapDatesAtom, name: '${_$mapDatesAtom.name}_set');
  }

  final _$isRequestingAtom =
      Atom(name: '_CalendarMonthControllerBase.isRequesting');

  @override
  bool get isRequesting {
    _$isRequestingAtom.context.enforceReadPolicy(_$isRequestingAtom);
    _$isRequestingAtom.reportObserved();
    return super.isRequesting;
  }

  @override
  set isRequesting(bool value) {
    _$isRequestingAtom.context.conditionallyRunInAction(() {
      super.isRequesting = value;
      _$isRequestingAtom.reportChanged();
    }, _$isRequestingAtom, name: '${_$isRequestingAtom.name}_set');
  }

  final _$msgErroAtom = Atom(name: '_CalendarMonthControllerBase.msgErro');

  @override
  String get msgErro {
    _$msgErroAtom.context.enforceReadPolicy(_$msgErroAtom);
    _$msgErroAtom.reportObserved();
    return super.msgErro;
  }

  @override
  set msgErro(String value) {
    _$msgErroAtom.context.conditionallyRunInAction(() {
      super.msgErro = value;
      _$msgErroAtom.reportChanged();
    }, _$msgErroAtom, name: '${_$msgErroAtom.name}_set');
  }

  final _$_CalendarMonthControllerBaseActionController =
      ActionController(name: '_CalendarMonthControllerBase');

  @override
  dynamic setMsgErro(String msg) {
    final _$actionInfo =
        _$_CalendarMonthControllerBaseActionController.startAction();
    try {
      return super.setMsgErro(msg);
    } finally {
      _$_CalendarMonthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setAdmin(bool admin) {
    final _$actionInfo =
        _$_CalendarMonthControllerBaseActionController.startAction();
    try {
      return super.setAdmin(admin);
    } finally {
      _$_CalendarMonthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setRequesting(bool pRequesting) {
    final _$actionInfo =
        _$_CalendarMonthControllerBaseActionController.startAction();
    try {
      return super._setRequesting(pRequesting);
    } finally {
      _$_CalendarMonthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSelectedDate(DateTime selectedDate) {
    final _$actionInfo =
        _$_CalendarMonthControllerBaseActionController.startAction();
    try {
      return super.setSelectedDate(selectedDate);
    } finally {
      _$_CalendarMonthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMap(dynamic mapDates) {
    final _$actionInfo =
        _$_CalendarMonthControllerBaseActionController.startAction();
    try {
      return super.setMap(mapDates);
    } finally {
      _$_CalendarMonthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSelectedTrabalhos(List<Trabalho> selectedEvents) {
    final _$actionInfo =
        _$_CalendarMonthControllerBaseActionController.startAction();
    try {
      return super.setSelectedTrabalhos(selectedEvents);
    } finally {
      _$_CalendarMonthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'isAdmin: ${isAdmin.toString()},selectedDate: ${selectedDate.toString()},selectedTrabalhos: ${selectedTrabalhos.toString()},mapDates: ${mapDates.toString()},isRequesting: ${isRequesting.toString()},msgErro: ${msgErro.toString()}';
    return '{$string}';
  }
}
