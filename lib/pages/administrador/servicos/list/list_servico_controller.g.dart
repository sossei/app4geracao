// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_servico_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListServicoController on _ListServicoControllerBase, Store {
  final _$servicosAtom = Atom(name: '_ListServicoControllerBase.servicos');

  @override
  List<Servico> get servicos {
    _$servicosAtom.context.enforceReadPolicy(_$servicosAtom);
    _$servicosAtom.reportObserved();
    return super.servicos;
  }

  @override
  set servicos(List<Servico> value) {
    _$servicosAtom.context.conditionallyRunInAction(() {
      super.servicos = value;
      _$servicosAtom.reportChanged();
    }, _$servicosAtom, name: '${_$servicosAtom.name}_set');
  }

  final _$isRequestingAtom =
      Atom(name: '_ListServicoControllerBase.isRequesting');

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

  final _$msgErroAtom = Atom(name: '_ListServicoControllerBase.msgErro');

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

  final _$_ListServicoControllerBaseActionController =
      ActionController(name: '_ListServicoControllerBase');

  @override
  dynamic setMsgErro(String msg) {
    final _$actionInfo =
        _$_ListServicoControllerBaseActionController.startAction();
    try {
      return super.setMsgErro(msg);
    } finally {
      _$_ListServicoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setRequesting(bool pRequesting) {
    final _$actionInfo =
        _$_ListServicoControllerBaseActionController.startAction();
    try {
      return super._setRequesting(pRequesting);
    } finally {
      _$_ListServicoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setServicos(List<Servico> pServicos) {
    final _$actionInfo =
        _$_ListServicoControllerBaseActionController.startAction();
    try {
      return super._setServicos(pServicos);
    } finally {
      _$_ListServicoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'servicos: ${servicos.toString()},isRequesting: ${isRequesting.toString()},msgErro: ${msgErro.toString()}';
    return '{$string}';
  }
}
