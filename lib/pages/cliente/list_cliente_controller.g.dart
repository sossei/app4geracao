// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_cliente_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListClienteController on _ListClienteControllerBase, Store {
  final _$filterAtom = Atom(name: '_ListClienteControllerBase.filter');

  @override
  String get filter {
    _$filterAtom.context.enforceReadPolicy(_$filterAtom);
    _$filterAtom.reportObserved();
    return super.filter;
  }

  @override
  set filter(String value) {
    _$filterAtom.context.conditionallyRunInAction(() {
      super.filter = value;
      _$filterAtom.reportChanged();
    }, _$filterAtom, name: '${_$filterAtom.name}_set');
  }

  final _$usuariosAtom = Atom(name: '_ListClienteControllerBase.usuarios');

  @override
  List<Usuario> get usuarios {
    _$usuariosAtom.context.enforceReadPolicy(_$usuariosAtom);
    _$usuariosAtom.reportObserved();
    return super.usuarios;
  }

  @override
  set usuarios(List<Usuario> value) {
    _$usuariosAtom.context.conditionallyRunInAction(() {
      super.usuarios = value;
      _$usuariosAtom.reportChanged();
    }, _$usuariosAtom, name: '${_$usuariosAtom.name}_set');
  }

  final _$isRequestingAtom =
      Atom(name: '_ListClienteControllerBase.isRequesting');

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

  final _$msgErroAtom = Atom(name: '_ListClienteControllerBase.msgErro');

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

  final _$_ListClienteControllerBaseActionController =
      ActionController(name: '_ListClienteControllerBase');

  @override
  dynamic setMsgErro(String msg) {
    final _$actionInfo =
        _$_ListClienteControllerBaseActionController.startAction();
    try {
      return super.setMsgErro(msg);
    } finally {
      _$_ListClienteControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setRequesting(bool pRequesting) {
    final _$actionInfo =
        _$_ListClienteControllerBaseActionController.startAction();
    try {
      return super._setRequesting(pRequesting);
    } finally {
      _$_ListClienteControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setUsuarios(List<Usuario> pUsuarios) {
    final _$actionInfo =
        _$_ListClienteControllerBaseActionController.startAction();
    try {
      return super._setUsuarios(pUsuarios);
    } finally {
      _$_ListClienteControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic filtrar(String value) {
    final _$actionInfo =
        _$_ListClienteControllerBaseActionController.startAction();
    try {
      return super.filtrar(value);
    } finally {
      _$_ListClienteControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'filter: ${filter.toString()},usuarios: ${usuarios.toString()},isRequesting: ${isRequesting.toString()},msgErro: ${msgErro.toString()}';
    return '{$string}';
  }
}
