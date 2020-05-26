import 'package:app4geracao/model/barbeiro.dart';
import 'package:app4geracao/model/servico.dart';
import 'package:app4geracao/model/trabalho.dart';
import 'package:app4geracao/model/usuario.dart';
import 'package:app4geracao/pages/cliente/trabalho/add/add_trab_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'add_trab_controller.g.dart';

class AddTrabController = _AddTrabControllerBase with _$AddTrabController;

abstract class _AddTrabControllerBase with Store {
  final Usuario usuario;

  Trabalho trabalho;

  @observable
  int indexServico = 0;
  @observable
  int indexBarbeiro = 0;
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
  setServico(int servico) {
    this.indexServico = servico;
  }

  @action
  setBarbeiro(int barbeiro) {
    this.indexBarbeiro = barbeiro;
  }

  _AddTrabControllerBase(this.usuario);
  List<Servico> servicos;
  List<Barbeiro> barbeiros;

  fetchData() async {
    trabalho = Trabalho();
    trabalho.usuario = usuario;
    _setRequesting(true);
    try {
      AddTrabRepository _repository = AddTrabRepository();
      servicos = await _repository.listServico();
      barbeiros = await _repository.listBarbeiro();
      _setRequesting(false);
    } catch (e, s) {
      debugPrint('$e - $s');
      setMsgErro(e.toString());
    }
  }
}
