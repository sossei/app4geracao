// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_barbeiro_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SaveBarbeiroController on _SaveBarbeiroControllerBase, Store {
  final _$barbeiroAtom = Atom(name: '_SaveBarbeiroControllerBase.barbeiro');

  @override
  Barbeiro get barbeiro {
    _$barbeiroAtom.context.enforceReadPolicy(_$barbeiroAtom);
    _$barbeiroAtom.reportObserved();
    return super.barbeiro;
  }

  @override
  set barbeiro(Barbeiro value) {
    _$barbeiroAtom.context.conditionallyRunInAction(() {
      super.barbeiro = value;
      _$barbeiroAtom.reportChanged();
    }, _$barbeiroAtom, name: '${_$barbeiroAtom.name}_set');
  }

  final _$isRequestingAtom =
      Atom(name: '_SaveBarbeiroControllerBase.isRequesting');

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

  final _$msgErroAtom = Atom(name: '_SaveBarbeiroControllerBase.msgErro');

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

  final _$_SaveBarbeiroControllerBaseActionController =
      ActionController(name: '_SaveBarbeiroControllerBase');

  @override
  dynamic setMsgErro(String msg) {
    final _$actionInfo =
        _$_SaveBarbeiroControllerBaseActionController.startAction();
    try {
      return super.setMsgErro(msg);
    } finally {
      _$_SaveBarbeiroControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setRequesting(bool pRequesting) {
    final _$actionInfo =
        _$_SaveBarbeiroControllerBaseActionController.startAction();
    try {
      return super._setRequesting(pRequesting);
    } finally {
      _$_SaveBarbeiroControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setBarbeiro(Barbeiro barbeiro) {
    final _$actionInfo =
        _$_SaveBarbeiroControllerBaseActionController.startAction();
    try {
      return super.setBarbeiro(barbeiro);
    } finally {
      _$_SaveBarbeiroControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'barbeiro: ${barbeiro.toString()},isRequesting: ${isRequesting.toString()},msgErro: ${msgErro.toString()}';
    return '{$string}';
  }
}
