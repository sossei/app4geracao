// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_trabalho_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListTrabalhoController on _ListTrabalhoControllerBase, Store {
  final _$usuarioAtom = Atom(name: '_ListTrabalhoControllerBase.usuario');

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

  final _$estabelecimentoAtom =
      Atom(name: '_ListTrabalhoControllerBase.estabelecimento');

  @override
  Estabelecimento get estabelecimento {
    _$estabelecimentoAtom.context.enforceReadPolicy(_$estabelecimentoAtom);
    _$estabelecimentoAtom.reportObserved();
    return super.estabelecimento;
  }

  @override
  set estabelecimento(Estabelecimento value) {
    _$estabelecimentoAtom.context.conditionallyRunInAction(() {
      super.estabelecimento = value;
      _$estabelecimentoAtom.reportChanged();
    }, _$estabelecimentoAtom, name: '${_$estabelecimentoAtom.name}_set');
  }

  final _$trabalhosAtom = Atom(name: '_ListTrabalhoControllerBase.trabalhos');

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
      Atom(name: '_ListTrabalhoControllerBase.isRequesting');

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

  final _$msgErroAtom = Atom(name: '_ListTrabalhoControllerBase.msgErro');

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

  final _$dataFormattedAtom =
      Atom(name: '_ListTrabalhoControllerBase.dataFormatted');

  @override
  String get dataFormatted {
    _$dataFormattedAtom.context.enforceReadPolicy(_$dataFormattedAtom);
    _$dataFormattedAtom.reportObserved();
    return super.dataFormatted;
  }

  @override
  set dataFormatted(String value) {
    _$dataFormattedAtom.context.conditionallyRunInAction(() {
      super.dataFormatted = value;
      _$dataFormattedAtom.reportChanged();
    }, _$dataFormattedAtom, name: '${_$dataFormattedAtom.name}_set');
  }

  final _$isFilteredAtom = Atom(name: '_ListTrabalhoControllerBase.isFiltered');

  @override
  bool get isFiltered {
    _$isFilteredAtom.context.enforceReadPolicy(_$isFilteredAtom);
    _$isFilteredAtom.reportObserved();
    return super.isFiltered;
  }

  @override
  set isFiltered(bool value) {
    _$isFilteredAtom.context.conditionallyRunInAction(() {
      super.isFiltered = value;
      _$isFilteredAtom.reportChanged();
    }, _$isFilteredAtom, name: '${_$isFilteredAtom.name}_set');
  }

  final _$_ListTrabalhoControllerBaseActionController =
      ActionController(name: '_ListTrabalhoControllerBase');

  @override
  dynamic setUsuario(Usuario pusuario) {
    final _$actionInfo =
        _$_ListTrabalhoControllerBaseActionController.startAction();
    try {
      return super.setUsuario(pusuario);
    } finally {
      _$_ListTrabalhoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFilter(bool filter) {
    final _$actionInfo =
        _$_ListTrabalhoControllerBaseActionController.startAction();
    try {
      return super.setFilter(filter);
    } finally {
      _$_ListTrabalhoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDataForamtted(String dataFormatted) {
    final _$actionInfo =
        _$_ListTrabalhoControllerBaseActionController.startAction();
    try {
      return super.setDataForamtted(dataFormatted);
    } finally {
      _$_ListTrabalhoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setEstabelecimento(Estabelecimento pestabelecimento) {
    final _$actionInfo =
        _$_ListTrabalhoControllerBaseActionController.startAction();
    try {
      return super.setEstabelecimento(pestabelecimento);
    } finally {
      _$_ListTrabalhoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTrabalhos(List<Trabalho> ptrabalhos) {
    final _$actionInfo =
        _$_ListTrabalhoControllerBaseActionController.startAction();
    try {
      return super.setTrabalhos(ptrabalhos);
    } finally {
      _$_ListTrabalhoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMsgErro(String msg) {
    final _$actionInfo =
        _$_ListTrabalhoControllerBaseActionController.startAction();
    try {
      return super.setMsgErro(msg);
    } finally {
      _$_ListTrabalhoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setRequesting(bool pRequesting) {
    final _$actionInfo =
        _$_ListTrabalhoControllerBaseActionController.startAction();
    try {
      return super._setRequesting(pRequesting);
    } finally {
      _$_ListTrabalhoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setData(DateTime data) {
    final _$actionInfo =
        _$_ListTrabalhoControllerBaseActionController.startAction();
    try {
      return super.setData(data);
    } finally {
      _$_ListTrabalhoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'usuario: ${usuario.toString()},estabelecimento: ${estabelecimento.toString()},trabalhos: ${trabalhos.toString()},isRequesting: ${isRequesting.toString()},msgErro: ${msgErro.toString()},dataFormatted: ${dataFormatted.toString()},isFiltered: ${isFiltered.toString()}';
    return '{$string}';
  }
}
