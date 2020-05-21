// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_servico_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SaveServicoController on _SaveServicoControllerBase, Store {
  final _$servicoAtom = Atom(name: '_SaveServicoControllerBase.servico');

  @override
  Servico get servico {
    _$servicoAtom.context.enforceReadPolicy(_$servicoAtom);
    _$servicoAtom.reportObserved();
    return super.servico;
  }

  @override
  set servico(Servico value) {
    _$servicoAtom.context.conditionallyRunInAction(() {
      super.servico = value;
      _$servicoAtom.reportChanged();
    }, _$servicoAtom, name: '${_$servicoAtom.name}_set');
  }

  final _$isRequestingAtom =
      Atom(name: '_SaveServicoControllerBase.isRequesting');

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

  final _$msgErroAtom = Atom(name: '_SaveServicoControllerBase.msgErro');

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

  final _$_SaveServicoControllerBaseActionController =
      ActionController(name: '_SaveServicoControllerBase');

  @override
  dynamic setMsgErro(String msg) {
    final _$actionInfo =
        _$_SaveServicoControllerBaseActionController.startAction();
    try {
      return super.setMsgErro(msg);
    } finally {
      _$_SaveServicoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setRequesting(bool pRequesting) {
    final _$actionInfo =
        _$_SaveServicoControllerBaseActionController.startAction();
    try {
      return super._setRequesting(pRequesting);
    } finally {
      _$_SaveServicoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setServico(Servico servico) {
    final _$actionInfo =
        _$_SaveServicoControllerBaseActionController.startAction();
    try {
      return super.setServico(servico);
    } finally {
      _$_SaveServicoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'servico: ${servico.toString()},isRequesting: ${isRequesting.toString()},msgErro: ${msgErro.toString()}';
    return '{$string}';
  }
}
