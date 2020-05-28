import 'package:app4geracao/model/barbeiro.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'save_barbeiro_repository.dart';
part 'save_barbeiro_controller.g.dart';

class SaveBarbeiroController = _SaveBarbeiroControllerBase
    with _$SaveBarbeiroController;

abstract class _SaveBarbeiroControllerBase with Store {
  @observable
  Barbeiro barbeiro = Barbeiro();
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
  setBarbeiro(Barbeiro barbeiro) {
    this.barbeiro = barbeiro;
  }

  final form = GlobalKey<FormState>();
  Future<bool> save() async {
    setMsgErro(null);
    _setRequesting(true);

    if (form.currentState.validate()) {
      try {
        await SaveBarbeiroRepository().saveBarbeiro(barbeiro);
        return true;
      } catch (e, s) {
        debugPrint('$e - $s');
        setMsgErro(e.toString());
      }
    }
    _setRequesting(false);
    return false;
  }
}
