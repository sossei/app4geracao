// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_barbeiros_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListBarbeiroController on _ListBarbeiroControllerBase, Store {
  final _$barbeirosAtom = Atom(name: '_ListBarbeiroControllerBase.barbeiros');

  @override
  List<Barbeiro> get barbeiros {
    _$barbeirosAtom.context.enforceReadPolicy(_$barbeirosAtom);
    _$barbeirosAtom.reportObserved();
    return super.barbeiros;
  }

  @override
  set barbeiros(List<Barbeiro> value) {
    _$barbeirosAtom.context.conditionallyRunInAction(() {
      super.barbeiros = value;
      _$barbeirosAtom.reportChanged();
    }, _$barbeirosAtom, name: '${_$barbeirosAtom.name}_set');
  }

  final _$isRequestingAtom =
      Atom(name: '_ListBarbeiroControllerBase.isRequesting');

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

  final _$msgErroAtom = Atom(name: '_ListBarbeiroControllerBase.msgErro');

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

  final _$_ListBarbeiroControllerBaseActionController =
      ActionController(name: '_ListBarbeiroControllerBase');

  @override
  dynamic setMsgErro(String msg) {
    final _$actionInfo =
        _$_ListBarbeiroControllerBaseActionController.startAction();
    try {
      return super.setMsgErro(msg);
    } finally {
      _$_ListBarbeiroControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setRequesting(bool pRequesting) {
    final _$actionInfo =
        _$_ListBarbeiroControllerBaseActionController.startAction();
    try {
      return super._setRequesting(pRequesting);
    } finally {
      _$_ListBarbeiroControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setBarbeiros(List<Barbeiro> pbarbeiros) {
    final _$actionInfo =
        _$_ListBarbeiroControllerBaseActionController.startAction();
    try {
      return super._setBarbeiros(pbarbeiros);
    } finally {
      _$_ListBarbeiroControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'barbeiros: ${barbeiros.toString()},isRequesting: ${isRequesting.toString()},msgErro: ${msgErro.toString()}';
    return '{$string}';
  }
}
