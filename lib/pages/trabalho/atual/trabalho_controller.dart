import 'package:app4geracao/model/trabalho.dart';
import 'package:app4geracao/model/usuario.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'trabalho_repositry.dart';
part 'trabalho_controller.g.dart';

class TrabalhoController = _TrabalhoControllerBase with _$TrabalhoController;

abstract class _TrabalhoControllerBase with Store {
  @observable
  Usuario usuario;
  @observable
  Trabalho trabalho;
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

  @action
  _setTrabalho(Trabalho trabalho) {
    this.trabalho = trabalho;
  }

  @action
  _setUsuario(Usuario usuario) {
    this.usuario = usuario;
  }

  saveTrabalho() async {
    setMsgErro(null);
    _setRequesting(true);
    try {
      await TrabalhoRepository().salvar(trabalho);
      fetchData();
    } catch (e, s) {
      debugPrint('$e\n$s');
      setMsgErro(e.toString());
    }
  }

  fetchData() async {
    setMsgErro(null);
    _setRequesting(true);
    try {
      _setUsuario(await TrabalhoRepository().getUsuario());
      Trabalho trab = await TrabalhoRepository().getCurrentTrabalho();
      _setTrabalho(trab != null && trab.rating == null ? trab : null);
      _setRequesting(false);
    } catch (e, s) {
      debugPrint('$e\n$s');
      setMsgErro(e.toString());
    }
  }
}
