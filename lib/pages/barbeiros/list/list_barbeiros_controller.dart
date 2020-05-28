import 'package:app4geracao/model/barbeiro.dart';
import 'list_barbeiros_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'list_barbeiros_controller.g.dart';

class ListBarbeiroController = _ListBarbeiroControllerBase
    with _$ListBarbeiroController;

abstract class _ListBarbeiroControllerBase with Store {
  ListBarbeiroRepository _repository = ListBarbeiroRepository();
  @observable
  List<Barbeiro> barbeiros;
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
  _setBarbeiros(List<Barbeiro> pbarbeiros) {
    barbeiros = pbarbeiros;
  }

  fetchData() async {
    setMsgErro(null);
    _setRequesting(true);

    try {
      var list = await _repository.listBarbeiros();
      _setBarbeiros(list);
    } catch (e, s) {
      debugPrint('$e -$s');
      setMsgErro(e.toString());
    }
    _setRequesting(false);
  }

  deleteItem(Barbeiro barbeiro) async {
    setMsgErro(null);
    _setRequesting(true);

    try {
      await _repository.deleteBarbeiro(barbeiro);
      barbeiros.remove(barbeiro);
      _setBarbeiros(barbeiros);
    } catch (e, s) {
      debugPrint('$e -$s');
      setMsgErro(e.toString());
    }
    _setRequesting(false);
  }
}
