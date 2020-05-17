// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intro_logado_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$IntroLogadoController on _IntroLogadoControllerBase, Store {
  final _$usuarioAtom = Atom(name: '_IntroLogadoControllerBase.usuario');

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

  final _$_IntroLogadoControllerBaseActionController =
      ActionController(name: '_IntroLogadoControllerBase');

  @override
  dynamic setUsuario(Usuario pusuario) {
    final _$actionInfo =
        _$_IntroLogadoControllerBaseActionController.startAction();
    try {
      return super.setUsuario(pusuario);
    } finally {
      _$_IntroLogadoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'usuario: ${usuario.toString()}';
    return '{$string}';
  }
}
