// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_calendar_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListCalendarController on _ListCalendarControllerBase, Store {
  final _$isRequestingAtom =
      Atom(name: '_ListCalendarControllerBase.isRequesting');

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

  final _$msgErroAtom = Atom(name: '_ListCalendarControllerBase.msgErro');

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

  final _$calendarsAtom = Atom(name: '_ListCalendarControllerBase.calendars');

  @override
  UnmodifiableListView<Calendar> get calendars {
    _$calendarsAtom.context.enforceReadPolicy(_$calendarsAtom);
    _$calendarsAtom.reportObserved();
    return super.calendars;
  }

  @override
  set calendars(UnmodifiableListView<Calendar> value) {
    _$calendarsAtom.context.conditionallyRunInAction(() {
      super.calendars = value;
      _$calendarsAtom.reportChanged();
    }, _$calendarsAtom, name: '${_$calendarsAtom.name}_set');
  }

  final _$_ListCalendarControllerBaseActionController =
      ActionController(name: '_ListCalendarControllerBase');

  @override
  dynamic setMsgErro(String msg) {
    final _$actionInfo =
        _$_ListCalendarControllerBaseActionController.startAction();
    try {
      return super.setMsgErro(msg);
    } finally {
      _$_ListCalendarControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setRequesting(bool pRequesting) {
    final _$actionInfo =
        _$_ListCalendarControllerBaseActionController.startAction();
    try {
      return super._setRequesting(pRequesting);
    } finally {
      _$_ListCalendarControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCalendars(UnmodifiableListView<Calendar> calendars) {
    final _$actionInfo =
        _$_ListCalendarControllerBaseActionController.startAction();
    try {
      return super.setCalendars(calendars);
    } finally {
      _$_ListCalendarControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'isRequesting: ${isRequesting.toString()},msgErro: ${msgErro.toString()},calendars: ${calendars.toString()}';
    return '{$string}';
  }
}
