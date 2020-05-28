import 'package:app4geracao/model/usuario.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'edit_address_repository.dart';
part 'edit_address_controller.g.dart';

class EditAddressController = _EditAddressControllerBase
    with _$EditAddressController;

abstract class _EditAddressControllerBase with Store {
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

  final form = GlobalKey<FormState>();
  Endereco endereco = Endereco();
  Usuario usuario = Usuario();
  fetchData() async {
    setMsgErro(null);
    _setRequesting(true);

    Usuario usuario = await EditAddressRepository().getUsuario();
    endereco = usuario.endereco;
    _setRequesting(false);
  }

  save() async {
    if (form.currentState.validate()) {
      setMsgErro(null);
      _setRequesting(true);
      try {
        usuario.endereco = endereco;
        await EditAddressRepository().editar(usuario);
      } catch (e, s) {
        debugPrint('$e - $s');
        setMsgErro(e.toString());
      }

      _setRequesting(false);
    }
  }
}
