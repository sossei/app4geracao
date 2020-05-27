import 'package:app4geracao/model/servico.dart';
import 'list_servico_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'list_servico_controller.g.dart';

class ListServicoController = _ListServicoControllerBase
    with _$ListServicoController;

abstract class _ListServicoControllerBase with Store {
  @observable
  List<Servico> servicos;
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
  _setServicos(List<Servico> pServicos) {
    servicos = pServicos;
  }

  fetchData() async {
    _setRequesting(true);
    try {
      var list = await ListServicoRepository().listServico();
      _setServicos(list);
    } catch (e, s) {
      debugPrint('$e -$s');
      setMsgErro(e.toString());
    }
    _setRequesting(false);
  }

  deleteItem(Servico servico) async {
    _setRequesting(true);
    try {
      await ListServicoRepository().deleteServico(servico);
      servicos.remove(servico);
      _setServicos(servicos);
    } catch (e, s) {
      debugPrint('$e -$s');
      setMsgErro(e.toString());
    }
    _setRequesting(false);
  }
}
