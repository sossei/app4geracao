// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perfil_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PerfilController on _PerfilControllerBase, Store {
  final _$usuarioAtom = Atom(name: '_PerfilControllerBase.usuario');

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
      Atom(name: '_PerfilControllerBase.estabelecimento');

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

  final _$_PerfilControllerBaseActionController =
      ActionController(name: '_PerfilControllerBase');

  @override
  dynamic setUsuario(Usuario pusuario) {
    final _$actionInfo = _$_PerfilControllerBaseActionController.startAction();
    try {
      return super.setUsuario(pusuario);
    } finally {
      _$_PerfilControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setEstabelecimento(Estabelecimento pestabelecimento) {
    final _$actionInfo = _$_PerfilControllerBaseActionController.startAction();
    try {
      return super.setEstabelecimento(pestabelecimento);
    } finally {
      _$_PerfilControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'usuario: ${usuario.toString()},estabelecimento: ${estabelecimento.toString()}';
    return '{$string}';
  }
}
