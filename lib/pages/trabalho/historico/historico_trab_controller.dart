import 'package:app4geracao/model/trabalho.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'historico_trab_repository.dart';
part 'historico_trab_controller.g.dart';

class HistoricoTrabController = _HistoricoTrabControllerBase
    with _$HistoricoTrabController;

abstract class _HistoricoTrabControllerBase with Store {
  @observable
  List<Trabalho> trabalhos;
  @observable
  bool isRequesting = false;
  @observable
  String msgErro;
  @action
  setTrabalhos(List<Trabalho> ptrabalhos) {
    trabalhos = ptrabalhos;
  }

  @action
  setMsgErro(String msg) {
    msgErro = msg;
    isRequesting = false;
  }

  @action
  _setRequesting(bool pRequesting) {
    isRequesting = pRequesting;
  }

  fecthData() async {
    _setRequesting(true);
    setMsgErro(null);
    try {
      List<Trabalho> list =
          await HistoricoTrabRepository().listTrabalhoByCliente();
      list.sort((a, b) => a.trabTimestamp.compareTo(b.trabTimestamp));
      setTrabalhos(list);
    } catch (e, s) {
      debugPrint('$e - $s');
      setMsgErro(e.toString());
    }
    _setRequesting(false);
  }
}
