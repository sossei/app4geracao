import 'package:app4geracao/model/servico.dart';
import 'save_servico_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'save_servico_controller.g.dart';

class SaveServicoController = _SaveServicoControllerBase
    with _$SaveServicoController;

abstract class _SaveServicoControllerBase with Store {
  @observable
  Servico servico = Servico();
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
  setServico(Servico servico) {
    this.servico = servico;
  }

  final form = GlobalKey<FormState>();
  Future<bool> save() async {
    setMsgErro(null);
    _setRequesting(true);

    if (form.currentState.validate()) {
      try {
        await SaveServicoRepository().saveServico(servico);
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
