import 'package:app4geracao/model/usuario.dart';
import 'package:app4geracao/pages/perfil/edit/edit_perfil_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'edit_perfil_controller.g.dart';

class EditPerfilController = _EditPerfilControllerBase
    with _$EditPerfilController;

abstract class _EditPerfilControllerBase with Store {
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
  fetchData() async {
    setMsgErro(null);
    _setRequesting(true);

    usuario = await EditPerfilRepository().getUsuario();
    _setRequesting(false);
  }

  save() async {
    if (formCliente.currentState.validate()) {
      setMsgErro(null);
      _setRequesting(true);
      try {
        await EditPerfilRepository().editar(usuario);
      } catch (e, s) {
        debugPrint('$e - $s');
        setMsgErro(e.toString());
      }

      _setRequesting(false);
    }
  }
}
