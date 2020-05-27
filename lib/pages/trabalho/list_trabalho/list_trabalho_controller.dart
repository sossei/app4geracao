import 'package:app4geracao/model/estabelecimento.dart';
import 'package:app4geracao/model/trabalho.dart';
import 'package:app4geracao/model/usuario.dart';

import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

import 'list_trabalho_repository.dart';
part 'list_trabalho_controller.g.dart';

class ListTrabalhoController = _ListTrabalhoControllerBase
    with _$ListTrabalhoController;

abstract class _ListTrabalhoControllerBase with Store {
  @observable
  Usuario usuario;
  @observable
  Estabelecimento estabelecimento;
  @observable
  List<Trabalho> trabalhos;
  @observable
  bool isRequesting = false;
  @observable
  String msgErro;
  @observable
  String dataFormatted;
  @observable
  bool isFiltered = false;
  @action
  setUsuario(Usuario pusuario) {
    usuario = pusuario;
  }

  @action
  setFilter(bool filter) {
    isFiltered = filter;
    setTrabalhos(trabalhos);
  }

  @action
  setDataForamtted(String dataFormatted) {
    this.dataFormatted = dataFormatted;
  }

  @action
  setEstabelecimento(Estabelecimento pestabelecimento) {
    estabelecimento = pestabelecimento;
  }

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

  @action
  setData(DateTime data) {
    this.data = data;
    var formatted = formatter.format(data);
    data = formatter.parse(formatted);
    setDataForamtted(formatterPretty.format(data));
    fetchDataFilter();
  }

  DateTime data;
  var formatter = new DateFormat('yyyy-MM-dd');
  var formatterPretty = new DateFormat('dd/MM/yyyy');
  fecthData() async {
    _setRequesting(true);
    try {
      setUsuario(await ListTrabalhoRepository().getUsuario());
      setEstabelecimento(await ListTrabalhoRepository().getEstabelecimento());
      setData(DateTime.now());
      List<Trabalho> list =
          await ListTrabalhoRepository().getListTrabalho(data);
      list.sort((a, b) => a.trabTimestamp.compareTo(b.trabTimestamp));
      setTrabalhos(list);
    } catch (e, s) {
      debugPrint('$e - $s');
      setMsgErro(e.toString());
    }
    _setRequesting(false);
  }

  fetchDataFilter() async {
    _setRequesting(true);
    try {
      List<Trabalho> list =
          await ListTrabalhoRepository().getListTrabalho(data);
      list.sort((a, b) => a.trabTimestamp.compareTo(b.trabTimestamp));
      setTrabalhos(list);
    } catch (e, s) {
      debugPrint('$e - $s');
      setMsgErro(e.toString());
    }
    _setRequesting(false);
  }
}
