// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trocar_senha_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TrocarSenhaController on _TrocarSenhaControllerBase, Store {
  final _$isRequestingAtom =
      Atom(name: '_TrocarSenhaControllerBase.isRequesting');

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

  final _$msgErroAtom = Atom(name: '_TrocarSenhaControllerBase.msgErro');

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

  final _$_TrocarSenhaControllerBaseActionController =
      ActionController(name: '_TrocarSenhaControllerBase');

  @override
  dynamic setMsgErro(String msg) {
    final _$actionInfo =
        _$_TrocarSenhaControllerBaseActionController.startAction();
    try {
      return super.setMsgErro(msg);
    } finally {
      _$_TrocarSenhaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setRequesting(bool pRequesting) {
    final _$actionInfo =
        _$_TrocarSenhaControllerBaseActionController.startAction();
    try {
      return super._setRequesting(pRequesting);
    } finally {
      _$_TrocarSenhaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'isRequesting: ${isRequesting.toString()},msgErro: ${msgErro.toString()}';
    return '{$string}';
  }
}
