// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CadastroController on _CadastroControllerBase, Store {
  final _$titleAtom = Atom(name: '_CadastroControllerBase.title');

  @override
  String get title {
    _$titleAtom.context.enforceReadPolicy(_$titleAtom);
    _$titleAtom.reportObserved();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.context.conditionallyRunInAction(() {
      super.title = value;
      _$titleAtom.reportChanged();
    }, _$titleAtom, name: '${_$titleAtom.name}_set');
  }

  final _$isEnderecoAtom = Atom(name: '_CadastroControllerBase.isEndereco');

  @override
  bool get isEndereco {
    _$isEnderecoAtom.context.enforceReadPolicy(_$isEnderecoAtom);
    _$isEnderecoAtom.reportObserved();
    return super.isEndereco;
  }

  @override
  set isEndereco(bool value) {
    _$isEnderecoAtom.context.conditionallyRunInAction(() {
      super.isEndereco = value;
      _$isEnderecoAtom.reportChanged();
    }, _$isEnderecoAtom, name: '${_$isEnderecoAtom.name}_set');
  }

  final _$isRequestingAtom = Atom(name: '_CadastroControllerBase.isRequesting');

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

  final _$msgErroAtom = Atom(name: '_CadastroControllerBase.msgErro');

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

  final _$_CadastroControllerBaseActionController =
      ActionController(name: '_CadastroControllerBase');

  @override
  dynamic setMsgErro(String msg) {
    final _$actionInfo =
        _$_CadastroControllerBaseActionController.startAction();
    try {
      return super.setMsgErro(msg);
    } finally {
      _$_CadastroControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setRequesting(bool pRequesting) {
    final _$actionInfo =
        _$_CadastroControllerBaseActionController.startAction();
    try {
      return super._setRequesting(pRequesting);
    } finally {
      _$_CadastroControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTitle(String pTitle) {
    final _$actionInfo =
        _$_CadastroControllerBaseActionController.startAction();
    try {
      return super.setTitle(pTitle);
    } finally {
      _$_CadastroControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIsEndereco(bool isEndereco) {
    final _$actionInfo =
        _$_CadastroControllerBaseActionController.startAction();
    try {
      return super.setIsEndereco(isEndereco);
    } finally {
      _$_CadastroControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'title: ${title.toString()},isEndereco: ${isEndereco.toString()},isRequesting: ${isRequesting.toString()},msgErro: ${msgErro.toString()}';
    return '{$string}';
  }
}
