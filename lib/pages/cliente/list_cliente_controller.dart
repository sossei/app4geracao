import 'package:app4geracao/model/usuario.dart';
import 'package:app4geracao/pages/cliente/list_cliente_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'list_cliente_controller.g.dart';

class ListClienteController = _ListClienteControllerBase
    with _$ListClienteController;

abstract class _ListClienteControllerBase with Store {
  @observable
  String filter = '';
  @observable
  List<Usuario> usuarios;
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
    msgErro = null;
    isRequesting = pRequesting;
  }

  @action
  _setUsuarios(List<Usuario> pUsuarios) {
    usuarios = pUsuarios;
  }

  @action
  filtrar(String value) {
    setMsgErro(null);
    _setRequesting(true);

    filter = value;
    _setRequesting(false);
  }

  fetchData() async {
    setMsgErro(null);
    _setRequesting(true);

    try {
      var list = await ListClienteRepository().listCliente();
      _setUsuarios(list);
    } catch (e, s) {
      debugPrint('$e -$s');
      setMsgErro(e.toString());
    }
    _setRequesting(false);
  }
}
