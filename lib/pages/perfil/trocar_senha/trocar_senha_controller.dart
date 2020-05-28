import 'package:app4geracao/model/usuario.dart';
import 'package:app4geracao/pages/perfil/trocar_senha/trocar_senha_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'trocar_senha_controller.g.dart';

class TrocarSenhaController = _TrocarSenhaControllerBase
    with _$TrocarSenhaController;

abstract class _TrocarSenhaControllerBase with Store {
  @observable
  bool isRequesting = false;
  @observable
  String msgErro;
  @action
  setMsgErro(String msg) {
    msgErro = msg;
    isRequesting = false;
  }

  @action
  _setRequesting(bool pRequesting) {
    isRequesting = pRequesting;
  }

  final formCliente = GlobalKey<FormState>();
  Usuario usuario = Usuario();
  String senha;
  fetchData() async {
    setMsgErro(null);
    _setRequesting(true);
    usuario = await TrocarSenhaRepository().getUsuario();
    _setRequesting(false);
  }

  save() async {
    if (formCliente.currentState.validate()) {
      setMsgErro(null);
      _setRequesting(true);
      try {
        await TrocarSenhaRepository().login(usuario.email, senha);
        await TrocarSenhaRepository().editar(usuario);
      } catch (e, s) {
        debugPrint('$e - $s');
        setMsgErro(e.toString());
      }

      _setRequesting(false);
    }
  }
}
