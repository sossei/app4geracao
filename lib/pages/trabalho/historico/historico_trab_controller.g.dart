// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historico_trab_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HistoricoTrabController on _HistoricoTrabControllerBase, Store {
  final _$trabalhosAtom = Atom(name: '_HistoricoTrabControllerBase.trabalhos');

  @override
  List<Trabalho> get trabalhos {
    _$trabalhosAtom.context.enforceReadPolicy(_$trabalhosAtom);
    _$trabalhosAtom.reportObserved();
    return super.trabalhos;
  }

  @override
  set trabalhos(List<Trabalho> value) {
    _$trabalhosAtom.context.conditionallyRunInAction(() {
      super.trabalhos = value;
      _$trabalhosAtom.reportChanged();
    }, _$trabalhosAtom, name: '${_$trabalhosAtom.name}_set');
  }

  final _$isRequestingAtom =
      Atom(name: '_HistoricoTrabControllerBase.isRequesting');

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

  final _$msgErroAtom = Atom(name: '_HistoricoTrabControllerBase.msgErro');

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

  final _$_HistoricoTrabControllerBaseActionController =
      ActionController(name: '_HistoricoTrabControllerBase');

  @override
  dynamic setTrabalhos(List<Trabalho> ptrabalhos) {
    final _$actionInfo =
        _$_HistoricoTrabControllerBaseActionController.startAction();
    try {
      return super.setTrabalhos(ptrabalhos);
    } finally {
      _$_HistoricoTrabControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMsgErro(String msg) {
    final _$actionInfo =
        _$_HistoricoTrabControllerBaseActionController.startAction();
    try {
      return super.setMsgErro(msg);
    } finally {
      _$_HistoricoTrabControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setRequesting(bool pRequesting) {
    final _$actionInfo =
        _$_HistoricoTrabControllerBaseActionController.startAction();
    try {
      return super._setRequesting(pRequesting);
    } finally {
      _$_HistoricoTrabControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'trabalhos: ${trabalhos.toString()},isRequesting: ${isRequesting.toString()},msgErro: ${msgErro.toString()}';
    return '{$string}';
  }
}
