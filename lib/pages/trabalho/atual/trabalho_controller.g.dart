// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trabalho_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TrabalhoController on _TrabalhoControllerBase, Store {
  final _$usuarioAtom = Atom(name: '_TrabalhoControllerBase.usuario');

  @override
  Usuario get usuario {
    _$usuarioAtom.context.enforceReadPolicy(_$usuarioAtom);
    _$usuarioAtom.reportObserved();
    return super.usuario;
  }

  @override
  set usuario(Usuario value) {
    _$usuarioAtom.context.conditionallyRunInAction(() {
      super.usuario = value;
      _$usuarioAtom.reportChanged();
    }, _$usuarioAtom, name: '${_$usuarioAtom.name}_set');
  }

  final _$trabalhoAtom = Atom(name: '_TrabalhoControllerBase.trabalho');

  @override
  Trabalho get trabalho {
    _$trabalhoAtom.context.enforceReadPolicy(_$trabalhoAtom);
    _$trabalhoAtom.reportObserved();
    return super.trabalho;
  }

  @override
  set trabalho(Trabalho value) {
    _$trabalhoAtom.context.conditionallyRunInAction(() {
      super.trabalho = value;
      _$trabalhoAtom.reportChanged();
    }, _$trabalhoAtom, name: '${_$trabalhoAtom.name}_set');
  }

  final _$isRequestingAtom = Atom(name: '_TrabalhoControllerBase.isRequesting');

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

  final _$msgErroAtom = Atom(name: '_TrabalhoControllerBase.msgErro');

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

  final _$_TrabalhoControllerBaseActionController =
      ActionController(name: '_TrabalhoControllerBase');

  @override
  dynamic setMsgErro(String msg) {
    final _$actionInfo =
        _$_TrabalhoControllerBaseActionController.startAction();
    try {
      return super.setMsgErro(msg);
    } finally {
      _$_TrabalhoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setRequesting(bool pRequesting) {
    final _$actionInfo =
        _$_TrabalhoControllerBaseActionController.startAction();
    try {
      return super._setRequesting(pRequesting);
    } finally {
      _$_TrabalhoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setTrabalho(Trabalho trabalho) {
    final _$actionInfo =
        _$_TrabalhoControllerBaseActionController.startAction();
    try {
      return super._setTrabalho(trabalho);
    } finally {
      _$_TrabalhoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setUsuario(Usuario usuario) {
    final _$actionInfo =
        _$_TrabalhoControllerBaseActionController.startAction();
    try {
      return super._setUsuario(usuario);
    } finally {
      _$_TrabalhoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'usuario: ${usuario.toString()},trabalho: ${trabalho.toString()},isRequesting: ${isRequesting.toString()},msgErro: ${msgErro.toString()}';
    return '{$string}';
  }
}
