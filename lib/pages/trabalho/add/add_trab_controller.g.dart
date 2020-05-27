// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_trab_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddTrabController on _AddTrabControllerBase, Store {
  final _$indexServicoAtom = Atom(name: '_AddTrabControllerBase.indexServico');

  @override
  int get indexServico {
    _$indexServicoAtom.context.enforceReadPolicy(_$indexServicoAtom);
    _$indexServicoAtom.reportObserved();
    return super.indexServico;
  }

  @override
  set indexServico(int value) {
    _$indexServicoAtom.context.conditionallyRunInAction(() {
      super.indexServico = value;
      _$indexServicoAtom.reportChanged();
    }, _$indexServicoAtom, name: '${_$indexServicoAtom.name}_set');
  }

  final _$indexBarbeiroAtom =
      Atom(name: '_AddTrabControllerBase.indexBarbeiro');

  @override
  int get indexBarbeiro {
    _$indexBarbeiroAtom.context.enforceReadPolicy(_$indexBarbeiroAtom);
    _$indexBarbeiroAtom.reportObserved();
    return super.indexBarbeiro;
  }

  @override
  set indexBarbeiro(int value) {
    _$indexBarbeiroAtom.context.conditionallyRunInAction(() {
      super.indexBarbeiro = value;
      _$indexBarbeiroAtom.reportChanged();
    }, _$indexBarbeiroAtom, name: '${_$indexBarbeiroAtom.name}_set');
  }

  final _$isRequestingAtom = Atom(name: '_AddTrabControllerBase.isRequesting');

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

  final _$msgErroAtom = Atom(name: '_AddTrabControllerBase.msgErro');

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

  final _$_AddTrabControllerBaseActionController =
      ActionController(name: '_AddTrabControllerBase');

  @override
  dynamic setMsgErro(String msg) {
    final _$actionInfo = _$_AddTrabControllerBaseActionController.startAction();
    try {
      return super.setMsgErro(msg);
    } finally {
      _$_AddTrabControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setRequesting(bool pRequesting) {
    final _$actionInfo = _$_AddTrabControllerBaseActionController.startAction();
    try {
      return super._setRequesting(pRequesting);
    } finally {
      _$_AddTrabControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setServico(int servico) {
    final _$actionInfo = _$_AddTrabControllerBaseActionController.startAction();
    try {
      return super.setServico(servico);
    } finally {
      _$_AddTrabControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setBarbeiro(int barbeiro) {
    final _$actionInfo = _$_AddTrabControllerBaseActionController.startAction();
    try {
      return super.setBarbeiro(barbeiro);
    } finally {
      _$_AddTrabControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'indexServico: ${indexServico.toString()},indexBarbeiro: ${indexBarbeiro.toString()},isRequesting: ${isRequesting.toString()},msgErro: ${msgErro.toString()}';
    return '{$string}';
  }
}
